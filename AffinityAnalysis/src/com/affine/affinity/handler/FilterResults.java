package com.affine.affinity.handler;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;

import com.affine.affinity.persistent.HiveConnectivity;
import com.affine.affinity.to.ResultBean;
import com.affine.affinity.util.GenerateAffinityQuery;
import com.google.gson.Gson;

public class FilterResults {

	public String filter(String rundate, String level, String dept,
			String category, String affinity, String affinityValue)
			throws Exception {

		Properties prop = new Properties();

		String json = null;

		String propFileName = "resources/config.properties";

		InputStream inputStream = getClass().getClassLoader()
				.getResourceAsStream(propFileName);

		if (inputStream != null) {
			prop.load(inputStream);
		} else {
			throw new FileNotFoundException("property file '" + propFileName
					+ "' not found in the classpath");
		}

		String minSupport = prop.getProperty("MIN.SUPPORT.VALUE");
		String minConfidence = prop.getProperty("MIN.CONFIDENCE.VALUE");
		String minLift = prop.getProperty("MIN.LIFT.VALUE");

		double minSup = Double.valueOf(minSupport);
		double minConfi = Double.valueOf(minConfidence);
		double minL = Double.valueOf(minLift);

		System.out.println(" i am in selection servlet");

		if (StringUtils.isBlank(level))
			level = "Item";

		System.out.println(" Level is " + level);

		if (StringUtils.isBlank(category)
				|| category.equalsIgnoreCase("All Categories")
				|| category.equalsIgnoreCase("Select Category")) {
			category = null;
		}

		System.out.println("Category - " + category);

		GetDatesFromRundate getDates = new GetDatesFromRundate();
		if (StringUtils.isBlank(rundate))
			rundate = null;

		if (rundate.length() == 0 || rundate.length() == 1) {

			rundate = getDates.getDate(rundate);
		}
		String dates = getDates.getDatesFromRundate(rundate);

		String[] parts = dates.split(",");
		String from_date = parts[0];
		String to_date = parts[1];

		System.out.println("run - " + rundate);

		if (StringUtils.isBlank(dept)
				|| dept.equalsIgnoreCase("All Departments")
				|| dept.equalsIgnoreCase("Select Department")) {
			dept = null;
		}

		System.out.println("Department  - " + dept);

		if (StringUtils.isBlank(affinity)
				|| affinity.equalsIgnoreCase("Affinity"))
			affinity = null;
		System.out.println("Affinity  - " + affinity);

		if (StringUtils.isBlank(affinityValue))
			affinityValue = null;

		System.out.println("Affinity Threshold - " + affinityValue);

		GenerateAffinityQuery generateAffinityQuery = new GenerateAffinityQuery();

		/*
		 * String table_name = ""; String dep_desc_name_a = "";
		 * 
		 * String params = ""; String dep_desc_name_b = "";
		 * if(level.equalsIgnoreCase("Item")){
		 * 
		 * table_name = "final_item_occ_results"; dep_desc_name_a =
		 * "short_desc_a"; dep_desc_name_b = "short_desc_b"; params =
		 * "desc_a,desc_b,occ_aub,partial_lift,confidence"; } else
		 * if(level.equalsIgnoreCase("Category")) {
		 * table_name="final_cat_occ_results"; dep_desc_name_a =
		 * "short_dept_desc_a"; dep_desc_name_b = "short_dept_desc_b"; params =
		 * "cat_desc_a,cat_desc_b,occ_aub,partial_lift,confidence"; } else
		 * if(level.equalsIgnoreCase("dept")) {
		 * table_name="final_dept_occ_results"; dep_desc_name_a =
		 * "short_desc_a"; dep_desc_name_b = "short_desc_b"; params =
		 * "short_dept_desc_a,short_dept_desc_b,occ_aub,partial_lift,confidence"
		 * ; }
		 */

		if (rundate == null) {

			String res = "no date selected";
			json = new Gson().toJson(res);
			/*
			 * request.setAttribute("res","no date selected");
			 * request.getRequestDispatcher("/home.jsp").forward(request,
			 * response); return
			 */
			return json;
		}
		HiveConnectivity hiveConnectivity = new HiveConnectivity();
		Connection con = null;
		try {
			con = hiveConnectivity.getHiveConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		List<String> queries = generateAffinityQuery.getAffinityQuery(category,
				dept, affinityValue, from_date, to_date, rundate,level);
		String query = queries.get(0);
		String countQuery = queries.get(1);

		Statement stmt = null;
		Statement stmt2 = null;
		try {
			stmt = con.createStatement();
			stmt2 = con.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		ResultSet res = null;
		ResultSet res2 = null;
		try {
			res = stmt.executeQuery(query);
			res2 = stmt2.executeQuery(countQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		List<ResultBean> list = new ArrayList<ResultBean>();

		if (affinity != null) {
			if (affinity.equalsIgnoreCase("support"))
				minSup = Double.valueOf(affinityValue);
			else if (affinity.equalsIgnoreCase("confidence"))
				minConfi = Double.valueOf(affinityValue);
			else if (affinity.equalsIgnoreCase("lift"))
				minL = Double.valueOf(affinityValue);
		}
		try {
			int count = 0;
			while (res2.next()) {

				count = res2.getInt(1);
				System.out.println(" the count is " + count);
			}

			while (res.next() && count > 0) {

				ResultBean resultBean = new ResultBean();

				String itemA = "";
				String itemB = "";
				double support = 0;
				double lift = 0;
				double confidence = 0;

				itemA = res.getString(1);
				itemB = res.getString(2);
				support = res.getDouble(3) / count;

				if (support <= minSup)
					continue;

				lift = res.getDouble(4) * count;

				confidence = res.getDouble(5);
				if (confidence < minConfi | lift < minL)
					continue;

				if (itemB == null || itemA == null)
					continue;

				String item = itemA + " <b><i> , </i></b>" + itemB;
				resultBean.setRule(item);

				support = (long) (support * 1000) / 1000.0;
				confidence = (long) (confidence * 1000) / 1000.0;
				lift = (long) (lift * 1000) / 1000.0;

				resultBean.setConfidence(confidence);
				resultBean.setLift(lift);
				resultBean.setSupport(support);

				list.add(resultBean);
			}

		} catch (Exception e) {

		}

		json = new Gson().toJson(list);
		System.out.println("------------------------");
		System.out.println(json);
		return json;
	}
}

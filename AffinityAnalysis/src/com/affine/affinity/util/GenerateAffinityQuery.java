package com.affine.affinity.util;

import java.util.ArrayList;
import java.util.List;

import com.affine.affinity.handler.GenerateDeptCatMap;

public class GenerateAffinityQuery {

	private String table_name = "";
	private String dep_desc_name_a = "";

	private String params = "";
	private String dep_desc_name_b = "";

	private void populateDataSets(String level) {
		
		if (level.equalsIgnoreCase("Item")) {

			this.table_name = "final_item_occ_results";
			this.dep_desc_name_a = "short_desc_a";
			this.dep_desc_name_b = "short_desc_b";
			this.params = "desc_a,desc_b,occ_aub,partial_lift,confidence";
		} else if (level.equalsIgnoreCase("Category")) {
			
			this.table_name = "final_cat_occ_results";
			this.dep_desc_name_a = "short_dept_desc_a";
			this.dep_desc_name_b = "short_dept_desc_b";
			this.params = "cat_desc_a,cat_desc_b,occ_aub,partial_lift,confidence";
		} else if (level.equalsIgnoreCase("dept")) {
			
			this.table_name = "final_dept_occ_results";
			this.dep_desc_name_a = "short_desc_a";
			this.dep_desc_name_b = "short_desc_b";
			this.params = "short_dept_desc_a,short_dept_desc_b,occ_aub,partial_lift,confidence";
		}

	}

	public List<String> getAffinityQuery(String category, String dept,
			String affinity, String from_date, String to_date, String rundate,
			String level) {

		populateDataSets(level);
		String dep_id = GenerateDeptCatMap.dept_id_desc.get(dept);
		String cat_id = GenerateDeptCatMap.cat_id_desc.get(category);
		
		
		String query = "";
		String countQuery = "";
		List<String> queries = new ArrayList<String>();
		
		if (category != null && dept != null && affinity != null) {
			countQuery = "select count(distinct trnm) from item_trans_new2 where mbdate between '"
					+ from_date
					+ "' and '"
					+ to_date
					+ "' and dept='"
					+ dep_id
					+ "' and cat='" + cat_id + "'";
			System.out.println(countQuery);

			query = "select " + params + " from " + table_name
					+ " where rundate=\"" + rundate + "\" AND cat_desc_a=\""
					+ category + "\" AND cat_desc_b=\"" + category + "\" and "
					+ dep_desc_name_a + "=\"" + dept + "\" AND "
					+ dep_desc_name_b + "=\"" + dept + "\" ";
			System.out.println(query);

		} else if (category == null && dept != null && affinity != null) {

			countQuery = "select count(distinct trnm) from item_trans_new2 where mbdate between '"
					+ from_date
					+ "' and '"
					+ to_date
					+ "' and dept='"
					+ dep_id
					+ "'";
			System.out.println(countQuery);

			query = "select " + params + " from " + table_name
					+ " where rundate=\"" + rundate + "\" AND "
					+ dep_desc_name_a + "=\"" + dept + "\" AND "
					+ dep_desc_name_b + "=\"" + dept + "\"";
			System.out.println(query);
		} else if (category == null && dept == null && affinity != null) {
			countQuery = "select count(distinct trnm) from item_trans_new2 where mbdate between '"
					+ from_date + "' and '" + to_date + "'";
			System.out.println(countQuery);

			query = "select " + params + " from " + table_name
					+ " where rundate=\"" + rundate + "\" ";
			System.out.println(query);
		} else if (category == null && dept != null && affinity == null) {

			countQuery = "select count(distinct trnm) from item_trans_new2 where mbdate between '"
					+ from_date
					+ "' and '"
					+ to_date
					+ "' and dept='"
					+ dep_id
					+ "'";
			System.out.println(countQuery);

			query = "select " + params + " from " + table_name
					+ " where rundate=\"" + rundate + "\" AND "
					+ dep_desc_name_a + "=\"" + dept + "\" AND "
					+ dep_desc_name_b + "=\"" + dept + "\"";
			System.out.println(query);
		} else if (category == null && dept == null && affinity == null) {

			countQuery = "select count(distinct trnm) from item_trans_new2 where mbdate between '"
					+ from_date + "' and '" + to_date + "'";
			System.out.println(countQuery);

			query = "select " + params + " from " + table_name
					+ " where rundate=\"" + rundate + "\" ";
			System.out.println(query);
		} else if (category != null && dept == null && affinity == null) {

			countQuery = "select count(distinct trnm) from item_trans_new2 where mbdate between '"
					+ from_date
					+ "' and '"
					+ to_date
					+ "' and dept='"
					+ dep_id
					+ "' and cat='" + cat_id + "'";
			System.out.println(countQuery);

			query = "select " + params + " from " + table_name
					+ " where rundate=\"" + rundate + "\" AND cat_desc_a=\""
					+ category + "\" AND cat_desc_b=\"" + category + "\" ";
			System.out.println(query);
		} else if (category != null && dept != null && affinity == null) {

			countQuery = "select count(distinct trnm) from item_trans_new2 where mbdate between '"
					+ from_date
					+ "' and '"
					+ to_date
					+ "' and dept='"
					+ dep_id
					+ "' and cat='" + cat_id + "'";
			System.out.println(countQuery);

			query = "select " + params + " from " + table_name
					+ " where rundate=\"" + rundate + "\" AND cat_desc_a=\""
					+ category + "\" AND cat_desc_b=\"" + category + "\" AND "
					+ dep_desc_name_a + "=\"" + dept + "\" AND "
					+ dep_desc_name_b + "=\"" + dept + "\"";
			System.out.println(query);
		} else if (category != null && dept == null && affinity != null) {

			countQuery = "select count(distinct trnm) from item_trans_new2 where mbdate between '"
					+ from_date
					+ "' and '"
					+ to_date
					+ "' and dept='"
					+ dep_id
					+ "' and cat='" + cat_id + "'";
			System.out.println(countQuery);

			query = "select " + params + " from " + table_name
					+ " where rundate=\"" + rundate + "\" AND cat_desc_a=\""
					+ category + "\" AND cat_desc_b=\"" + category + "\" ";
			System.out.println(query);
		} else if (category != null && dept != null && affinity != null) {

			countQuery = "select count(distinct trnm) from item_trans_new2 where mbdate between '"
					+ from_date
					+ "' and '"
					+ to_date
					+ "' and dept='"
					+ dep_id
					+ "' and cat='" + cat_id + "'";
			System.out.println(countQuery);

			query = "select " + params + " from " + table_name
					+ " where rundate=\"" + rundate + "\" AND cat_desc_a=\""
					+ category + "\" AND cat_desc_b=\"" + category + "\" AND "
					+ dep_desc_name_a + "=\"" + dept + "\" AND "
					+ dep_desc_name_b + "=\"" + dept + "\"";
			System.out.println(query);
		}
		queries.add(query);
		queries.add(countQuery);
		return queries;
	}
}

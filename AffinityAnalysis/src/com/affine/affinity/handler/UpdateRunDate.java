package com.affine.affinity.handler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.google.gson.Gson;

public class UpdateRunDate {

	public String update() {
				
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"resources/applicationContext.xml");

		DataSource dataSource = (DataSource) context.getBean("dataSource");

		Connection conn = null;
		try {
			conn = dataSource.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		String sql = "select run_date from run_history order by run_date desc";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ResultSet rs = null;

		try {
			rs = ps.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Map<Integer, String> map = new HashMap<Integer, String>();

		int num_count = 0;
		try {
			while (rs.next()) {

				String run_date = rs.getString(1);
				run_date = run_date.substring(0, run_date.length() - 2);
				map.put(num_count++, run_date);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String json = null;

		json = new Gson().toJson(map);
		System.out.println("------------------------");
		System.out.println(json);
		/*response.setContentType("application/json");
		response.getWriter().write(json);*/
		return json;
	}
}

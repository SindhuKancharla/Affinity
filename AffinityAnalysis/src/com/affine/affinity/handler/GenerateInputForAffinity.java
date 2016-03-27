package com.affine.affinity.handler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.sql.DataSource;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.affine.affinity.persistent.JoinTablesForAlgo;
import com.affine.affinity.util.PropertiesConfigHolder;

public class GenerateInputForAffinity {
	ApplicationContext context = null;

	private String msgSuccess = "The processing is complete and results are saved in our database.";
	//private String noDataError = "The dates entered are beyond our transactions range. Please enter a valid date range.";
	//private String connectError = "There is a problem while connecting to the server.Please try again after some time. Thanks for your patience :)";
	
	/*public void updateConfigFile(String minSupport, String minConfidence, String minLift){
				
		String propFileName = "resources/config.properties";
		
		try {
			PropertiesConfiguration config = new PropertiesConfiguration(propFileName);
			
			config.setProperty("MIN.SUPPORT.VALUE", minSupport);
			config.setProperty("MIN.CONFIDENCE.VALUE", minConfidence);

			config.setProperty("MIN.LIFT.VALUE", minLift);

			config.save();
		} catch (ConfigurationException e) {
			e.printStackTrace();
		}
	}
*/	
	public GenerateInputForAffinity() {
		context = new ClassPathXmlApplicationContext(
				"resources/applicationContext.xml");
	}

	public String runAffinityAlgo(String fromDate, String toDate)
	{

		String[] parts = fromDate.split("/");
		String fromDateMonth = parts[0];

		String fromDateDay = parts[1];

		String fromDateYear = parts[2];

		String[] toParts = toDate.split("/");
		String toDateMonth = toParts[0];

		String toDateDay = toParts[1];

		String toDateYear = toParts[2];

		String fromDateNew = fromDateYear + "-" + fromDateMonth + "-"
				+ fromDateDay;
		String toDateNew = toDateYear + "-" + toDateMonth + "-" + toDateDay;

		Date rundate = new Date();

		String dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(rundate);

		PropertiesConfigHolder ch = (PropertiesConfigHolder) context
				.getBean("configHolder");

		CalculateAffinity ca = new CalculateAffinity();

		String resultMsg = ca.runAffinityAlgorith(fromDateNew, toDateNew,
				dateString, ch);
		if (resultMsg.equalsIgnoreCase(msgSuccess)) {

			try {
				JoinTablesForAlgo obj = new JoinTablesForAlgo();
				obj.joinTempResultAndMasterTables("item");

				obj.joinTempResultAndMasterTables("dept");

				obj.joinTempResultAndMasterTables("cat");
				saveRunDateInMysql(fromDateNew, toDateNew, dateString);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} /*else if(resultMsg.equalsIgnoreCase(noDataError)){
			output = noDataError;
		}
		else if(resultMsg.equalsIgnoreCase(connectError)){
			output = connectError;
		}*/
		return resultMsg;
	}

	protected void saveRunDateInMysql(String fromDateNew, String toDateNew,
			String dateString) {

		DataSource dataSource = (DataSource) context.getBean("dataSource");

		Connection conn = null;
		try {
			conn = dataSource.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		String sql = " Insert into run_history values (\"" + dateString
				+ "\",\"" + fromDateNew + "\",\"" + toDateNew + "\");";
		try {
			System.out.println(sql);
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	public static void main(String[] args) {
String propFileName = "resources/config.properties";
		
		try {
			PropertiesConfiguration config = new PropertiesConfiguration(propFileName);
			
			config.setProperty("MIN.SUPPORT.VALUE", "ert");
			config.setProperty("MIN.CONFIDENCE.VALUE", "sdf");

			config.setProperty("MIN.LIFT.VALUE", "345");

			config.save();
			System.out.println("done");
			System.out.println(config.getProperty("MIN.LIFT.VALUE"));
		} catch (ConfigurationException e) {
			e.printStackTrace();
		}
	}
}

package com.affine.affinity.persistent;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
 
public class HiveConnectivity {
	
  private static String driverName = "org.apache.hive.jdbc.HiveDriver";
 
  /**
   * 
   * Get Connection to HIVE
   * Reads config values from config.properties file .. Change the values accordingly
   * @author Sindhu
   * @param args
   * @throws SQLException
   * @throws IOException 
   */
  public Connection getHiveConnection() throws SQLException, IOException {
    
	try {
      Class.forName(driverName);
    } catch (ClassNotFoundException e) {
      e.printStackTrace();
      System.exit(1);
    }

    Properties prop = new Properties();
		
    String propFileName = "resources/config.properties";
    

	InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
	 
	if (inputStream != null) {
		prop.load(inputStream);
	} else {
		throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
	}

	String serverIp = prop.getProperty("HDFS.SERVER.IP");
	String dbname = prop.getProperty("HIVE.DATABASE");
	String hiveport = prop.getProperty("HIVE.PORT");
	String username  = prop.getProperty("HIVE.USERNAME");
	
	String connUrl = "jdbc:hive2://"+serverIp+":"+hiveport+"/"+dbname+"";
    Connection con = DriverManager.getConnection(connUrl, username, "");
    
	return con;
  }
}
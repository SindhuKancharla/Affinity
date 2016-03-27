package com.affine.affinity.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class GetFileNameFromFilters {

	public String getFolderName() throws IOException{
		
		Properties prop = new Properties();
		
		String filename = "";
		
		String propFileName = "resources/config.properties";
		
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
		 
		if (inputStream != null) {
			prop.load(inputStream);
		} else {
			throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
		}
			
		filename=prop.getProperty("DEMO.FOLDER.LOCATION");
		
		return filename;
	}

	public String getFileName(String level,String dept, String catg) throws IOException {
		
		String filename = "";
		String folderPath = getFolderName();
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("food") && catg.equalsIgnoreCase("spices")){
			filename = folderPath+"Item_to_item_Food_Spices.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("liquor") && catg.equalsIgnoreCase("fine wine")){
			filename=folderPath+"Item_to_item_Liquor_finewine.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("liquor") && catg.equalsIgnoreCase("floor wines")){
			filename = folderPath+"Item_to_item_Liquor_floorwine.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("liquor") && catg.equalsIgnoreCase("all categories")){
			filename=folderPath+"Item_to_item_Liquor_AllCategories.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("deli") && catg.equalsIgnoreCase("cheese")){
			filename=folderPath+"Item_to_item_Deli_Cheese.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("deli") && catg.equalsIgnoreCase("ethnic")){
			filename=folderPath+"Item_to_item_Deli_Ethenic.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("deli") && catg.equalsIgnoreCase("all categories")){
			filename=folderPath+"Item_to_item_Deli_AllCategories.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("food") && catg.equalsIgnoreCase("beverages")){
			filename=folderPath+"Item_to_item_Food_Beverages.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("food") && catg.equalsIgnoreCase("cereal")){
			filename=folderPath+"Item_to_item_Food_Cereal.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("food") && catg.equalsIgnoreCase("all categories")){
			filename=folderPath+"Item_to_item_Food_AllCategories.csv";
		}
		if(level.equalsIgnoreCase("category") && dept.equalsIgnoreCase("food")){
			filename=folderPath+"Cat_to_Cat_Food.csv";
		}
		if(level.equalsIgnoreCase("category") && dept.equalsIgnoreCase("liquor")){
			filename=folderPath+"Cat_to_Cat_Liquor.csv";
		}
		if(level.equalsIgnoreCase("category") && dept.equalsIgnoreCase("deli")){
			filename=folderPath+"Cat_to_Cat_Deli.csv";
		}
		if(level.equalsIgnoreCase("category") && dept.equalsIgnoreCase("all departments")){
			filename=folderPath+"Cat_to_Cat_AllDepartments.csv";
		}
		if(level.equalsIgnoreCase("dept")){
			filename=folderPath+"dept_to_dept.csv";
		}
		if(level.equalsIgnoreCase("item") && dept.equalsIgnoreCase("all departments") && catg.equalsIgnoreCase("all categories")){
			filename=folderPath+"itemtoitem1.csv";
		}
		return filename;			
	}
}

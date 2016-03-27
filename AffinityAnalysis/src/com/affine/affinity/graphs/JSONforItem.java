package com.affine.affinity.graphs;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class JSONforItem {
	
	List<String> depList = new ArrayList<String>();
	Map<String,Double> mapRuleSup = new HashMap<String, Double>();
	
	public static void main(String[] args) throws JSONException, IOException{
		
		JSONforItem ob = new JSONforItem();
		JSONObject json = new JSONObject();
		
		JSONArray nodes = new JSONArray();
		json.put("nodes"	, nodes);
		
				
		List<String> all_depts = ob.depList;
		
		JSONArray links = ob.readFromExcel(all_depts);
		json.put("links", links);

		int grp = 1;
		for(String dep : all_depts){
			
			JSONObject depjson = new JSONObject();
			depjson.put("name", dep);
			depjson.put("group", grp);
			nodes.put(depjson);
		}
		
		System.out.println(json);

	}
	
	public JSONArray readFromExcel(List<String> all_depts) throws IOException{
		
		Properties prop = new Properties();
		
		String propFileName = "resources/configtest.properties";
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);

		if (inputStream != null) {
			prop.load(inputStream);
		} else {
			throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
		}
		
		
		String localFilePath = prop.getProperty("localfilePath");
		String localFileName = prop.getProperty("localFileName");
		
		localFileName = localFileName.replace(".csv", ".xls");
		
		JSONArray links = new JSONArray();

		try
        {
            FileInputStream file = new FileInputStream(new File(localFilePath+localFileName));
 
            HSSFWorkbook workbook = new HSSFWorkbook(file);
 
            //Get first/desired sheet from the workbook
            HSSFSheet sheet = workbook.getSheetAt(0);
 
            boolean check = false;
            int count = 0;
            //Iterate through each rows one by one
            Iterator<Row> rowIterator = sheet.iterator();
            while (rowIterator.hasNext())
            {
                Row row = rowIterator.next();
                //For each row, iterate through all the columns
                Iterator<Cell> cellIterator = row.cellIterator();
                 
                String itemA = "";
                String itemB = "";
                String sup = "";
                while (cellIterator.hasNext())
                {
                    Cell cell = cellIterator.next();
                    Object id = null;
                    switch(cell.getCellType()) {
	                    case Cell.CELL_TYPE_BOOLEAN:
	                    	id = cell.getBooleanCellValue();
	                        break;
	                    case Cell.CELL_TYPE_NUMERIC:
	                    	id=cell.getNumericCellValue();
	                        break;
	                    case Cell.CELL_TYPE_STRING:
	                    	id = cell.getStringCellValue();
	                        break;
	                }
                    
                    String va = String.valueOf(id);
                	va = va.substring(0, va.length()-2);
                		
                	
                    if(cell.getColumnIndex()==0){
                    	continue;
                    }
                    else if(cell.getColumnIndex()==1){
                    	
                    	String val = String.valueOf(id);
                    	String[] parts = val.split(",");
                    	
                    	itemA = parts[0].trim();
                    	itemB = parts[1].trim();
                    	
                    	if(depList.contains(itemB)||depList.contains(itemA)){
                    		check = true;
                    	}
                    	
	                	if(!depList.contains(itemA) && depList.size()<50){
	                		depList.add(itemA);
	                	}
	                	if(!depList.contains(itemB) && depList.size()<50){
	                		depList.add(itemB);
	                	}
                    	
                    }
                    else if(cell.getColumnIndex()==2){

                    	if(check){
                    	
	                    	sup = String.valueOf(id);
	                    	System.out.println(" sup is "+sup);
                    	}
                    	
                    }     
                    
                }
                
                if(check){
                	int ia = Integer.valueOf(all_depts.indexOf(itemA));
                	int ib = Integer.valueOf(all_depts.indexOf(itemB));
                	if(!sup.isEmpty() && ia!= -1 && ib!=-1){
		                JSONObject jsonObject = new JSONObject();
		               
		                jsonObject.put("source", ia);
		                jsonObject.put("target", ib);
		                jsonObject.put("value", Double.valueOf(sup));
		            
		                
		                links.put(jsonObject);
                	}
                }
            }
            file.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
		
		return links;
	}
}

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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;


public class CreateJSONForMatrixDep {

	
	List<String> depList = new ArrayList<String>();
	Map<String,Double> mapRuleSup = new HashMap<String, Double>();
	
	public static void main(String[] args) throws JSONException, IOException{
		
		CreateJSONForMatrixDep ob = new CreateJSONForMatrixDep();
		JSONObject json = new JSONObject();
		
		JSONArray nodes = new JSONArray();
		json.put("nodes"	, nodes);
		
				
		List<String> all_depts = ob.depList;
		
		JSONArray links = ob.readFromExcel(all_depts);
		json.put("links", links);

		int grp = 1;
		for(String dep : all_depts){
			 
			JSONObject depjson = new JSONObject();
			depjson.put("dep", dep);
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
                    	
                    	if(!depList.contains(itemA)){
                    		depList.add(itemA);
                    	}
                    	if(!depList.contains(itemB)){
                    		depList.add(itemB);
                    	}
                    }
                    else if(cell.getColumnIndex()==2){
                    	//int intval = (int) ((double)id*100);
                    	sup = String.valueOf(id);
                    	System.out.println(" sup is "+sup);
                    }     
                    else{
                    	continue;
                    }
                }
                
                JSONObject jsonObject = new JSONObject();
                if(itemA=="" | itemB=="")
                	continue;
                
                
                jsonObject.put("source", Integer.valueOf(all_depts.indexOf(itemA)));
                jsonObject.put("target", Integer.valueOf(all_depts.indexOf(itemB)));
                jsonObject.put("value", Double.valueOf(sup));
            
                
                links.put(jsonObject);
                
                System.out.println("");
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

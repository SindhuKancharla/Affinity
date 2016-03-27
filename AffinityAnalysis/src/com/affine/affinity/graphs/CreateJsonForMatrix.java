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


public class CreateJsonForMatrix {

	
	List<String> depList = new ArrayList<String>();
	Map<String,Double> mapRuleSup = new HashMap<String, Double>();
	
	public static void main(String[] args) throws JSONException, IOException{
		
		CreateJsonForMatrix ob = new CreateJsonForMatrix();
		JSONObject json = new JSONObject();
		
		JSONArray nodes = new JSONArray();
		json.put("nodes"	, nodes);
		
				
		List<String> all_depts = ob.depList;
		
		JSONArray links = ob.readFromExcel(all_depts);
		json.put("links", links);

		for(String dep : all_depts){
			
			JSONObject depjson = new JSONObject();
			depjson.put("dep", Integer.valueOf(dep));
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
 
            //Create Workbook instance holding reference to .xlsx file
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
                double sup = 0;
                while (cellIterator.hasNext())
                {
                    Cell cell = cellIterator.next();
                    //Check the cell type and format accordingly
                    
                            double id = cell.getNumericCellValue();
                            
                            String va = String.valueOf(id);
                        	va = va.substring(0, va.length()-2);
                        		
                        	
                        	
                        	
                            if(cell.getColumnIndex()==0){
                            	
                            	String val = String.valueOf(id);
                            	val = val.substring(0, val.length()-2);
                            	itemA = val;
                            
                            	if(!depList.contains(va)){
                            		depList.add(va);
                            	}
                            	
                            }
                            else if(cell.getColumnIndex()==1){
                            	
                            	String val = String.valueOf(id);
                            	val = val.substring(0, val.length()-2);
                            	itemB = val;
                            	
                            	if(!depList.contains(va)){
                            		depList.add(va);
                            	}
                            	
                            }
                            else if(cell.getColumnIndex()==2){
                            	
                          
                            	sup = id;
                            	
                            	System.out.println(" sup is "+sup);
                            }     
                            else{
                            	break;
                            }
                    }
                
                JSONObject jsonObject = new JSONObject();
                if(itemA=="" | itemB=="")
                	continue;
                
                
                jsonObject.put("source", Integer.valueOf(all_depts.indexOf(itemA)));
                jsonObject.put("target", Integer.valueOf(all_depts.indexOf(itemB)));
                jsonObject.put("value", Double.valueOf(sup));
                
                if(sup==0)
                	continue;
                
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

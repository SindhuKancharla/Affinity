package com.affine.affinity.graphs;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import com.affine.affinity.to.SampleDataTO;


public class JSONForScatterPlot {

	
	List<String> depList = new ArrayList<String>();
	Map<String,Double> mapRuleSup = new HashMap<String, Double>();
	
	/*public static void main(String[] args) throws JSONException, IOException{
		
		JSONForScatterPlot ob = new JSONForScatterPlot();
		
		JSONArray nodes = ob.readFromExcel();
		
		
		System.out.println(nodes);

	}*/
	
	public List<SampleDataTO> readFromExcel(String filename) throws IOException{
		
		/*Properties prop = new Properties();
		
		String propFileName = "resources/configtest.properties";
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);

		if (inputStream != null) {
			prop.load(inputStream);
		} else {
			throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
		}
		
		
		String localFilePath = prop.getProperty("localfilePath");
		String localFileName = prop.getProperty("localFileName");
		
		localFileName = localFileName.replace(".csv", ".xls");*/
		
/*		JSONArray links = new JSONArray();
*/		List<SampleDataTO> listResponse = new ArrayList<SampleDataTO>();
		
		try
        {
			filename = filename.replace(".csv", ".xls");

			System.out.println(filename);
            FileInputStream file = new FileInputStream(new File(filename));
 
            HSSFWorkbook workbook = new HSSFWorkbook(file);
 
            //Get first/desired sheet from the workbook
            HSSFSheet sheet = workbook.getSheetAt(0);
 
            //Iterate through each rows one by one
            Iterator<Row> rowIterator = sheet.iterator();
            while (rowIterator.hasNext())
            {
                Row row = rowIterator.next();
                if(row.getRowNum()==0)
                	continue;
                //For each row, iterate through all the columns
                Iterator<Cell> cellIterator = row.cellIterator();
                 
           
                String lift = "";
                String rule = "";
                String conf = "";
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
                    	rule=val;
                    }
                    else if(cell.getColumnIndex()==2){
                    	//int intval = (int) ((double)id*100);
                    	sup = String.valueOf(id);
                    	System.out.println(" sup is "+sup);
                    }     
                    else if(cell.getColumnIndex()==3){
                    	//int intval = (int) ((double)id*100);
                    	lift = String.valueOf(id);
                    }  
                    else if(cell.getColumnIndex()==4){
                    	//int intval = (int) ((double)id*100);
                    	conf = String.valueOf(id);
                    }  
                }
                
               // JSONObject jsonObject = new JSONObject();
                SampleDataTO sample = new SampleDataTO();
                
                /*jsonObject.put("support", Double.valueOf(sup));
                jsonObject.put("lift", Double.valueOf(lift));
                jsonObject.put("confidence", Double.valueOf(conf));
                jsonObject.put("rule", rule);
                */
                sample.setConfidence(Double.valueOf(conf));
                sample.setLift(Double.valueOf(lift));
                sample.setSupport(Double.valueOf(sup));
                sample.setRule(rule);
                
                listResponse.add(sample);
                //links.put(jsonObject);
                
            }
            file.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
		return listResponse;
	}
}

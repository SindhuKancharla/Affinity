package com.affine.affinity.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.affine.affinity.to.SampleDataTO;

public class GenerateJsonForScatterPlotFromCSV {

    private static final String COMMA_DELIMITER = ",";

	public List<SampleDataTO> readFromExcel(String filename) throws IOException{
		
        BufferedReader fileReader = null;
		List<SampleDataTO> listResponse = new ArrayList<SampleDataTO>();
		
		try
        {
			 System.out.println(filename);
			
			 String line = "";

	         fileReader = new BufferedReader(new FileReader(filename));

	         fileReader.readLine();

	         while ((line = fileReader.readLine()) != null) {
	                String[] tokens = line.split(COMMA_DELIMITER);
           
	                String lift = tokens[4] ;
	                String rule = tokens[1].concat(",").concat(tokens[2]);
	                String conf = tokens[5];
	                String sup = tokens[3];
	                              
	                SampleDataTO sample = new SampleDataTO();
	                
	                sample.setConfidence(Double.valueOf(conf));
	                sample.setLift(Double.valueOf(lift));
	                sample.setSupport(Double.valueOf(sup));
	                sample.setRule(rule);
	                
	                listResponse.add(sample);
            }
	        fileReader.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
		return listResponse;
	}
}

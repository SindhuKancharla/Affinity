package com.affine.affinity.util;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import antlr.StringUtils;

import com.affine.affinity.to.SampleDataTO;
public class CSVDataUtil {
	 //Delimiter used in CSV file

    private static final String COMMA_DELIMITER = ",";
    //CSV attributes index

    private static final int SL_NO =0 ;

    private static final int RULE = 1;

    private static final int SUPPORT_VALUE = 3;

    private static final int LIFT_VALUE = 4;

    private static final int CONFIDENCE_VALUE = 5;

    public static List<SampleDataTO> readCsvFile(String fileName,String affinity,String val) {
        BufferedReader fileReader = null;
        List<SampleDataTO> students=null;
        
        System.out.println(affinity);
        float aval=0;
        if(org.apache.commons.lang.StringUtils.isNotBlank(affinity))
        	aval=Float.parseFloat(val);

        try {
            //Create a new list of student to be filled by CSV file data
            students = new ArrayList<SampleDataTO>();
            String line = "";
            //Create the file reader

            fileReader = new BufferedReader(new FileReader(fileName));
            //Read the CSV file header to skip it

            fileReader.readLine();
            //Read the file line by line starting from the second line

            while ((line = fileReader.readLine()) != null) {
                //Get all tokens available in line
                String[] tokens = line.split(COMMA_DELIMITER);

                if (tokens.length > 0 ) {
                	
                	if(org.apache.commons.lang.StringUtils.isNotBlank(affinity)){
	                     if(affinity.equalsIgnoreCase("support") && Float.parseFloat(tokens[3])> aval ){
	                    	 SampleDataTO student=new SampleDataTO(tokens[0], tokens[1].concat(",").concat(tokens[2]), tokens[3], tokens[4], tokens[5]);
	                     	students.add(student);
	                    	 
	                     }
	                     else if(affinity.equalsIgnoreCase("lift") && Float.parseFloat(tokens[4])> aval ){
	                    	 SampleDataTO student=new SampleDataTO(tokens[0], tokens[1].concat(",").concat(tokens[2]), tokens[3], tokens[4], tokens[5]);
	                     	students.add(student);	 
	                     }
	                     else if(affinity.equalsIgnoreCase("confidence") && Float.parseFloat(tokens[5])> aval ){
	                    	 SampleDataTO student=new SampleDataTO(tokens[0], tokens[1].concat(",").concat(tokens[2]), tokens[3], tokens[4], tokens[5]);
	                     	students.add(student);
	                     }
                	}
                	else {
                		SampleDataTO student=new SampleDataTO(tokens[0], tokens[1].concat(",").concat(tokens[2]), tokens[3], tokens[4], tokens[5]);
                     	students.add(student);
                	}
                     //System.out.println(tokens[0]);                   
                	//SampleDataTO student = new SampleDataTO(tokens[SL_NO], tokens[RULE].concat(tokens[2]), tokens[SUPPORT_VALUE], tokens[LIFT_VALUE]), tokens[CONFIDENCE_VALUE]);
                	/*SampleDataTO student=new SampleDataTO(tokens[0], tokens[1].concat(",").concat(tokens[2]), tokens[3], tokens[4], tokens[5]);
                	students.add(student);*/
                }
            }
            /*//Print the new student list

            for (SampleDataTO student : students) {

                System.out.println(student.toString());
            }
*/
        }

        catch (Exception e) {

            System.out.println("Error in CsvFileReader !!!");
            e.printStackTrace();

        } finally {
            try {
                fileReader.close();
            } catch (IOException e) {
                System.out.println("Error while closing fileReader !!!");
                e.printStackTrace();
            }
        }
       return students;
    }
} 

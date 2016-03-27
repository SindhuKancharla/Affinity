package com.affine.affinity.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.affine.affinity.to.SampleDataTO;

public class GenerateJsonForMatrixPlotFromCSV {

	private static final String COMMA_DELIMITER = ",";

	List<String> depList = new ArrayList<String>();

	public JSONObject getNodesAndLinks(String filename) throws JSONException{
		
	
		JSONObject json = new JSONObject();
		
		JSONArray nodes = new JSONArray();
		json.put("nodes"	, nodes);
		
		List<String> all_depts = this.depList;
		
		JSONArray links = this.makeJson(filename,all_depts);
		json.put("links", links);

		int grp = 1;
		for(String dep : all_depts){
			 
			JSONObject depjson = new JSONObject();
			depjson.put("name", dep);
			depjson.put("group", grp);
			nodes.put(depjson);
		}
		
		System.out.println(json);
		
		
		return json;
	}
	
	public JSONArray makeJson(String filename, List<String> all_depts) {

		BufferedReader fileReader = null;
		JSONArray links = new JSONArray();

		try {
			System.out.println(filename);

			String line = "";

			fileReader = new BufferedReader(new FileReader(filename));

			fileReader.readLine();

			while ((line = fileReader.readLine()) != null) {
				String[] tokens = line.split(COMMA_DELIMITER);

				Double lift = Double.valueOf(tokens[4]);
				String itemA = tokens[1];
				String itemB = tokens[2];
				Double conf = Double.valueOf(tokens[5]);
				Double sup = Double.valueOf(tokens[3]);

				if (!depList.contains(itemA)) {
					depList.add(itemA);
				}
				if (!depList.contains(itemB)) {
					depList.add(itemB);
				}

				JSONObject jsonObject = new JSONObject();
				if (itemA == "" | itemB == "")
					continue;

				jsonObject.put("source",
						Integer.valueOf(all_depts.indexOf(itemA)));
				jsonObject.put("target",
						Integer.valueOf(all_depts.indexOf(itemB)));
				jsonObject.put("value", Double.valueOf(sup)*1000);

				links.put(jsonObject);
			}
			fileReader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return links;
	}

}

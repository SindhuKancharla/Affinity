package com.affine.affinity.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.affine.affinity.handler.GenerateInputForAffinity;
import com.affine.affinity.handler.UpdateRunDate;
import com.affine.affinity.to.AffinityResponse;
import com.affine.affinity.to.SampleDataTO;
import com.affine.affinity.util.GenerateJsonForMatrixPlotFromCSV;
import com.affine.affinity.util.GenerateJsonForScatterPlotFromCSV;
import com.affine.affinity.util.GetFileNameFromFilters;
import com.google.gson.Gson;

@Controller
public class AffinityController {

	@RequestMapping(value = "calculateAffinity", method = RequestMethod.GET)
	public void home(@RequestParam("from") String fromDate,@RequestParam("to") String toDate) {
	
		System.out.println(fromDate + toDate);
		
		GenerateInputForAffinity generateInputForAffinity=new GenerateInputForAffinity();
		//generateInputForAffinity.updateConfigFile(minSupport,minConfidence,minLift);
		String opJson = null;
		opJson = generateInputForAffinity.runAffinityAlgo(fromDate, toDate);
		
		System.out.println("con "+opJson);
	
		AffinityResponse res= new AffinityResponse();
		res.setMsg(opJson);
		//return res;	
	}
	
	@RequestMapping(value = "UpdateRundate", method = RequestMethod.GET)
	public @ResponseBody AffinityResponse updateRundate() {
				
		UpdateRunDate updateRunDate = new UpdateRunDate();
		String updateRundateMap = updateRunDate.update();
		AffinityResponse res= new AffinityResponse();
		res.setUpdateRundateJSON(updateRundateMap);
		System.out.println(res);
		return res;			
	}
	
	@RequestMapping(value = "FilterController", method = RequestMethod.GET)
	public @ResponseBody AffinityResponse filter(@RequestParam("rundate") String rundate,@RequestParam("level") String level) {
				
		AffinityResponse res= new AffinityResponse();
		List<String> jsonList = new ArrayList<String>();
		Map<String,List<String>> dept_cat_map = new HashMap<String, List<String>>();

		/*GenerateDeptCatMap generateDeptCatMap = new GenerateDeptCatMap();
		AffinityResponse res= new AffinityResponse();

		if(rundate.equalsIgnoreCase("20/04/15")){
			
		}
		List<String> jsonlist = new ArrayList<String>();
		try {
			
			if(rundate.length()!=19){
				
				GetDatesFromRundate getDatesFromRundate = new GetDatesFromRundate();
				rundate = getDatesFromRundate.getDate(rundate);
			}
			
			System.out.println("rundate in controller -- "+rundate);
				jsonlist = generateDeptCatMap.generateDepartmentsFromRundate(rundate,level);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		List<String> all_depts = new ArrayList<String>();
		all_depts.add("ALL DEPARTMENTS");
		all_depts.add("LIQUOR");
		all_depts.add("FOOD");
		all_depts.add("DELI");
		
		List<String> temp = new ArrayList<String>();
		temp.add("ALL CATEGORIES");
		temp.add("FINE WINE");
		temp.add("FLOOR WINES");
		Collections.sort(temp);
		dept_cat_map.put("LIQUOR",temp);
		
		List<String> temp1 = new ArrayList<String>();
		temp1.add("ALL CATEGORIES");
		temp1.add("BEVERAGES");
		temp1.add("CEREAL");
		temp1.add("SPICES");
		Collections.sort(temp1);
		dept_cat_map.put("FOOD",temp1);
		
		List<String> temp11 = new ArrayList<String>();
		temp11.add("ALL CATEGORIES");
		temp11.add("CHEESE");
		temp11.add("ETHNIC");
		Collections.sort(temp11);
		dept_cat_map.put("DELI",temp11);

		List<String> temp111 = new ArrayList<String>();
		temp111.add("ALL CATEGORIES");
		dept_cat_map.put("ALL DEPARTMENTS", temp111);
		Collections.sort(all_depts);
		String json = null;
	    json= new Gson().toJson(all_depts);  
	    String json_dept_cat_map = new Gson().toJson(dept_cat_map);
	    	    
	    jsonList.add(json);
	    jsonList.add(json_dept_cat_map);
	    
	    System.out.println(json);
	    System.out.println(jsonList);
		res.setDepList(jsonList.get(0));
		res.setDept_cat_map(jsonList.get(1));
		
		return res;
	}
	
	@RequestMapping(value = "ScatterPlotController", method = RequestMethod.GET)
	public @ResponseBody List<SampleDataTO> select(@RequestParam("rundate") String rundate,
			@RequestParam("level") String level,@RequestParam("dept") String dept,
			@RequestParam("catg") String cat,@RequestParam("affinity") String affinity,
			@RequestParam("affinityval") String affinityValue) throws Exception {
				
		GetFileNameFromFilters getFileNameFromFilters = new GetFileNameFromFilters();
		
		String filename = getFileNameFromFilters.getFileName(level, dept, cat);	
		
		GenerateJsonForScatterPlotFromCSV ob = new GenerateJsonForScatterPlotFromCSV();
		
		List<SampleDataTO> nodes = ob.readFromExcel(filename);
		System.out.println(nodes);
		return nodes;		
	}
	
	@RequestMapping(value = "MatrixPlotController", method = RequestMethod.GET)
	public @ResponseBody JSONObject matrix(@RequestParam("rundate") String rundate,
			@RequestParam("level") String level,@RequestParam("dept") String dept,
			@RequestParam("catg") String cat,@RequestParam("affinity") String affinity,
			@RequestParam("affinityval") String affinityValue) throws Exception {
				
		GetFileNameFromFilters getFileNameFromFilters = new GetFileNameFromFilters();
		
		String filename = getFileNameFromFilters.getFileName(level, dept, cat);	
		
		GenerateJsonForMatrixPlotFromCSV ob = new GenerateJsonForMatrixPlotFromCSV();
		
		JSONObject nodes = ob.getNodesAndLinks(filename);
		System.out.println(" Matrix plot op = "+nodes);
		
		
		return nodes;		
	}
}
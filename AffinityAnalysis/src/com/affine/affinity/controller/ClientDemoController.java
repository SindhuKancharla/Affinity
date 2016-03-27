package com.affine.affinity.controller;

import java.io.IOException;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.affine.affinity.to.SampleDataTO;
import com.affine.affinity.util.CSVDataUtil;
import com.affine.affinity.util.GetFileNameFromFilters;

@Controller
public class ClientDemoController {
	
	
	
	
	@RequestMapping(value = "SelectionController", method = RequestMethod.GET)
	public @ResponseBody List<SampleDataTO> getDeptData(@RequestParam("level") String level,@RequestParam("dept") String dept,@RequestParam("catg") String catg,@RequestParam("affinity") String affinity,@RequestParam("affinityval") String affinityval) throws IOException {
		
		List<SampleDataTO> resto=null;

		GetFileNameFromFilters getFileNameFromFilters = new GetFileNameFromFilters();
		
		String filename = getFileNameFromFilters.getFileName(level, dept, catg);
		resto=CSVDataUtil.readCsvFile(filename,affinity,affinityval);
		System.out.println("sent successfully "+resto.size());
		
		
		return resto;			
	}
	
	@RequestMapping(value = "StrategiesController", method = RequestMethod.GET)
	public @ResponseBody List<SampleDataTO> getStrategies(@RequestParam("level") String level,@RequestParam("dept") String dept,@RequestParam("catg") String catg) throws IOException {
		
		List<SampleDataTO> resto=null;

		GetFileNameFromFilters getFileNameFromFilters = new GetFileNameFromFilters();
		
		String filename = getFileNameFromFilters.getFileName(level, dept, catg);
		resto=CSVDataUtil.readCsvFile(filename,null,null);
		System.out.println("sent successfully "+resto.size());
		
		
		return resto;			
	}
}

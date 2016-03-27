<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.FileReader"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="java.io.BufferedReader"%>
<%@page
	import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>


<!DOCTYPE html>
<html>
<head>
<title>Affinity Analysis</title>
<link rel="stylesheet" type="text/css" href="resourcefiles/css/home.css">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.css">

<link rel="stylesheet" type="text/css"
	href="http://cdn.datatables.net/tabletools/2.2.2/css/dataTables.tableTools.css">



<script type="text/javascript" charset="utf8"
	src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

<!-- DataTables -->
<script type="text/javascript" charset="utf8"
	src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.js"></script>

<script type="text/javascript" charset="utf8"
	src="http://cdn.datatables.net/tabletools/2.2.2/js/dataTables.tableTools.min.js"></script>
<script src="home.js"></script>
<script type="text/javascript">
$(function() 
{
	
	$("[value='dept']" ).click(function()
	{
			$("#department" ).hide();

			$("#cat" ).hide();
	});
	
	$("[value='Category']" ).click(function()
	{
		$("#cat" ).hide();
		$("#department" ).show();
	
	});

	$("[value='item']" ).click(function()
	{
		$("#astores" ).show();
		$("#cat" ).show();
		$("#department" ).show();
		$("#afinity" ).show();


	});



});
</script>




</head>

<body>

	<img src="resourcefiles/css/images/header.jpg" height="50" alt="logo"
		style="position: absolute; top: 10px; left: 0px; background-blend-mode: multiply;" />

	<button type="button" id="getlost"
		onclick="window.location.href='http://localhost:8080/AffinityAnalysis/'">Logout</button>

	<h1>Affinity Analysis</h1>
	<!-- <form>
<input type="text" value="Username" onblur="if(this.value == '') { this.value='Username'}" onfocus="if (this.value == 'Username') {this.value=''}">
<br><br>
<input type="text" value="Password" onblur="if(this.value == '') { this.value='Password'}" onfocus="if (this.value == 'Password') {this.value=''}">
</form> -->
	<h2>Run Affinity Analysis</h2>
	<div class="section">
		<svg>
  <rect x="30" y="40" width="1290px" height="60px"
				style="background-color: #f2f2f2;fill:rgb(47, 87, 130);"></rect>

</svg>

		<!-- <span id="forgot">Forgot Password ?</span> 
<button type="button"><span>Submit</span></button> -->


		<form>

			<span id="tf">Select transactions from :<input type="date"
				name="from" id="from"> to
			</span><input type="date" name="to" id="to">

			<button type="button" id="ca">Calculate Affinity</button>

			<script>
	
	
	function ajaxindicatorstart(text)
	{
		if(jQuery('body').find('#resultLoading').attr('id') != 'resultLoading'){
		jQuery('body').append('<div id="resultLoading" style="display:none"><div><img src="resourcefiles/css/images/grb.GIF"><div>'+text+'</div></div><div class="bg"></div></div>');
		}

		jQuery('#resultLoading').css({
			'width':'100%',
			'height':'100%',
			'position':'fixed',
			'z-index':'10000000',
			'top':'0',
			'left':'0',
			'right':'0',
			'bottom':'0',
			'margin':'auto'
		});

		jQuery('#resultLoading .bg').css({
			'background':'#000000',
			'opacity':'0.7',
			'width':'100%',
			'height':'100%',
			'position':'absolute',
			'top':'0'
		});

		jQuery('#resultLoading>div:first').css({
			'width': '250px',
			'height':'75px',
			'text-align': 'center',
			'position': 'fixed',
			'top':'0',
			'left':'0',
			'right':'0',
			'bottom':'0',
			'margin':'auto',
			'font-size':'20px',
			'z-index':'10',
			'color':'#ffffff'

		});

	    jQuery('#resultLoading .bg').height('100%');
	       jQuery('#resultLoading').fadeIn(300);
	    jQuery('body').css('cursor', 'wait');
	}
	
	
	function ajaxindicatorstop(text)
	{
	    jQuery('#resultLoading .bg').height('100%');
	       jQuery('#resultLoading').fadeOut(300);
	    jQuery('body').css('cursor', 'default');
	}
	
	
	
		$('#ca').click(function(){
			

			var fromdate = $('#from').val();
			var todate = $('#to').val();
	
			// GET CURRENT DATE
			var date = new Date();
			 
			// GET YYYY, MM AND DD FROM THE DATE OBJECT
			var yyyy = date.getFullYear().toString();
			var mm = (date.getMonth()+1).toString();
			var dd  = date.getDate().toString();
			 
			// CONVERT mm AND dd INTO chars
			var mmChars = mm.split('');
			var ddChars = dd.split('');
			 
			// CONCAT THE STRINGS IN YYYY-MM-DD FORMAT
			var datestring = yyyy + '-' + (mmChars[1]?mm:"0"+mmChars[0]) + '-' + (ddChars[1]?dd:"0"+ddChars[0]);

			if(fromdate>datestring | todate>datestring)
			{
				alert("Please select a valid date. You have selected a future date");
				return
			}
			
			if(!(fromdate && todate)){
				alert("Please select a valid date range");
				return
			}
			else{
				
				ajaxindicatorstart('Loading.. Please wait..');

				console.log(" in else");
							
				$.ajax({
					  url: 'home',
					  type: "GET",
					  dataType: "text",
					  data: { from : fromdate,
		                    to:todate},
		              contentType: "application/json; charset=utf-8",

					  success: function(response){
						  
						  console.log(response);
						  
						  var op = null;
						  
						  var myObject = JSON.parse(response);
						  
						  console.log(myObject);
						  var key = "msg";
						  op = myObject[key];
						  
						  console.log(op);
					     
						  if(op)
					   	  {
							  ajaxindicatorstop();
							  alert(op);
							 
				              $.get('UpdateRundate', function(responseJson) {
				            	var $select = $('#resultdropdown');           
				            	
				            	console.log(responseJson);
				            	
				            	
								  var key = "updateRundateJSON";
								  var op1 = responseJson[key];
								  
					               $select.find('option').remove();      

					               console.log(" final op "+op1);
					               
					               var op2 = JSON.parse(op1);
									  
					               $('<option>').text("Select Run Date").appendTo($select);
					               $.each(op2, function(key, value) {       
					            	   
					                   $('<option>').val(key).text(value).appendTo($select);      
					                    });
					            });
					   	  }
					  },
					}); 
			}
		       

		});
		</script>

		</form>

	</div>
	<h2>Extract Past Affinity Results</h2>
	<div class="section">
		<h3>
			Type of Affinity <span id="storedresult"> Select stored result
			</span> <select id="resultdropdown" name="rundate" value="rundate">
				<option>Select Run Date</option>
				<%
					ApplicationContext context = new ClassPathXmlApplicationContext(
							"resources/applicationContext.xml");

					DataSource dataSource = (DataSource) context.getBean("dataSource");

					Connection conn = null;
					try {
						conn = dataSource.getConnection();
					} catch (SQLException e) {
						e.printStackTrace();
					}

					String sql = "select run_date from run_history order by run_date desc";
					PreparedStatement ps = conn.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();

					while (rs.next()) {
						String run_date = rs.getString(1);
				%>
				<option><%=run_date.substring(0, run_date.length() - 2)%></option>
				<%
					}
				%>

			</select>


		</h3>



		<form id="level" method=POST>
			<input type="radio" name="level" value="item"><span
				id="inlevel">Item-Item <input type="radio" name="level"
				value="Category">Category-Category <input type="radio"
				name="level" value="dept">Department-Department
			</span> <input type="hidden" id="rundate" name="rundate"></input>


			<script>
		
		$('#resultdropdown').change(function(){
			
			$('#rundate').val($('#resultdropdown').val());			
			
			
			
		});
		
		var level =  "";
		var dep_cat_map;
		var depList;
		$("input:radio[name=level]").click(function() {
			
			var rundate = $('#resultdropdown').val();

			
			if(rundate=="Select Run Date"){
				
				alert(" Please select a date first.");
				exit();  
			}
			ajaxindicatorstart("Loading Data .. Please wait");

		    level = $(this).val();
		    
			console.log(rundate);
			console.log(level);
			
            $.get('FilterController', {
                    rundate : rundate,
                    level:level
                }, function(responseJson) {
            	var $select = $('#department');                           
	               $select.find('option').remove();      
	               
	               console.log(responseJson);
	            	
	            	
					  var key = "depList";
					  var op1 = responseJson[key];
					  
					  depList = op1;
					  var map_name = "dept_cat_map";
					   dept_cat_map= responseJson[map_name];
		               $select.find('option').remove();      

		               console.log(" final op "+op1);
		               
		               var op2 = JSON.parse(op1);
						  
		               $.each(op2, function(key, value) {       
		            	   
		                   $('<option>').val(key).text(value).appendTo($select);      
		                    });
	               /*$.each(responseJson, function(key, value) {               
	                   $('<option>').val(key).text(value).appendTo($select);      
	                    });
	               */
	               ajaxindicatorstop();
	            });
            
		       

		});
		
		
		</script>

			<!-- 		<svg >
		  <rect x="30" y="10" width="1350px" height="50px" style="fill:rgb(242, 242, 242);"></rect>
		  <rect x="30" y="90" width="1350px" height="100px" style="fill:rgb(242, 242, 242);"></rect>
		</svg> -->
			<h3 id="across">Select Across</h3>
			<div class="testing">
				<select id="astores">
					<option value="volvo">All Stores</option>
					<option value="saab">S1</option>
					<option value="opel">S2</option>
					<option value="audi">S3</option>
				</select> <select id="department">

					<option value="All">Select Department</option>


				</select>


				<script>
			
			$('#department').click(function(){
				
				
				$('#rundate').val($('#resultdropdown').val());
					            
				//var rundate = $('#resultdropdown').val();
				
				var dept = $('#department').val();
	
				console.log(" dept selected is " +dept);
				
				//console.log(depList);
				
				var op2 = JSON.parse(depList);
				var dept_name = op2[dept];
				
				console.log("selected dept name is -- "+dept_name);
	            //console.log(" dept-cat-map i have is " +dept_cat_map);

	            var op3 = JSON.parse(dept_cat_map);
				var catList = op3[dept_name];
				
				console.log(" cat list = "+catList);
	
	            var $select = $('#cat');                           
	            $select.find('option').remove();  
	               
	            $.each(catList, function(key, value) {       
	            	   
	                $('<option>').val(key).text(value).appendTo($select);      
	            });
			//	var check1 = false;
	           /*  $.get('FilterController', {
	                    rundate : rundate,
	                    level:dept,
	                    check:check1
	            }, function(responseJson) {
	            	var $select = $('#cat');                           
		               $select.find('option').remove();  
		               
		               console.log(" dept-cat - map i have is " +dept_cat_map);
		              // $('<option>').text("All Categories").appendTo($select);

		               console.log(responseJson);
	            	
	            	
					  var key = "catList";
					  var op1 = responseJson[key];
					  
		               $select.find('option').remove();      

		               console.log(" final op "+op1);
		               
		               var op2 = JSON.parse(op1);
						  
		               $.each(op2, function(key, value) {       
		            	   
		                   $('<option>').val(key).text(value).appendTo($select);      
		                    });
		               /*$.each(responseJson, function(key, value) {               
		                   $('<option>').val(key).text(value).appendTo($select);      
		                    });*/
		        /*    });           */
			});
		</script>
				<select id="cat">


					<option>Select Category</option>
				</select> <select id="affinity" name="affinity">
					<option id='aff' value="volvo">Affinity</option>

					<option id='sup' value="su">Support</option>
					<option id='con' value="co">Confidence</option>
					<option id='lif' value="li">Lift</option>
				</select> <input type="text" id="affinityval" name="affinity-threshold"
					value="0">
				<button type="button" id="sin">Submit</button>
		</form>
		<script>
                       $(function(){
                          
                           $('#affinityval').hide();
                                                  
                           $("#affinity").change(function(){
                              var value=$(this).val();
                              if(value=="su") $("#affinityval").show();
                              if(value=="li") $("#affinityval").show();
                              if(value=="co") $("#affinityval").show();
                              if (value=="volvo") $("#affinityval").hide();

                           });
                       });
 
				$('#sin').click(function(){
					
					var rundate = $('#resultdropdown').val();

					
					if(rundate=="Select Run Date"){
						
						alert(" Please select a date first.");
						exit();  
					}

					var dept = $('#department option:selected').text();
					var cat = $('#cat option:selected').text();
					
					console.log(dept);
					console.log(cat);
					if(dept=="Select Department" && level=="item"){
						alert("Please select a specific Department or ALL DEPARTMENTS");
						exit();
					}
					ajaxindicatorstart("Filtering the Results.. Please Wait :) ");
					$('#sindhu tbody').remove();
					var dt =null;

					if(dt!=null)
						dt.clear().draw();
					$('#rundate').val($('#resultdropdown').val());
						            
					var rundate = $('#resultdropdown').val();
					
					
					var affinity = $('#affinity option:selected').text();
					
					var affinityval = $('#affinityval').val();
				
				var flag = false;
							
				console.log(" level is "+level);
				$.ajax({
		        	type: "GET",
				data: { rundate : rundate,
					level:level,
                    dept:dept,
                    cat:cat,
                    affinity:affinity,
                    affinityval:affinityval},
		           	url:  "SelectionController",
		            	contentType: "application/json; charset=utf-8",
		            	success: function(responseJson) {
		           
		            		var key = "filter";
							  var op1 = responseJson[key];
							  
				               console.log(" final op "+op1);
				               
				               var op2 = JSON.parse(op1);
				               
		            		var count=1;
		            	 var trHTML = '<tbody>';
	            		 $.each(op2, function (i, item) {
		                	   
		                       trHTML += '<tr><td>' + count+ '</td><td>'+item.rule + '</td><td>' + item.support + '</td><td>' + item.lift + '</td><td>' + item.confidence+'</td></tr>';
								
		                       count++;

		                   });
		  
	            		 trHTML += '</tbody>';
	            		 $('#sindhu').append(trHTML); 
			       	}
		            	
				});
				
				$(document).ajaxComplete(function() {
					
					ajaxindicatorstop();
					
					$('#sindhu').show();
					dt = $('#sindhu').dataTable( {
				       "dom": 'T<"clear">lfrtip',
				   		destroy: true,
						"aoColumns" : [
						               {"swidth" : "50px"},
						               {"swidth" : "1000px"},
						               {"swidth" : "100px"},
						               {"swidth" : "100px"},
						               {"swidth" : "100px"}
						               ],
	   			  		"pagingType" : "full_numbers",
				       "tableTools": {
			                "aButtons": [ "copy", "xls" , "csv" , "pdf", "print"],
				           "sSwfPath": "http://cdn.datatables.net/tabletools/2.2.2/swf/copy_csv_xls_pdf.swf"
				       },
				       "fnInitComplete" : function(){
				    	   $('#sindhu').css("width","100%");
				       }
				   } );
				  
				  
				   
				});
	          /*  $.get('SelectionServlet', {
	                    rundate : rundate,
	                    dept:dept,
	                    cat:cat,
	                    affinity:affinity,
	                    affinityval:affinityval
	               }, function(response) {
	            	
	                  
	            	   
						$('#sindhu').empty();
	            	   
	            	   
	            	   var trHTML = '';
	            	   
                       var tableHeadHTML = '<thead><tr><th>' + 'Rule' + '</th><th>' + 'Support' + '</th><th>' + 'Lift'+ '</th><th>' + 'Confidence'+'</th></tr></thead>';

	                   $('#sindhu').append(tableHeadHTML);

	                   $.each(response, function (i, item) {
	                	   
	                	   
	                       trHTML += '<tbody><tr><td>' + item.map.rule + '</td><td>' + item.map.support + '</td><td>' + item.map.lift + '</td><td>' + item.map.confidence+'</td></tr></tbody>';
	                   });
	                   $('#sindhu').append(trHTML);
	                   	   				
	                   
	                /*   $('#sindhu').dataTable({
		   	            	
		   	            	"ajax": response
		   	            });
	                   
	                   flag = true;
	                   console.log(" after for "+ flag);
	                   
	                   if(flag){
	   		            
	                	    $('#sindhu').dataTable( {
	   	   			        "dom": 'T<"clear">lfrtip',
	   	   			  		destroy: true,
	   	   			  		"pagingType" : "full_numbers",
	   	   			        "tableTools": {
	   	   			            "sSwfPath": "http://cdn.datatables.net/tabletools/2.2.2/swf/copy_csv_xls_pdf.swf"
	   	   			        }
	   	   			    } );
	                	   
	   	            }
	                   
	                  
	               });
	            
	           */
                console.log(" after ajax "+ flag);

	            
               
				});
				
				</script>



	</div>


	<TABLE id="sindhu" class="display" style="width: 100%">
		<thead>
			<TR>
				<TH>S.No.</TH>
				<TH>Rule</TH>
				<TH>Support</TH>
				<TH>Lift</TH>
				<TH>Confidence</TH>
			</TR>
		</thead>


	</TABLE>


	</div>




</body>
</html>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Affine Affinity Tool</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <link rel="stylesheet" href="resourcefiles/css/mystyle.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.css">

<link rel="stylesheet" type="text/css"
	href="http://cdn.datatables.net/tabletools/2.2.2/css/dataTables.tableTools.css">

<!-- DataTables -->
<script type="text/javascript" charset="utf8"
	src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.js"></script>

<script type="text/javascript" charset="utf8"
	src="http://cdn.datatables.net/tabletools/2.2.2/js/dataTables.tableTools.min.js"></script>
	
<link rel="stylesheet" type="text/css"
	href="//cdn.datatables.net/plug-ins/1.10.6/integration/bootstrap/3/dataTables.bootstrap.css">
<script src="//cdn.datatables.net/plug-ins/1.10.6/integration/bootstrap/3/dataTables.bootstrap.js"></script>

<script src="resourcefiles/js/myscript.js"></script>
</head>
<body>
<script type="text/javascript">
$(function() 
{
	
	$("[value='dept']" ).click(function()
	{
			$("#dep_div" ).hide();

			$("#cat_div" ).hide();
	});
	
	$("[value='Category']" ).click(function()
	{
		$("#cat_div" ).hide();
		$("#dep_div" ).show();
	
	});

	$("[value='item']" ).click(function()
	{
		$("#astores" ).show();
		$("#cat_div" ).show();
		$("#dep_div" ).show();
		$("#afinity" ).show();


	});



});
</script>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
		<a href="#" class="pull-left"><img src="resourcefiles/css/images/affine.png" width="100" height="50" style="margin-right:20px;"></a>
      <!-- <a class="navbar-brand" href="#">AFFINE ANALYTICS</a> -->
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li ><a href="home">Home</a></li>
        <li><a href="viewstrategies">Rules</a></li>
        <li><a href="scatteraffinity">Dashboard</a></li>
        <li><a href="#">Reports</a></li>
		<li class="active"><a href="runaffinity">Admin</a></li>
      </ul>
	  <ul class="nav navbar-nav navbar-right">
        <!-- <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li> -->
		<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-user"></span> User <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Sign Out</a></li>
            <li><a href="#">Change Password</a></li>
            <li><a href="#">Contact Support</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>
<div class="col-md-2" id="left">
			<ul class="nav nav-pills nav-stacked" id="leftnav">
				<li id="one"><a href="runaffinity"><span class="glyphicon glyphicon-play"></span> Run Affinity</a></li>
				<li class="active"><a href="viewaffinity"><span class="glyphicon glyphicon-camera"></span> View Affinity</a></li>
				<li><a href="#"><span class="glyphicon glyphicon-user"></span> Create User</a></li>
				<li><a href="#"><span class="glyphicon glyphicon-cloud"></span> Connect Database</a></li>
			</ul>
			<div class="addspace">
				<p class="text-info"><mark>Support</mark> indicates prevelance of product(s)</p>
				<p class="text-info"><mark>Confidence</mark> indicates predictability of one product given the other product</p>	
				<p class="text-info"><mark>Lift</mark> indicates likelihood of two products going together</p>		
			</div>
</div>
<div class="col-md-10" id="runaffinity">
	<div class="col-md-12">
	<h3>View Affinity</h3>
	</div>
		<div class="col-md-12">
		<div class="dropdown">
			<button class="btn btn-default dropdown-toggle" id="dropdownMenu1" type="button" data-toggle="dropdown" name="rundate" value="rundate">Select Date
			<span class="caret"></span></button>
			<ul class="dropdown-menu dropdown-menu-right"  id="rundate">
			  <li><a href="#">21/04/15</a></li>
			  <li><a href="#">22/04/15</a></li>
			  <li><a href="#">23/04/15</a></li>
			</ul>
		</div>
		</div>
		
		<script type="text/javascript">
		
		$('#rundate li').on('click', function(){
		    var rundate =  $('#dropdownMenu1').val($(this).text()).val();
		    out.println("Transactions from '26-02-2012' to '26-02-2013' on "+rundate);

		    console.log(rundate);
		});
		
		</script>
	<div class="col-md-12">
		  <h5>Type of Affinity</h5>
			<form role="form" id="TOA">
				<label class="radio-inline">
				  <input type="radio" name="optradio" value="item">Item-Item
				</label>
				<label class="radio-inline">
				  <input type="radio" name="optradio" value="Category">Category-Category
				</label>
				<label class="radio-inline">
				  <input type="radio" name="optradio" value="dept">Department-Department
				</label>
			</form>
	</div>	
	
	
	 <script type="text/javascript">
						 
		 var level =  "";
			var dep_cat_map;
			var depList;
			var dept_name;
			var cat_name;
			var affinitytype;
			$("input:radio[name=optradio]").click(function() {
				
				var runDate = $('#dropdownMenu1').val();
				if(rundate=="Select Run Date"){
					
					alert(" Please select a date first.");
					exit();  
				}
				//ajaxindicatorstart("Loading Data .. Please wait");

			    level = $(this).val();
			    
				console.log(" runddate is "+runDate);
				console.log(" level is "+level);
				
				$.ajax({
					  url: 'FilterController',
					  type: "GET",
					  dataType: "text",
					  data: { rundate : runDate,
		                    level:level
		                    },
		              contentType: "application/json; charset=utf-8",

					  success: function(responseJson){
						  
						  console.log(responseJson);
	                	
	               		  /* var $select = $('#department');                           
			              $select.find('option').remove();      
			                */
				          var response = JSON.parse(responseJson);
	
			              console.log(" response is "+response);
						  var key = "depList";
						  var op1 = response[key];
						  
						  depList = op1;
						  
						  console.log("deplist = "+depList);
						  var map_name = "dept_cat_map";
						  dep_cat_map= response[map_name];
			              // $select.find('option').remove();      
						  /* console.log(dep_cat_map);
			              console.log(" final op "+op1);
 */
			              var op2 = JSON.parse(op1);
			              
			              $('#dep_div').on('click','button',function(){

			            	  var ul = $('#department');
				              $(ul).empty();
				              
				              $.each(op2, function(key, value) {       
				            	   
				            	   console.log(value);
				                   $(ul).append('<li><a href="#" >'+value+'</a></li>');
				                   var li = $(ul).children()[key];
				                   $(li).data(value);
							   });
			              });
			              $('#dep_div').on('click','a',function(){

			            	  $('#show').empty();
			            	   // var car = $(this).parent();
			            	    dept_name = $('#department').val($(this).text()).val();
								console.log(" Dept selected is "+dept_name);
								
			            	  	var ul = $('#cat');
					            
			            	    $(ul).empty();

			            	    //console.log(dep_cat_map);
			            	    var op3 = JSON.parse(dep_cat_map);
			            	    
			            	    //console.log(" Parsed map "+op3);
			    				var catList = op3[dept_name];
			    				
			    				console.log(" cat list = "+catList);
			    				
			    				$.each(catList, function(key, value){
			    					
			    					console.log(key + value);
				    				 $(ul).append('<li><a href="#" >'+value+'</a></li>');
					                   var li = $(ul).children()[key];
					                   $(li).data(value);
			    				})
			            	  }); 
			              
			              $('#cat_div').on('click','a',function(){

			            	  $('#show').empty();
			            	  cat_name = $('#cat').val($(this).text()).val();
			              })
			              
			              $('#affinitytype li').on('click', function(){
			      		    affinitytype =  $('#dropdownMenu4').val($(this).text()).val();
			      		    
			      		    console.log(affinitytype);
			      		});
					  }
				});
			});
            //ajaxindicatorstop();
						 
	</script>
						
	<div class="col-md-12" id ="abc">
		  <h5>Select Across</h5>
			<form role="form" id="SA">
				<div class="col-md-2" id="dep_div">
					<div class="dropdown">
						<button class="btn btn-default dropdown-toggle" id="dropdownMenu2" type="button" data-toggle="dropdown">All Departments
						<span class="caret"></span></button>
						<ul class="dropdown-menu" id="department">
 						</ul>
					</div>	
				</div>	
				<div class="col-md-2" id="cat_div">	
						<button class="btn btn-default dropdown-toggle" id="dropdownMenu3" type="button" data-toggle="dropdown">All Categories
						<span class="caret"></span></button>
						<ul class="dropdown-menu" id="cat">
						
						</ul>
				</div>
				<div class="col-md-2">				
						<button class="btn btn-default dropdown-toggle" id="dropdownMenu4" type="button" data-toggle="dropdown">Select Affinity
						<span class="caret"></span></button>
						<ul class="dropdown-menu" id="affinitytype">
						  <li><a href="#" id="su">Support</a></li>
						  <li><a href="#" id="co">Confidence</a></li>
						  <li><a href="#" id="li">Lift</a></li>
						</ul>
					</div>
					<div class="col-md-3">	
						<input type="text" class="form-control" id="affinityval">
					</div>
					<!-- <script>
                       $(function(){
                          
                           $('#affinityval').hide();
                                                  
                           $("#affinity").change(function(){
			            	  var value = $('#affinity').val($(this).text()).val();
                              console.log(" Selected Affinity "+value);
                              if(value=="su") $("#affinityval").show();
                              if(value=="li") $("#affinityval").show();
                              if(value=="co") $("#affinityval").show();
                              if (value=="volvo") $("#affinityval").hide();

                           });
                       });
                       </script> -->
				
				<div class="col-md-3">	
				<button type="button" class="btn btn-primary" id="sin">Search</button>
				</div>
				
			</form>
			<script>
			$('#sin').click(function(){
					
				var rundate = $('#dropdownMenu1').val();
				
				if(rundate=="Select Run Date"){
					
					alert(" Please select a date first.");
					exit();  
				}

				if(dept_name=="Select Department" && level=="item"){
					alert("Please select a specific Department or ALL DEPARTMENTS");
					exit();
				}
				
				ajaxindicatorstart("Filtering the Results. Please Wait ");
				$('#sindhu thead').remove();
				$('#sindhu tbody').remove();
				var dt =null;

				if(dt!=null)
					dt.clear().draw();
				
				var affinityval = $('#affinityval').val();
											
				console.log("selected dept = "+dept_name);
				console.log("selected cat = "+cat_name);
				console.log("selected affinity = "+affinitytype);
				console.log("selected affinity value = "+affinityval);

				console.log(" level is "+level);
				
				if(typeof dept_name === 'undefined')
					dept_name="";
				if(typeof cat_name === 'undefined')
					cat_name="";
				if(typeof affinitytype === 'undefined')
					affinitytype="";
				if(typeof affinityval === 'undefined')
					affinityval=0;
				
				$.ajax({
		        	type: "GET",
				data: { rundate : rundate,
					level:level,
                    dept:dept_name,
                    catg:cat_name,
                    affinity:affinitytype,
                    affinityval:affinityval},
		           	url:  "SelectionController",
		            	contentType: "application/json; charset=utf-8",
		            	success: function(responseJson) {
		           
		            		  console.log(responseJson);
		            		  
				               
				              //var op2 = JSON.parse(responseJson);
				               
		            		  var count=1;
		            	 	  var trHTML = '<tbody>';
	            		 	  $.each(responseJson, function (i, item) {
		                	   
	            		 		  console.log(item.rule + item.support);
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
<div id="footer">Copyright&nbsp;<span class="glyphicon glyphicon-copyright-mark"></span> 2015 by Affine Analytics</div>
<div class="clearfix visible-lg"></div> 
</body>
</html>

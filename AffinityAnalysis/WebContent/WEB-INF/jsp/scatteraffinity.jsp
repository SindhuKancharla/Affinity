<!DOCTYPE html>
<html lang="en">
<head>
  <title>Affine Affinity Tool</title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="resourcefiles/js/httpmaxcdn.bootstrapcdn.combootstrap3.3.4cssbootstrap.min.css">
  <link rel="stylesheet" href="resourcefiles/css/mystyle.css">
  <script src="resourcefiles/js/httpsajax.googleapis.comajaxlibsjquery1.11.1jquery.min.js"></script>
  <script src="resourcefiles/js/httpmaxcdn.bootstrapcdn.combootstrap3.3.4jsbootstrap.min.js"></script>
<link rel="stylesheet" href="resourcefiles/js/httpcdnjs.cloudflare.comajaxlibsbootstrap-datepicker1.3.0cssdatepicker.min.css" />
<link rel="stylesheet" href="resourcefiles/js/httpcdnjs.cloudflare.comajaxlibsbootstrap-datepicker1.3.0cssdatepicker3.min.css" />
<script src="resourcefiles/js/httpajax.googleapis.comajaxlibsjquery1.11.2jquery.min.js"></script>
<script src="resourcefiles/js/httpcdnjs.cloudflare.comajaxlibsbootstrap-datepicker1.3.0jsbootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="resourcefiles/js/d3.v3.min.js" charset="UTF-8"></script>
<script src="resourcefiles/js/myscript.js"></script>
<style>

.rule {
    float:right;
    color:#27aae1;
}
.axis {
    fill: none;
    stroke: #AAA;
    stroke-width: 1px;
}
text {
    stroke: none;
    fill: #666666;
    font-size: .6em;
    font-family:"Helvetica Neue"
}
.label {
    fill: #414241;
}
.node {
    cursor:pointer;
}
.dot {
    opacity: .7;
    cursor: pointer;
}

</style>
</head>
<body>
<script type="text/javascript">
$(function() 
{
	 $("#chart").hide();
	    $("#textdate").hide();

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
	
	$(".dropdown-menu li a").click(function(){
		  var selText = $(this).text();
		  $(this).parents('.btn-group').find('.dropdown-toggle').html(selText+' <span class="caret"></span>');
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
        <li class="active"><a href="scatteraffinity">Dashboard</a></li>
        <li><a href="#">Reports</a></li>
		<li ><a href="runAffinity">Admin</a></li>
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
				<li class="active" id="one"><a href="scatteraffinity"><span class="glyphicon glyphicon-picture"></span> Scatter Plot</a></li>
				<li ><a href="matrixaffinity"><span class="glyphicon glyphicon-picture"></span> Matrix Layout</a></li>
			</ul>
			<div class="addspace">
				<p class="text-info"><mark>Support</mark> indicates prevelance of product(s)</p>
				<p class="text-info"><mark>Confidence</mark> indicates predictability of one product given the other product</p>	
				<p class="text-info"><mark>Lift</mark> indicates likelihood of two products going together</p>		
			</div>
</div>
<div class="col-md-10" id="runaffinity">
	<div class="col-md-12">
	<h3>View Scatter Plot</h3>
	</div>
		<div class="col-md-12">
		
			<div class="btn-group" style="display:inline-block;">
				<button class="btn dropdown-toggle" id="dropdownMenu1" type="button" data-toggle="dropdown" name="rundate" value="rundate">Select Date
				<span class="caret"></span></button>
				<ul class="dropdown-menu dropdown-menu-right"  id="rundate">
				  <li><a href="#">02/01/2015</a></li>
				  <li><a href="#">02/15/2015</a></li>
				  <li><a href="#">03/01/2015</a></li>
				  <li><a href="#">03/15/2015</a></li>
				</ul>
			</div>
			<div id="textdate" style="display:inline-block;">Transaction from  03/01/2015 to 03/30/2015 with Support :0.5 Confidence : 0.3 Lift : 2</div>
			
		</div>
	<script type="text/javascript">
		
		$('#rundate li').on('click', function(){
		    var rundate =  $('#dropdownMenu1').val($(this).text()).val();
		    $("#textdate").show();

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
				if(runDate=="Select Run Date"){
					
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
								$(this).parents('.btn-group').find('.dropdown-toggle').html(dept_name+' <span class="caret"></span>');
								
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
			            	  $(this).parents('.btn-group').find('.dropdown-toggle').html(cat_name+' <span class="caret"></span>');
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
					<div class="btn-group">
						<button class="btn dropdown-toggle" id="dropdownMenu2" type="button" data-toggle="dropdown">All Departments
						<span class="caret"></span></button>
						<ul class="dropdown-menu" id="department">
 						</ul>
					</div>	
				</div>	
				<div class=" btn-group col-md-2" id="cat_div">	
						<button class="btn dropdown-toggle" id="dropdownMenu3" type="button" data-toggle="dropdown">All Categories
						<span class="caret"></span></button>
						<ul class="dropdown-menu" id="cat">
						
						</ul>
				</div>
				<div class=" btn-group col-md-2">				
						<button class="btn dropdown-toggle" id="dropdownMenu4" type="button" data-toggle="dropdown">Select Affinity
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
				<button type="button" class="btn btn-primary" id="sin">Show Graph</button>
			<script>
				
			var scatterplotdata = "";
			$('#sin').click(function(){
				
			    $("#scatter-load").empty();
			   

				var rundate = $('#dropdownMenu1').val();
				
				if(rundate=="Select Run Date"){
					
					alert(" Please select a date first.");
					exit();  
				}

				if((typeof dept_name === 'undefined') ){
					alert("Please select a specific Department or ALL DEPARTMENTS");
					exit();
				}
				if((typeof cat_name === 'undefined') && level=="item"){
					alert("Please select a specific Category or ALL CATEGORIES");
					exit();
				}
				ajaxindicatorstart("Filtering the Results. Please Wait ");

				
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
		           	url:  "ScatterPlotController",
		            	contentType: "application/json; charset=utf-8",
		            	success: function(responseJson) {
		           
		            		scatterplotdata = responseJson;
		            		console.log(scatterplotdata);
		            		ajaxindicatorstop();
		            		showScatterPlot(scatterplotdata);
		    			    $("#scatter-load").show();
		    			    $("#chart").show();

		            	}
				});
			});
			</script>
			</div>
				
			</form>
	</div>

<div class="col-md-12">
<!-- <h1>Affinity Scatter Plot</h1> -->
<div class="col-md-8">
		<div id="scatter-load" style="margin-left: 200px;"></div>
	</div>
	<div class="col-md-4">	
		<div id="chart">	</div><!-- <p id="lifttext">Lift</p> -->
		
	</div>	
	
<script type="text/javascript">
var sampledata = [{"support":0.014,"rule":"OFFICE  , CANDY","lift":4.187,"confidence":1},{"support":0.014,"rule":"PHARM OTC  , GARDEN","lift":3.35,"confidence":0.2},{"support":0.029,"rule":"DOMESTICS  , FOOD","lift":1.165,"confidence":0.4},{"support":0.014,"rule":"OPTICAL  , PRODUCE","lift":3.045,"confidence":1},{"support":0.029,"rule":"DOMESTICS  , COOLER","lift":1.072,"confidence":0.4},{"support":0.074,"rule":"BAKERY  , COOLER","lift":1.914,"confidence":0.71},{"support":0.029,"rule":"M APPAREL  , GARDEN","lift":4.187,"confidence":0.25},{"support":0.029,"rule":"COOLER  , GARDEN","lift":1.34,"confidence":0.08},{"support":0.104,"rule":"SERV DELI  , FOOD","lift":2.039,"confidence":0.7},{"support":0.029,"rule":"PRODUCE  , GARDEN","lift":1.522,"confidence":0.09},{"support":0.014,"rule":"OPTICAL  , CANDY","lift":4.187,"confidence":1},{"support":0.044,"rule":"SUNDRIES  , PHARM OTC","lift":1.747,"confidence":0.13},{"support":0.014,"rule":"GARDEN  , HARDWARE","lift":2.093,"confidence":0.25},{"support":0.029,"rule":"COOLER  , SM APPL","lift":1.786,"confidence":0.08},{"support":0.074,"rule":"M APPAREL  , PRODUCE","lift":1.903,"confidence":0.63},{"support":0.044,"rule":"CANDY  , BAKERY","lift":1.794,"confidence":0.19},{"support":0.044,"rule":"BAKERY  , FROZEN FD","lift":3.19,"confidence":0.43},{"support":0.014,"rule":"DOMESTICS  , SM APPL","lift":4.466,"confidence":0.2},{"support":0.044,"rule":"FROZEN FD  , BAKERY","lift":3.19,"confidence":0.33},{"support":0.029,"rule":"SUNDRIES  , JEWELRY","lift":2.913,"confidence":0.09},{"support":0.014,"rule":"FOOD CT  , FROZEN FD","lift":7.444,"confidence":1},{"support":0.014,"rule":"W APPAREL  , HOUSEWRS","lift":3.722,"confidence":0.17},{"support":0.029,"rule":"DOMESTICS  , SUNDRIES","lift":1.165,"confidence":0.4},{"support":0.014,"rule":"OPTICAL  , BAKERY","lift":9.571,"confidence":1},{"support":0.014,"rule":"SUNDRIES  , Mbrship","lift":2.913,"confidence":0.04},{"support":0.029,"rule":"JEWELRY  , PRODUCE","lift":3.045,"confidence":1},{"support":0.029,"rule":"BAKERY  , SERV DELI","lift":1.914,"confidence":0.29},{"support":0.029,"rule":"GARDEN  , SUNDRIES","lift":1.456,"confidence":0.5},{"support":0.074,"rule":"HABA  , CANDY","lift":1.903,"confidence":0.45},{"support":0.074,"rule":"SUNDRIES  , BAKERY","lift":2.08,"confidence":0.22},{"support":0.089,"rule":"SUNDRIES  , SERV DELI","lift":1.747,"confidence":0.26},{"support":0.059,"rule":"MEAT  , SERV DELI","lift":3.35,"confidence":0.5},{"support":0.014,"rule":"PHARM OTC  , OFFICE","lift":13.4,"confidence":0.2},{"support":0.029,"rule":"W APPAREL  , M APPAREL","lift":2.791,"confidence":0.33},{"support":0.029,"rule":"FROZEN FD  , MEAT","lift":1.861,"confidence":0.22},{"support":0.014,"rule":"COOLER  , MEDIA","lift":2.68,"confidence":0.04},{"support":0.059,"rule":"CANDY  , FROZEN FD","lift":1.861,"confidence":0.25},{"support":0.059,"rule":"FOOD  , HARDWARE","lift":1.456,"confidence":0.17},{"support":0.029,"rule":"SM APPL  , HOUSEWRS","lift":14.888,"confidence":0.67},{"support":0.014,"rule":"FOOD CT  , SERV DELI","lift":6.7,"confidence":1},{"support":0.119,"rule":"SERV DELI  , COOLER","lift":2.144,"confidence":0.8},{"support":0.014,"rule":"TOYS/SEAS  , SUNDRIES","lift":2.913,"confidence":1},{"support":0.059,"rule":"W APPAREL  , PRODUCE","lift":2.03,"confidence":0.67},{"support":0.164,"rule":"DELI  , COOLER","lift":1.842,"confidence":0.69},{"support":0.029,"rule":"GARDEN  , M APPAREL","lift":4.187,"confidence":0.5},{"support":0.014,"rule":"OFFICE  , FOOD","lift":2.913,"confidence":1},{"support":0.014,"rule":"HARDWARE  , FOOD CT","lift":8.375,"confidence":0.13},{"support":0.059,"rule":"HARDWARE  , FOOD","lift":1.456,"confidence":0.5},{"support":0.044,"rule":"BAKERY  , CANDY","lift":1.794,"confidence":0.43},{"support":0.029,"rule":"PHARM OTC  , HARDWARE","lift":3.35,"confidence":0.4},{"support":0.014,"rule":"FOOD CT  , CANDY","lift":4.187,"confidence":1},{"support":0.014,"rule":"DOMESTICS  , FROZEN FD","lift":1.488,"confidence":0.2},{"support":0.014,"rule":"FROZEN FD  , MAJORS","lift":1.861,"confidence":0.11},{"support":0.014,"rule":"MEDIA  , SUNDRIES","lift":2.913,"confidence":1},{"support":0.283,"rule":"COOLER  , SUNDRIES","lift":2.213,"confidence":0.76},{"support":0.059,"rule":"FOOD  , W APPAREL","lift":1.942,"confidence":0.17},{"support":0.074,"rule":"COOLER  , M APPAREL","lift":1.675,"confidence":0.2},{"support":0.059,"rule":"SERV DELI  , HARDWARE","lift":3.35,"confidence":0.4},{"support":0.074,"rule":"DELI  , MEAT","lift":2.617,"confidence":0.31},{"support":0.014,"rule":"M APPAREL  , FOOD CT","lift":8.375,"confidence":0.13},{"support":0.014,"rule":"DELI  , MAJORS","lift":1.046,"confidence":0.06},{"support":0.014,"rule":"FROZEN FD  , HABA","lift":0.676,"confidence":0.11},{"support":0.074,"rule":"COOLER  , BAKERY","lift":1.914,"confidence":0.2},{"support":0.029,"rule":"SERV DELI  , PHARM OTC","lift":2.68,"confidence":0.2},{"support":0.029,"rule":"COOLER  , DOMESTICS","lift":1.072,"confidence":0.08},{"support":0.134,"rule":"FROZEN FD  , FROZEN FD","lift":7.444,"confidence":1},{"support":0.119,"rule":"COOLER  , FROZEN FD","lift":2.382,"confidence":0.32},{"support":0.014,"rule":"SM APPL  , HABA","lift":2.03,"confidence":0.33},{"support":0.014,"rule":"BAKERY  , JEWELRY","lift":4.785,"confidence":0.14},{"support":0.208,"rule":"COOLER  , CANDY","lift":2.345,"confidence":0.56},{"support":0.014,"rule":"HARDWARE  , BAKERY","lift":1.196,"confidence":0.13},{"support":0.014,"rule":"FOOD  , JEWELRY","lift":1.456,"confidence":0.04},{"support":0.014,"rule":"SUNDRIES  , HOUSEWRS","lift":0.971,"confidence":0.04},{"support":0.029,"rule":"FOOD  , SM APPL","lift":1.942,"confidence":0.09},{"support":0.089,"rule":"PRODUCE  , FROZEN FD","lift":2.03,"confidence":0.27},{"support":0.134,"rule":"PRODUCE  , DELI","lift":1.713,"confidence":0.41},{"support":0.014,"rule":"TOYS/SEAS  , COOLER","lift":2.68,"confidence":1},{"support":0.089,"rule":"MEAT  , PRODUCE","lift":2.284,"confidence":0.75},{"support":0.298,"rule":"FOOD  , COOLER","lift":2.33,"confidence":0.87},{"support":0.014,"rule":"BAKERY  , M APPAREL","lift":1.196,"confidence":0.14},{"support":0.029,"rule":"MAJORS  , MEAT","lift":4.187,"confidence":0.5},{"support":0.029,"rule":"SM APPL  , SUNDRIES","lift":1.942,"confidence":0.67},{"support":0.014,"rule":"GARDEN  , W APPAREL","lift":2.791,"confidence":0.25},{"support":0.014,"rule":"FOOD  , HOUSEWRS","lift":0.971,"confidence":0.04},{"support":0.029,"rule":"PRODUCE  , MAJORS","lift":1.522,"confidence":0.09},{"support":0.029,"rule":"SM APPL  , FOOD","lift":1.942,"confidence":0.67},{"support":0.373,"rule":"COOLER  , COOLER","lift":2.68,"confidence":1},{"support":0.029,"rule":"W APPAREL  , MEAT","lift":2.791,"confidence":0.33},{"support":0.014,"rule":"W APPAREL  , PHARM OTC","lift":2.233,"confidence":0.17},{"support":0.059,"rule":"HARDWARE  , DELI","lift":2.093,"confidence":0.5},{"support":0.074,"rule":"PHARM OTC  , PHARM OTC","lift":13.4,"confidence":1},{"support":0.029,"rule":"W APPAREL  , DOMESTICS","lift":4.466,"confidence":0.33},{"support":0.029,"rule":"HOUSEWRS  , SM APPL","lift":14.888,"confidence":0.67},{"support":0.104,"rule":"FOOD  , SERV DELI","lift":2.039,"confidence":0.3},{"support":0.014,"rule":"FROZEN FD  , DOMESTICS","lift":1.488,"confidence":0.11},{"support":0.014,"rule":"OFFICE  , SUNDRIES","lift":2.913,"confidence":1},{"support":0.014,"rule":"HOUSEWRS  , CANDY","lift":1.395,"confidence":0.33},{"support":0.119,"rule":"FROZEN FD  , COOLER","lift":2.382,"confidence":0.89},{"support":0.014,"rule":"TOYS/SEAS  , FROZEN FD","lift":7.444,"confidence":1},{"support":0.104,"rule":"MEAT  , COOLER","lift":2.345,"confidence":0.88},{"support":0.029,"rule":"SM APPL  , PRODUCE","lift":2.03,"confidence":0.67},{"support":0.014,"rule":"M APPAREL  , OFFICE","lift":8.375,"confidence":0.13},{"support":0.029,"rule":"DOMESTICS  , W APPAREL","lift":4.466,"confidence":0.4},{"support":0.029,"rule":"HABA  , GARDEN","lift":3.045,"confidence":0.18},{"support":0.014,"rule":"COOLER  , LIQUOR","lift":2.68,"confidence":0.04},{"support":0.149,"rule":"SUNDRIES  , DELI","lift":1.82,"confidence":0.43},{"support":0.029,"rule":"JEWELRY  , CANDY","lift":4.187,"confidence":1},{"support":0.074,"rule":"M APPAREL  , FOOD","lift":1.82,"confidence":0.63},{"support":0.029,"rule":"DOMESTICS  , SERV DELI","lift":2.68,"confidence":0.4},{"support":0.014,"rule":"W APPAREL  , GARDEN","lift":2.791,"confidence":0.17},{"support":0.014,"rule":"SM APPL  , M APPAREL","lift":2.791,"confidence":0.33},{"support":0.014,"rule":"HARDWARE  , JEWELRY","lift":4.187,"confidence":0.13},{"support":0.074,"rule":"M APPAREL  , CANDY","lift":2.617,"confidence":0.63},{"support":0.164,"rule":"CANDY  , SUNDRIES","lift":2.002,"confidence":0.69},{"support":0.014,"rule":"SERV DELI  , MAJORS","lift":1.675,"confidence":0.1},{"support":0.014,"rule":"OPTICAL  , OPTICAL","lift":67,"confidence":1},{"support":0.014,"rule":"GARDEN  , SERV DELI","lift":1.675,"confidence":0.25},{"support":0.014,"rule":"FOOD CT  , FOOD CT","lift":67,"confidence":1},{"support":0.074,"rule":"PRODUCE  , HABA","lift":1.384,"confidence":0.23},{"support":0.059,"rule":"BAKERY  , FOOD","lift":1.664,"confidence":0.57},{"support":0.059,"rule":"HABA  , HARDWARE","lift":3.045,"confidence":0.36},{"support":0.044,"rule":"MEAT  , HARDWARE","lift":3.14,"confidence":0.38},{"support":0.014,"rule":"OFFICE  , PRODUCE","lift":3.045,"confidence":1},{"support":0.044,"rule":"HARDWARE  , MEAT","lift":3.14,"confidence":0.38},{"support":0.029,"rule":"MEAT  , FROZEN FD","lift":1.861,"confidence":0.25},{"support":0.014,"rule":"TOYS/SEAS  , BAKERY","lift":9.571,"confidence":1},{"support":0.014,"rule":"FROZEN FD  , W APPAREL","lift":1.24,"confidence":0.11},{"support":0.014,"rule":"SPORTS  , SPORTS","lift":67,"confidence":1},{"support":0.014,"rule":"SUNDRIES  , FOOD CT","lift":2.913,"confidence":0.04},{"support":0.044,"rule":"PRODUCE  , DOMESTICS","lift":1.827,"confidence":0.14},{"support":0.014,"rule":"OFFICE  , SM APPL","lift":22.333,"confidence":1},{"support":0.029,"rule":"M APPAREL  , W APPAREL","lift":2.791,"confidence":0.25},{"support":0.044,"rule":"DOMESTICS  , PRODUCE","lift":1.827,"confidence":0.6},{"support":0.029,"rule":"FROZEN FD  , HARDWARE","lift":1.861,"confidence":0.22},{"support":0.074,"rule":"HARDWARE  , COOLER","lift":1.675,"confidence":0.63},{"support":0.014,"rule":"CANDY  , GARDEN","lift":1.046,"confidence":0.06},{"support":0.014,"rule":"FOOD CT  , FOOD","lift":2.913,"confidence":1},{"support":0.014,"rule":"FOOD CT  , HARDWARE","lift":8.375,"confidence":1},{"support":0.014,"rule":"FOOD CT  , SUNDRIES","lift":2.913,"confidence":1},{"support":0.044,"rule":"SERV DELI  , HABA","lift":1.827,"confidence":0.3},{"support":0.029,"rule":"M APPAREL  , PHARM OTC","lift":3.35,"confidence":0.25},{"support":0.014,"rule":"DELI  , TOYS/SEAS","lift":4.187,"confidence":0.06},{"support":0.014,"rule":"MEAT  , PHARM OTC","lift":1.675,"confidence":0.13},{"support":0.014,"rule":"PRODUCE  , Mbrship","lift":3.045,"confidence":0.05},{"support":0.059,"rule":"FROZEN FD  , DELI","lift":1.861,"confidence":0.44},{"support":0.014,"rule":"JEWELRY  , BAKERY","lift":4.785,"confidence":0.5},{"support":0.059,"rule":"SUNDRIES  , HARDWARE","lift":1.456,"confidence":0.17},{"support":0.014,"rule":"COOLER  , OFFICE","lift":2.68,"confidence":0.04},{"support":0.104,"rule":"FROZEN FD  , FOOD","lift":2.265,"confidence":0.78},{"support":0.014,"rule":"COOLER  , Mbrship","lift":2.68,"confidence":0.04},{"support":0.029,"rule":"NFTCKTS  , NFTCKTS","lift":33.5,"confidence":1},{"support":0.014,"rule":"COOLER  , FOOD CT","lift":2.68,"confidence":0.04},{"support":0.089,"rule":"SERV DELI  , SUNDRIES","lift":1.747,"confidence":0.6},{"support":0.104,"rule":"FOOD  , MEAT","lift":2.548,"confidence":0.3},{"support":0.074,"rule":"CANDY  , M APPAREL","lift":2.617,"confidence":0.31},{"support":0.014,"rule":"OFFICE  , PHARM OTC","lift":13.4,"confidence":1},{"support":0.014,"rule":"DELI  , GARDEN","lift":1.046,"confidence":0.06},{"support":0.014,"rule":"MEDIA  , PRODUCE","lift":3.045,"confidence":1},{"support":0.029,"rule":"PHARM OTC  , HABA","lift":2.436,"confidence":0.4},{"support":0.343,"rule":"SUNDRIES  , SUNDRIES","lift":2.913,"confidence":1},{"support":0.014,"rule":"FROZEN FD  , JEWELRY","lift":3.722,"confidence":0.11},{"support":0.044,"rule":"M APPAREL  , MEAT","lift":3.14,"confidence":0.38},{"support":0.014,"rule":"CANDY  , OFFICE","lift":4.187,"confidence":0.06},{"support":0.074,"rule":"COOLER  , HARDWARE","lift":1.675,"confidence":0.2},{"support":0.089,"rule":"FROZEN FD  , PRODUCE","lift":2.03,"confidence":0.67},{"support":0.014,"rule":"TOYS/SEAS  , OPTICAL","lift":67,"confidence":1},{"support":0.014,"rule":"FOOD  , FOOD CT","lift":2.913,"confidence":0.04},{"support":0.089,"rule":"PRODUCE  , MEAT","lift":2.284,"confidence":0.27},{"support":0.014,"rule":"Mbrship  , COOLER","lift":2.68,"confidence":1},{"support":0.014,"rule":"SERV DELI  , FOOD CT","lift":6.7,"confidence":0.1},{"support":0.029,"rule":"MEAT  , HABA","lift":1.522,"confidence":0.25},{"support":0.029,"rule":"PHARM OTC  , M APPAREL","lift":3.35,"confidence":0.4},{"support":0.044,"rule":"PHARM OTC  , FOOD","lift":1.747,"confidence":0.6},{"support":0.014,"rule":"HOUSEWRS  , HABA","lift":2.03,"confidence":0.33},{"support":0.029,"rule":"FOOD  , DOMESTICS","lift":1.165,"confidence":0.09},{"support":0.268,"rule":"FOOD  , SUNDRIES","lift":2.279,"confidence":0.78},{"support":0.014,"rule":"MEDIA  , HABA","lift":6.09,"confidence":1},{"support":0.014,"rule":"JEWELRY  , FOOD","lift":1.456,"confidence":0.5},{"support":0.029,"rule":"MEAT  , MAJORS","lift":4.187,"confidence":0.25},{"support":0.074,"rule":"SERV DELI  , CANDY","lift":2.093,"confidence":0.5},{"support":0.029,"rule":"HOUSEWRS  , DOMESTICS","lift":8.933,"confidence":0.67},{"support":0.029,"rule":"CANDY  , JEWELRY","lift":4.187,"confidence":0.13},{"support":0.104,"rule":"HABA  , FOOD","lift":1.853,"confidence":0.64},{"support":0.179,"rule":"CANDY  , PRODUCE","lift":2.284,"confidence":0.75},{"support":0.044,"rule":"HABA  , SERV DELI","lift":1.827,"confidence":0.27},{"support":0.074,"rule":"PRODUCE  , SERV DELI","lift":1.522,"confidence":0.23},{"support":0.014,"rule":"BAKERY  , TOYS/SEAS","lift":9.571,"confidence":0.14},{"support":0.059,"rule":"CANDY  , HARDWARE","lift":2.093,"confidence":0.25},{"support":0.014,"rule":"HARDWARE  , GARDEN","lift":2.093,"confidence":0.13},{"support":0.029,"rule":"SM APPL  , COOLER","lift":1.786,"confidence":0.67},{"support":0.149,"rule":"DELI  , FOOD","lift":1.82,"confidence":0.63},{"support":0.014,"rule":"HABA  , FOOD CT","lift":6.09,"confidence":0.09},{"support":0.119,"rule":"SUNDRIES  , FROZEN FD","lift":2.589,"confidence":0.35},{"support":0.014,"rule":"HABA  , OFFICE","lift":6.09,"confidence":0.09},{"support":0.029,"rule":"SUNDRIES  , SM APPL","lift":1.942,"confidence":0.09},{"support":0.014,"rule":"HOUSEWRS  , MEAT","lift":2.791,"confidence":0.33},{"support":0.029,"rule":"PRODUCE  , HOUSEWRS","lift":2.03,"confidence":0.09},{"support":0.014,"rule":"GARDEN  , OFFICE","lift":16.75,"confidence":0.25},{"support":0.059,"rule":"FROZEN FD  , CANDY","lift":1.861,"confidence":0.44},{"support":0.104,"rule":"FOOD  , HABA","lift":1.853,"confidence":0.3},{"support":0.014,"rule":"LIQUOR  , GARDEN","lift":16.75,"confidence":1},{"support":0.238,"rule":"COOLER  , PRODUCE","lift":1.949,"confidence":0.64},{"support":0.223,"rule":"SUNDRIES  , PRODUCE","lift":1.986,"confidence":0.65},{"support":0.014,"rule":"Mbrship  , FOOD","lift":2.913,"confidence":1},{"support":0.014,"rule":"OPTICAL  , FROZEN FD","lift":7.444,"confidence":1},{"support":0.014,"rule":"OFFICE  , OFFICE","lift":67,"confidence":1},{"support":0.074,"rule":"BAKERY  , PRODUCE","lift":2.175,"confidence":0.71},{"support":0.014,"rule":"SUNDRIES  , OPTICAL","lift":2.913,"confidence":0.04},{"support":0.074,"rule":"SUNDRIES  , MEAT","lift":1.82,"confidence":0.22},{"support":0.029,"rule":"GARDEN  , COOLER","lift":1.34,"confidence":0.5},{"support":0.014,"rule":"DELI  , OPTICAL","lift":4.187,"confidence":0.06},{"support":0.029,"rule":"JEWELRY  , COOLER","lift":2.68,"confidence":1},{"support":0.029,"rule":"BAKERY  , MEAT","lift":2.392,"confidence":0.29},{"support":0.238,"rule":"PRODUCE  , COOLER","lift":1.949,"confidence":0.73},{"support":0.089,"rule":"SERV DELI  , DELI","lift":2.512,"confidence":0.6},{"support":0.014,"rule":"HABA  , W APPAREL","lift":1.015,"confidence":0.09},{"support":0.044,"rule":"SERV DELI  , M APPAREL","lift":2.512,"confidence":0.3},{"support":0.119,"rule":"MEAT  , MEAT","lift":8.375,"confidence":1},{"support":0.014,"rule":"SERV DELI  , SM APPL","lift":2.233,"confidence":0.1},{"support":0.014,"rule":"HOUSEWRS  , FOOD","lift":0.971,"confidence":0.33},{"support":0.014,"rule":"OFFICE  , M APPAREL","lift":8.375,"confidence":1},{"support":0.044,"rule":"PRODUCE  , PHARM OTC","lift":1.827,"confidence":0.14},{"support":0.014,"rule":"OFFICE  , HOUSEWRS","lift":22.333,"confidence":1},{"support":0.059,"rule":"MAJORS  , MAJORS","lift":16.75,"confidence":1},{"support":0.059,"rule":"HARDWARE  , PRODUCE","lift":1.522,"confidence":0.5},{"support":0.014,"rule":"DELI  , FOOD CT","lift":4.187,"confidence":0.06},{"support":0.104,"rule":"MEAT  , FOOD","lift":2.548,"confidence":0.88},{"support":0.014,"rule":"GARDEN  , SM APPL","lift":5.583,"confidence":0.25},{"support":0.014,"rule":"PRODUCE  , TOYS/SEAS","lift":3.045,"confidence":0.05},{"support":0.014,"rule":"TOYS/SEAS  , PRODUCE","lift":3.045,"confidence":1},{"support":0.029,"rule":"SUNDRIES  , GARDEN","lift":1.456,"confidence":0.09},{"support":0.014,"rule":"PRODUCE  , MEDIA","lift":3.045,"confidence":0.05},{"support":0.014,"rule":"FOOD CT  , HABA","lift":6.09,"confidence":1},{"support":0.044,"rule":"HOUSEWRS  , HOUSEWRS","lift":22.333,"confidence":1},{"support":0.074,"rule":"PRODUCE  , BAKERY","lift":2.175,"confidence":0.23},{"support":0.268,"rule":"SUNDRIES  , FOOD","lift":2.279,"confidence":0.78},{"support":0.029,"rule":"HOUSEWRS  , DELI","lift":2.791,"confidence":0.67},{"support":0.119,"rule":"FROZEN FD  , SUNDRIES","lift":2.589,"confidence":0.89},{"support":0.089,"rule":"W APPAREL  , W APPAREL","lift":11.166,"confidence":1},{"support":0.014,"rule":"MEAT  , FOOD CT","lift":8.375,"confidence":0.13},{"support":0.014,"rule":"PHARM  RX  , PHARM  RX","lift":67,"confidence":1},{"support":0.074,"rule":"M APPAREL  , SUNDRIES","lift":1.82,"confidence":0.63},{"support":0.014,"rule":"HOUSEWRS  , GARDEN","lift":5.583,"confidence":0.33},{"support":0.059,"rule":"DELI  , DOMESTICS","lift":3.35,"confidence":0.25},{"support":0.014,"rule":"HABA  , SM APPL","lift":2.03,"confidence":0.09},{"support":0.238,"rule":"CANDY  , CANDY","lift":4.187,"confidence":1},{"support":0.029,"rule":"JEWELRY  , SUNDRIES","lift":2.913,"confidence":1},{"support":0.104,"rule":"CANDY  , DELI","lift":1.832,"confidence":0.44},{"support":0.029,"rule":"HOUSEWRS  , PRODUCE","lift":2.03,"confidence":0.67},{"support":0.029,"rule":"CANDY  , W APPAREL","lift":1.395,"confidence":0.13},{"support":0.104,"rule":"DELI  , CANDY","lift":1.832,"confidence":0.44},{"support":0.044,"rule":"DELI  , W APPAREL","lift":2.093,"confidence":0.19},{"support":0.014,"rule":"HOUSEWRS  , SUNDRIES","lift":0.971,"confidence":0.33},{"support":0.014,"rule":"SM APPL  , PHARM OTC","lift":4.466,"confidence":0.33},{"support":0.014,"rule":"MAJORS  , SM APPL","lift":5.583,"confidence":0.25},{"support":0.104,"rule":"BAKERY  , BAKERY","lift":9.571,"confidence":1},{"support":0.059,"rule":"DOMESTICS  , DELI","lift":3.35,"confidence":0.8},{"support":0.059,"rule":"W APPAREL  , FOOD","lift":1.942,"confidence":0.67},{"support":0.014,"rule":"CANDY  , HOUSEWRS","lift":1.395,"confidence":0.06},{"support":0.014,"rule":"MEDIA  , HARDWARE","lift":8.375,"confidence":1},{"support":0.134,"rule":"DELI  , PRODUCE","lift":1.713,"confidence":0.56},{"support":0.029,"rule":"HABA  , MEAT","lift":1.522,"confidence":0.18},{"support":0.014,"rule":"MAJORS  , W APPAREL","lift":2.791,"confidence":0.25},{"support":0.059,"rule":"HARDWARE  , SERV DELI","lift":3.35,"confidence":0.5},{"support":0.029,"rule":"DOMESTICS  , CANDY","lift":1.675,"confidence":0.4},{"support":0.014,"rule":"HOUSEWRS  , PHARM OTC","lift":4.466,"confidence":0.33},{"support":0.029,"rule":"SERV DELI  , W APPAREL","lift":2.233,"confidence":0.2},{"support":0.119,"rule":"M APPAREL  , M APPAREL","lift":8.375,"confidence":1},{"support":0.029,"rule":"SM APPL  , DELI","lift":2.791,"confidence":0.67},{"support":0.074,"rule":"BAKERY  , SUNDRIES","lift":2.08,"confidence":0.71},{"support":0.014,"rule":"Mbrship  , FROZEN FD","lift":7.444,"confidence":1},{"support":0.029,"rule":"BAKERY  , DELI","lift":1.196,"confidence":0.29},{"support":0.014,"rule":"HOUSEWRS  , COOLER","lift":0.893,"confidence":0.33},{"support":0.014,"rule":"FOOD  , OFFICE","lift":2.913,"confidence":0.04},{"support":0.029,"rule":"GARDEN  , HABA","lift":3.045,"confidence":0.5},{"support":0.029,"rule":"HARDWARE  , PHARM OTC","lift":3.35,"confidence":0.25},{"support":0.014,"rule":"OPTICAL  , DELI","lift":4.187,"confidence":1},{"support":0.014,"rule":"FROZEN FD  , GARDEN","lift":1.861,"confidence":0.11},{"support":0.014,"rule":"SM APPL  , W APPAREL","lift":3.722,"confidence":0.33},{"support":0.119,"rule":"HABA  , COOLER","lift":1.949,"confidence":0.73},{"support":0.014,"rule":"CANDY  , FOOD CT","lift":4.187,"confidence":0.06},{"support":0.044,"rule":"FOOD  , PHARM OTC","lift":1.747,"confidence":0.13},{"support":0.074,"rule":"CANDY  , HABA","lift":1.903,"confidence":0.31},{"support":0.343,"rule":"FOOD  , FOOD","lift":2.913,"confidence":1},{"support":0.014,"rule":"FROZEN FD  , LIQUOR","lift":7.444,"confidence":0.11},{"support":0.044,"rule":"SM APPL  , SM APPL","lift":22.333,"confidence":1},{"support":0.014,"rule":"MAJORS  , CANDY","lift":1.046,"confidence":0.25},{"support":0.014,"rule":"M APPAREL  , DOMESTICS","lift":1.675,"confidence":0.13},{"support":0.074,"rule":"MEAT  , SUNDRIES","lift":1.82,"confidence":0.63},{"support":0.014,"rule":"Mbrship  , DOMESTICS","lift":13.4,"confidence":1},{"support":0.059,"rule":"MEAT  , CANDY","lift":2.093,"confidence":0.5},{"support":0.014,"rule":"GARDEN  , FROZEN FD","lift":1.861,"confidence":0.25},{"support":0.029,"rule":"MEAT  , W APPAREL","lift":2.791,"confidence":0.25},{"support":0.029,"rule":"SM APPL  , MEAT","lift":5.583,"confidence":0.67},{"support":0.014,"rule":"FOOD CT  , DELI","lift":4.187,"confidence":1},{"support":0.059,"rule":"SERV DELI  , MEAT","lift":3.35,"confidence":0.4},{"support":0.059,"rule":"GARDEN  , GARDEN","lift":16.75,"confidence":1},{"support":0.014,"rule":"SERV DELI  , Mbrship","lift":6.7,"confidence":0.1},{"support":0.059,"rule":"CANDY  , PHARM OTC","lift":3.35,"confidence":0.25},{"support":0.014,"rule":"Mbrship  , Mbrship","lift":67,"confidence":1},{"support":0.014,"rule":"PHARM OTC  , HOUSEWRS","lift":4.466,"confidence":0.2},{"support":0.074,"rule":"MEAT  , DELI","lift":2.617,"confidence":0.63},{"support":0.014,"rule":"JEWELRY  , DELI","lift":2.093,"confidence":0.5},{"support":0.014,"rule":"CANDY  , SM APPL","lift":1.395,"confidence":0.06},{"support":0.014,"rule":"LIQUOR  , SUNDRIES","lift":2.913,"confidence":1},{"support":0.014,"rule":"BAKERY  , HARDWARE","lift":1.196,"confidence":0.14},{"support":0.029,"rule":"W APPAREL  , SERV DELI","lift":2.233,"confidence":0.33},{"support":0.014,"rule":"PRODUCE  , OFFICE","lift":3.045,"confidence":0.05},{"support":0.014,"rule":"CANDY  , MAJORS","lift":1.046,"confidence":0.06},{"support":0.089,"rule":"HABA  , DELI","lift":2.284,"confidence":0.55},{"support":0.014,"rule":"SM APPL  , SERV DELI","lift":2.233,"confidence":0.33},{"support":0.074,"rule":"SERV DELI  , PRODUCE","lift":1.522,"confidence":0.5},{"support":0.029,"rule":"DELI  , SM APPL","lift":2.791,"confidence":0.13},{"support":0.014,"rule":"OPTICAL  , SUNDRIES","lift":2.913,"confidence":1},{"support":0.029,"rule":"M APPAREL  , HARDWARE","lift":2.093,"confidence":0.25},{"support":0.014,"rule":"BAKERY  , OPTICAL","lift":9.571,"confidence":0.14},{"support":0.014,"rule":"FOOD  , TOYS/SEAS","lift":2.913,"confidence":0.04},{"support":0.014,"rule":"FROZEN FD  , Mbrship","lift":7.444,"confidence":0.11},{"support":0.014,"rule":"DELI  , MEDIA","lift":4.187,"confidence":0.06},{"support":0.029,"rule":"SERV DELI  , DOMESTICS","lift":2.68,"confidence":0.2},{"support":0.014,"rule":"MEAT  , HOUSEWRS","lift":2.791,"confidence":0.13},{"support":0.014,"rule":"SUNDRIES  , OFFICE","lift":2.913,"confidence":0.04},{"support":0.014,"rule":"Mbrship  , SUNDRIES","lift":2.913,"confidence":1},{"support":0.014,"rule":"DELI  , Mbrship","lift":4.187,"confidence":0.06},{"support":0.014,"rule":"DELI  , JEWELRY","lift":2.093,"confidence":0.06},{"support":0.238,"rule":"DELI  , DELI","lift":4.187,"confidence":1},{"support":0.014,"rule":"FOOD  , GARDEN","lift":0.728,"confidence":0.04},{"support":0.014,"rule":"PHARM OTC  , W APPAREL","lift":2.233,"confidence":0.2},{"support":0.014,"rule":"HOUSEWRS  , M APPAREL","lift":2.791,"confidence":0.33},{"support":0.283,"rule":"SUNDRIES  , COOLER","lift":2.213,"confidence":0.83},{"support":0.074,"rule":"M APPAREL  , COOLER","lift":1.675,"confidence":0.63},{"support":0.059,"rule":"SERV DELI  , FROZEN FD","lift":2.977,"confidence":0.4},{"support":0.014,"rule":"HABA  , MEDIA","lift":6.09,"confidence":0.09},{"support":0.014,"rule":"LIQUOR  , LIQUOR","lift":67,"confidence":1},{"support":0.179,"rule":"PRODUCE  , CANDY","lift":2.284,"confidence":0.55},{"support":0.029,"rule":"SUNDRIES  , DOMESTICS","lift":1.165,"confidence":0.09},{"support":0.298,"rule":"COOLER  , FOOD","lift":2.33,"confidence":0.8},{"support":0.014,"rule":"Mbrship  , PRODUCE","lift":3.045,"confidence":1},{"support":0.059,"rule":"CANDY  , MEAT","lift":2.093,"confidence":0.25},{"support":0.268,"rule":"GASOLINE  , GASOLINE","lift":3.722,"confidence":1},{"support":0.119,"rule":"COOLER  , SERV DELI","lift":2.144,"confidence":0.32},{"support":0.044,"rule":"W APPAREL  , DELI","lift":2.093,"confidence":0.5},{"support":0.149,"rule":"FOOD  , DELI","lift":1.82,"confidence":0.43},{"support":0.014,"rule":"PHARM OTC  , MEAT","lift":1.675,"confidence":0.2},{"support":0.044,"rule":"W APPAREL  , SUNDRIES","lift":1.456,"confidence":0.5},{"support":0.029,"rule":"MAJORS  , FOOD","lift":1.456,"confidence":0.5},{"support":0.029,"rule":"JEWELRY  , JEWELRY","lift":33.5,"confidence":1},{"support":0.044,"rule":"HABA  , M APPAREL","lift":2.284,"confidence":0.27},{"support":0.059,"rule":"PHARM OTC  , COOLER","lift":2.144,"confidence":0.8},{"support":0.014,"rule":"GARDEN  , PHARM OTC","lift":3.35,"confidence":0.25},{"support":0.074,"rule":"DOMESTICS  , DOMESTICS","lift":13.4,"confidence":1},{"support":0.029,"rule":"M APPAREL  , FROZEN FD","lift":1.861,"confidence":0.25},{"support":0.014,"rule":"OFFICE  , HABA","lift":6.09,"confidence":1},{"support":0.029,"rule":"MEAT  , BAKERY","lift":2.392,"confidence":0.25},{"support":0.179,"rule":"FOOD  , CANDY","lift":2.184,"confidence":0.52},{"support":0.014,"rule":"MEDIA  , FOOD","lift":2.913,"confidence":1},{"support":0.014,"rule":"FROZEN FD  , SM APPL","lift":2.481,"confidence":0.11},{"support":0.059,"rule":"HARDWARE  , HABA","lift":3.045,"confidence":0.5},{"support":0.044,"rule":"MEAT  , M APPAREL","lift":3.14,"confidence":0.38},{"support":0.029,"rule":"DOMESTICS  , HOUSEWRS","lift":8.933,"confidence":0.4},{"support":0.029,"rule":"FROZEN FD  , M APPAREL","lift":1.861,"confidence":0.22},{"support":0.104,"rule":"SUNDRIES  , HABA","lift":1.853,"confidence":0.3},{"support":0.164,"rule":"COOLER  , DELI","lift":1.842,"confidence":0.44},{"support":0.014,"rule":"M APPAREL  , HOUSEWRS","lift":2.791,"confidence":0.13},{"support":0.014,"rule":"SM APPL  , DOMESTICS","lift":4.466,"confidence":0.33},{"support":0.104,"rule":"COOLER  , MEAT","lift":2.345,"confidence":0.28},{"support":0.014,"rule":"MAJORS  , FROZEN FD","lift":1.861,"confidence":0.25},{"support":0.104,"rule":"FOOD  , FROZEN FD","lift":2.265,"confidence":0.3},{"support":0.014,"rule":"FOOD  , Mbrship","lift":2.913,"confidence":0.04},{"support":0.029,"rule":"DELI  , BAKERY","lift":1.196,"confidence":0.13},{"support":0.164,"rule":"SUNDRIES  , CANDY","lift":2.002,"confidence":0.48},{"support":0.014,"rule":"BAKERY  , PHARM OTC","lift":1.914,"confidence":0.14},{"support":0.029,"rule":"HABA  , PHARM OTC","lift":2.436,"confidence":0.18},{"support":0.014,"rule":"SUNDRIES  , MAJORS","lift":0.728,"confidence":0.04},{"support":0.014,"rule":"JEWELRY  , FROZEN FD","lift":3.722,"confidence":0.5},{"support":0.014,"rule":"MAJORS  , SERV DELI","lift":1.675,"confidence":0.25},{"support":0.029,"rule":"MAJORS  , COOLER","lift":1.34,"confidence":0.5},{"support":0.014,"rule":"GARDEN  , LIQUOR","lift":16.75,"confidence":0.25},{"support":0.014,"rule":"SUNDRIES  , LIQUOR","lift":2.913,"confidence":0.04},{"support":0.014,"rule":"SUNDRIES  , TOYS/SEAS","lift":2.913,"confidence":0.04},{"support":0.014,"rule":"MAJORS  , DELI","lift":1.046,"confidence":0.25},{"support":0.059,"rule":"PRODUCE  , W APPAREL","lift":2.03,"confidence":0.18},{"support":0.014,"rule":"GARDEN  , CANDY","lift":1.046,"confidence":0.25},{"support":0.029,"rule":"COOLER  , MAJORS","lift":1.34,"confidence":0.08},{"support":0.029,"rule":"CANDY  , DOMESTICS","lift":1.675,"confidence":0.13},{"support":0.014,"rule":"TOYS/SEAS  , CANDY","lift":4.187,"confidence":1},{"support":0.119,"rule":"HARDWARE  , HARDWARE","lift":8.375,"confidence":1},{"support":0.029,"rule":"PHARM OTC  , SERV DELI","lift":2.68,"confidence":0.4},{"support":0.014,"rule":"SM APPL  , CANDY","lift":1.395,"confidence":0.33},{"support":0.014,"rule":"TOYS/SEAS  , TOYS/SEAS","lift":67,"confidence":1},{"support":0.014,"rule":"OFFICE  , GARDEN","lift":16.75,"confidence":1},{"support":0.059,"rule":"PRODUCE  , HARDWARE","lift":1.522,"confidence":0.18},{"support":0.014,"rule":"CANDY  , OPTICAL","lift":4.187,"confidence":0.06},{"support":0.014,"rule":"PHARM OTC  , BAKERY","lift":1.914,"confidence":0.2},{"support":0.014,"rule":"FOOD  , MEDIA","lift":2.913,"confidence":0.04},{"support":0.014,"rule":"LIQUOR  , COOLER","lift":2.68,"confidence":1},{"support":0.014,"rule":"HOUSEWRS  , W APPAREL","lift":3.722,"confidence":0.33},{"support":0.029,"rule":"SERV DELI  , BAKERY","lift":1.914,"confidence":0.2},{"support":0.014,"rule":"JEWELRY  , HARDWARE","lift":4.187,"confidence":0.5},{"support":0.014,"rule":"SM APPL  , MAJORS","lift":5.583,"confidence":0.33},{"support":0.014,"rule":"COOLER  , TOYS/SEAS","lift":2.68,"confidence":0.04},{"support":0.029,"rule":"PRODUCE  , SM APPL","lift":2.03,"confidence":0.09},{"support":0.029,"rule":"MAJORS  , PRODUCE","lift":1.522,"confidence":0.5},{"support":0.223,"rule":"FOOD  , PRODUCE","lift":1.986,"confidence":0.65},{"support":0.014,"rule":"DELI  , PHARM OTC","lift":0.837,"confidence":0.06},{"support":0.014,"rule":"MEAT  , MEDIA","lift":8.375,"confidence":0.13},{"support":0.014,"rule":"FOOD CT  , MEAT","lift":8.375,"confidence":1},{"support":0.014,"rule":"CANDY  , TOYS/SEAS","lift":4.187,"confidence":0.06},{"support":0.014,"rule":"PHARM OTC  , DELI","lift":0.837,"confidence":0.2},{"support":0.014,"rule":"W APPAREL  , FROZEN FD","lift":1.24,"confidence":0.17},{"support":0.149,"rule":"SERV DELI  , SERV DELI","lift":6.7,"confidence":1},{"support":0.014,"rule":"PRODUCE  , FOOD CT","lift":3.045,"confidence":0.05},{"support":0.044,"rule":"M APPAREL  , HABA","lift":2.284,"confidence":0.38},{"support":0.014,"rule":"MAJORS  , SUNDRIES","lift":0.728,"confidence":0.25},{"support":0.029,"rule":"DELI  , M APPAREL","lift":1.046,"confidence":0.13},{"support":0.208,"rule":"CANDY  , COOLER","lift":2.345,"confidence":0.88},{"support":0.029,"rule":"HARDWARE  , FROZEN FD","lift":1.861,"confidence":0.25},{"support":0.074,"rule":"SUNDRIES  , M APPAREL","lift":1.82,"confidence":0.22},{"support":0.014,"rule":"HABA  , FROZEN FD","lift":0.676,"confidence":0.09},{"support":0.014,"rule":"FOOD CT  , COOLER","lift":2.68,"confidence":1},{"support":0.029,"rule":"MEAT  , DOMESTICS","lift":3.35,"confidence":0.25},{"support":0.104,"rule":"HABA  , SUNDRIES","lift":1.853,"confidence":0.64},{"support":0.014,"rule":"SUNDRIES  , MEDIA","lift":2.913,"confidence":0.04},{"support":0.014,"rule":"TOYS/SEAS  , DELI","lift":4.187,"confidence":1},{"support":0.044,"rule":"SUNDRIES  , W APPAREL","lift":1.456,"confidence":0.13},{"support":0.044,"rule":"PHARM OTC  , SUNDRIES","lift":1.747,"confidence":0.6},{"support":0.014,"rule":"OFFICE  , COOLER","lift":2.68,"confidence":1},{"support":0.029,"rule":"HARDWARE  , M APPAREL","lift":2.093,"confidence":0.25},{"support":0.014,"rule":"COOLER  , HOUSEWRS","lift":0.893,"confidence":0.04},{"support":0.074,"rule":"CANDY  , SERV DELI","lift":2.093,"confidence":0.31},{"support":0.014,"rule":"OPTICAL  , COOLER","lift":2.68,"confidence":1},{"support":0.074,"rule":"PRODUCE  , M APPAREL","lift":1.903,"confidence":0.23},{"support":0.014,"rule":"FOOD CT  , PRODUCE","lift":3.045,"confidence":1},{"support":0.014,"rule":"LIQUOR  , FROZEN FD","lift":7.444,"confidence":1},{"support":0.014,"rule":"SM APPL  , GARDEN","lift":5.583,"confidence":0.33},{"support":0.014,"rule":"SM APPL  , FROZEN FD","lift":2.481,"confidence":0.33},{"support":0.014,"rule":"GARDEN  , DELI","lift":1.046,"confidence":0.25},{"support":0.014,"rule":"Mbrship  , DELI","lift":4.187,"confidence":1},{"support":0.059,"rule":"DELI  , FROZEN FD","lift":1.861,"confidence":0.25},{"support":0.014,"rule":"W APPAREL  , SM APPL","lift":3.722,"confidence":0.17},{"support":0.014,"rule":"MEDIA  , MEDIA","lift":67,"confidence":1},{"support":0.014,"rule":"W APPAREL  , HABA","lift":1.015,"confidence":0.17},{"support":0.059,"rule":"HARDWARE  , SUNDRIES","lift":1.456,"confidence":0.5},{"support":0.014,"rule":"DOMESTICS  , M APPAREL","lift":1.675,"confidence":0.2},{"support":0.029,"rule":"W APPAREL  , CANDY","lift":1.395,"confidence":0.33},{"support":0.014,"rule":"GARDEN  , FOOD","lift":0.728,"confidence":0.25},{"support":0.014,"rule":"PHARM OTC  , SM APPL","lift":4.466,"confidence":0.2},{"support":0.014,"rule":"OPTICAL  , TOYS/SEAS","lift":67,"confidence":1},{"support":0.059,"rule":"PHARM OTC  , CANDY","lift":3.35,"confidence":0.8},{"support":0.029,"rule":"FOOD  , MAJORS","lift":1.456,"confidence":0.09},{"support":0.029,"rule":"MEAT  , SM APPL","lift":5.583,"confidence":0.25},{"support":0.059,"rule":"DELI  , HARDWARE","lift":2.093,"confidence":0.25},{"support":0.014,"rule":"HOUSEWRS  , OFFICE","lift":22.333,"confidence":0.33},{"support":0.014,"rule":"M APPAREL  , SM APPL","lift":2.791,"confidence":0.13},{"support":0.014,"rule":"HABA  , HOUSEWRS","lift":2.03,"confidence":0.09},{"support":0.014,"rule":"GARDEN  , HOUSEWRS","lift":5.583,"confidence":0.25},{"support":0.029,"rule":"COOLER  , JEWELRY","lift":2.68,"confidence":0.08},{"support":0.014,"rule":"PRODUCE  , OPTICAL","lift":3.045,"confidence":0.05},{"support":0.014,"rule":"FROZEN FD  , OPTICAL","lift":7.444,"confidence":0.11},{"support":0.044,"rule":"COOLER  , W APPAREL","lift":1.34,"confidence":0.12},{"support":0.089,"rule":"DELI  , HABA","lift":2.284,"confidence":0.38},{"support":0.179,"rule":"CANDY  , FOOD","lift":2.184,"confidence":0.75},{"support":0.044,"rule":"W APPAREL  , COOLER","lift":1.34,"confidence":0.5},{"support":0.328,"rule":"PRODUCE  , PRODUCE","lift":3.045,"confidence":1},{"support":0.029,"rule":"M APPAREL  , DELI","lift":1.046,"confidence":0.25},{"support":0.014,"rule":"Mbrship  , SERV DELI","lift":6.7,"confidence":1},{"support":0.014,"rule":"MEDIA  , MEAT","lift":8.375,"confidence":1},{"support":0.059,"rule":"FROZEN FD  , SERV DELI","lift":2.977,"confidence":0.44},{"support":0.014,"rule":"FOOD CT  , M APPAREL","lift":8.375,"confidence":1},{"support":0.014,"rule":"FROZEN FD  , TOYS/SEAS","lift":7.444,"confidence":0.11},{"support":0.029,"rule":"GARDEN  , PRODUCE","lift":1.522,"confidence":0.5},{"support":0.074,"rule":"FOOD  , M APPAREL","lift":1.82,"confidence":0.22},{"support":0.014,"rule":"SERV DELI  , GARDEN","lift":1.675,"confidence":0.1},{"support":0.044,"rule":"M APPAREL  , SERV DELI","lift":2.512,"confidence":0.38},{"support":0.164,"rule":"HABA  , HABA","lift":6.09,"confidence":1},{"support":0.059,"rule":"COOLER  , PHARM OTC","lift":2.144,"confidence":0.16},{"support":0.119,"rule":"COOLER  , HABA","lift":1.949,"confidence":0.32},{"support":0.059,"rule":"FOOD  , BAKERY","lift":1.664,"confidence":0.17},{"support":0.044,"rule":"PHARM OTC  , PRODUCE","lift":1.827,"confidence":0.6},{"support":0.059,"rule":"HARDWARE  , CANDY","lift":2.093,"confidence":0.5},{"support":0.014,"rule":"MEDIA  , COOLER","lift":2.68,"confidence":1},{"support":0.014,"rule":"W APPAREL  , MAJORS","lift":2.791,"confidence":0.17},{"support":0.029,"rule":"DELI  , HOUSEWRS","lift":2.791,"confidence":0.13},{"support":0.014,"rule":"TOYS/SEAS  , FOOD","lift":2.913,"confidence":1},{"support":0.029,"rule":"PRODUCE  , JEWELRY","lift":3.045,"confidence":0.09},{"support":0.014,"rule":"OPTICAL  , FOOD","lift":2.913,"confidence":1},{"support":0.223,"rule":"PRODUCE  , FOOD","lift":1.986,"confidence":0.68},{"support":0.074,"rule":"HABA  , PRODUCE","lift":1.384,"confidence":0.45},{"support":0.029,"rule":"DOMESTICS  , MEAT","lift":3.35,"confidence":0.4},{"support":0.014,"rule":"SM APPL  , OFFICE","lift":22.333,"confidence":0.33},{"support":0.149,"rule":"DELI  , SUNDRIES","lift":1.82,"confidence":0.63},{"support":0.014,"rule":"HARDWARE  , MEDIA","lift":8.375,"confidence":0.13},{"support":0.014,"rule":"FOOD  , OPTICAL","lift":2.913,"confidence":0.04},{"support":0.014,"rule":"COOLER  , OPTICAL","lift":2.68,"confidence":0.04},{"support":0.014,"rule":"FROZEN FD  , FOOD CT","lift":7.444,"confidence":0.11},{"support":0.089,"rule":"DELI  , SERV DELI","lift":2.512,"confidence":0.38},{"support":0.014,"rule":"M APPAREL  , BAKERY","lift":1.196,"confidence":0.13},{"support":0.223,"rule":"PRODUCE  , SUNDRIES","lift":1.986,"confidence":0.68},{"support":0.014,"rule":"MEDIA  , DELI","lift":4.187,"confidence":1},{"support":0.014,"rule":"DOMESTICS  , Mbrship","lift":13.4,"confidence":0.2}];

//console.log(scatterplotdata);
//console.log(sampledata);
// call the method below
//showScatterPlot(scatterplotdata);

function showScatterPlot(data) {
    // just to have some space around items. 
    var margins = {
        "left": 40,
            "right": 30,
            "top": 30,
            "bottom": 30
    };
    
    var width = 500;
    var height = 350;
    var	z = d3.scale.linear().domain([d3.min(sampledata, function (d) {
                            return (d.lift);
                        }),
                        d3.max(sampledata, function (d) {
                            return d.lift;
                        })]).clamp(true);
    // this will be our colour scale. An Ordinal scale.
    var colors = d3.scale.category10();

    // we add the SVG component to the scatter-load div
    var svg = d3.select("#scatter-load").append("svg").attr("width", width).attr("height", height).append("g")
        .attr("transform", "translate(" + margins.left + "," + margins.top + ")");

    // this sets the scale that we're using for the X axis. 
    // the domain define the min and max variables to show. In this case, it's the min and max supports of items.
    // this is made a compact piece of code due to d3.extent which gives back the max and min of the support variable within the dataset
    var x = d3.scale.linear()
        .domain(d3.extent(data, function (d) {
        return d.support;
    }))
    // the range maps the domain to values from 0 to the width minus the left and right margins (used to space out the visualization)
        .range([0, width - margins.left - margins.right]);

    // this does the same as for the y axis but maps from the confidence variable to the height to 0. 
    var y = d3.scale.linear()
        .domain(d3.extent(data, function (d) {
        return d.confidence;
    }))
    // Note that height goes first due to the weird SVG coordinate system
    .range([height - margins.top - margins.bottom, 0]);

    // we add the axes SVG component. At this point, this is just a placeholder. The actual axis will be added in a bit
    svg.append("g").attr("class", "x axis").attr("transform", "translate(0," + y.range()[0] + ")");
    svg.append("g").attr("class", "y axis");

    // this is our X axis label. Nothing too special to see here.
    svg.append("text")
        .attr("fill", "#414241")
        .attr("text-anchor", "end")
        .attr("x", width / 2)
        .attr("y", height - 35)
        .text("Support");
	svg.append("text")
		.attr("transform", "rotate(-90)")
		.attr("y", (0- (margins.left)))
		.attr("x",0- (height / 2))
		.attr("dy", "1em")
		.style("text-anchor", "middle")
		.text("Confidence");

    // this is the actual definition of our x and y axes. The orientation refers to where the labels appear - for the x axis, below or above the line, and for the y axis, left or right of the line. Tick padding refers to how much space between the tick and the label. There are other parameters too - see https://github.com/mbostock/d3/wiki/SVG-Axes for more information
    var xAxis = d3.svg.axis().scale(x).orient("bottom").tickPadding(2);
    var yAxis = d3.svg.axis().scale(y).orient("left").tickPadding(2);

    // this is where we select the axis we created a few lines earlier. See how we select the axis item. in our svg we appended a g element with a x/y and axis class. To pull that back up, we do this svg select, then 'call' the appropriate axis object for rendering.    
    svg.selectAll("g.y.axis").call(yAxis);
    svg.selectAll("g.x.axis").call(xAxis);

    // now, we can get down to the data part, and drawing stuff. We are telling D3 that all nodes (g elements with class node) will have data attached to them. The 'key' we use (to let D3 know the uniqueness of items) will be the rule. Not usually a great key, but fine for this example.
    var chocolate = svg.selectAll("g.node").data(data, function (d) {
        return d.rule;
    });

    // we 'enter' the data, making the SVG group (to contain a circle and text) with a class node. This corresponds with what we told the data it should be above.
    
    var chocolateGroup = chocolate.enter().append("g").attr("class", "node")
    // this is how we set the position of the items. Translate is an incredibly useful function for rotating and positioning items 
    .attr('transform', function (d) {
        return "translate(" + x(d.support) + "," + y(d.confidence) + ")";
    });

    // we add our first graphics element! A circle! 
    chocolateGroup.append("circle")
        .attr("r", 5)
        .attr("class", "dot")
        <!-- .style("fill", function (d) {
            // remember the ordinal scales? We use the colors scale to get a colour for our lift. Now each node will be coloured
            // by who makes the chocolate. 
            <!-- return colors(d.lift); -->
    <!-- }); --> -->
		.style("fill", function(d) {            // <== Add these
            if (d.lift <= 1) {return "yellow"}
			if (d.lift <= 5) {return "blue"}									// <== Add these
            else    { return "red" };         // <== Add these
        });

    // now we add some text, so we can see what each item is.
    chocolateGroup.append("svg:title")
        .style("text-anchor", "middle")
        .attr("dy", -10)
        .text(function (d) {
            // this shouldn't be a surprising statement.
            return d.rule;
    });
} 
</script>
<script>
		var w = 200,
    h = 200,
    r = 85,
    inner = 70,
    color = d3.scale.ordinal()
       <!-- .range(["#5553a2","#3287bd","#65c2a5","#aedca4","#fdae64","#f36e43","#a00042"]); -->
	   .range(["#a00042","#f36e43","#fdae64","#aedca4","#65c2a5","#3287bd","#5553a2"]);

data = [{"label":"7 and above ", "value":15},
		{"label":"6", "value":194}, 
        {"label":"5", "value":567}, 
        {"label":"4", "value":1314},
        {"label":"3", "value":793},
        {"label":"2", "value":1929},
        {"label":"1", "value":1383}];
		
		var legend = d3.select("#chart").append("svg")
		.attr("class", "legend")
		.attr("width", r)
		.attr("height", r * 2)
		.selectAll("g")
		.data(data)
		.enter().append("g")
		.attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

	legend.append("rect")
		.attr("width", 20)
		.attr("height", 20)
		.style("fill", function(d, i) { return color(i); });

	legend.append("text")
		.attr("x", 24)
		.attr("y", 9)
		.attr("dy", ".35em")
		.text(function(d) { return d.label; });
	legend.append("text")
		.attr("x", 3)
		.attr("y", 155)
		.attr("dy", ".35em")
		.style("text-anchor", "left")
		.text("Lift");			
</script>
</div>
</div>	
<div id="footer">Copyright&nbsp;<span class="glyphicon glyphicon-copyright-mark"></span> 2015 by Affine Analytics</div>	
<div class="clearfix visible-lg"></div> 
</body>
</html>

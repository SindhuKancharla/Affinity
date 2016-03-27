<!DOCTYPE html>
<html lang="en">
<head>
  <title>Affine Affinity Tool</title>
  <meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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

/*@import url(../style.css?aea6f0a);*/

.background {
  fill: #eee;
}

line {
  stroke: #fff;
}

text.active {
  fill: red;
  font-weight : bold;
  font-size: larger;
}

text {
  font-family: sans-serif; 
   font-weight : bold;
}


</style>
</head>
<body>
<script type="text/javascript">
$(function() 
{
	$("#anu").hide();
	//$("#matrixplot").hide();
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

     <!-- <a class="navbar-brand" href="#">AFFINE ANALYTICS</a>-->
    </div>
    <div>
      <ul class="nav navbar-nav ">
        <li ><a href="home">Home</a></li>
        <li><a href="viewstrategies">Rules</a></li>
        <li class="active"><a href="scatteraffinity">Dashboard</a></li>
        <li><a href="#">Reports</a></li>
		<li ><a href="runAffinity">Admin</a></li>
      </ul>
	  <ul class="nav navbar-nav navbar-right">
      <!--  <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li> -->
       <!--  <li class="dropdown"><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a> -->
		<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-user"></span> User <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">Sign Out</a></li>
            <li><a href="#">Change Password</a></li>
            <li><a href="#">Contact Support</a></li>
          </ul>
        </li>
		</li>
      </ul>
    </div>
  </div>
</nav>
<div class="col-md-2" id="left">
			<ul class="nav nav-pills nav-stacked" id="leftnav">
				<li id="one"><a href="scatteraffinity"><span class="glyphicon glyphicon-picture"></span> Scatter Plot</a></li>
				<li class="active"><a href="matrixaffinity"><span class="glyphicon glyphicon-picture"></span> Matrix Layout</a></li>
			</ul>
			<div class="addspace">
				<p class="text-info"><mark>Support</mark> indicates prevelance of product(s)</p>
				<p class="text-info"><mark>Confidence</mark> indicates predictability of one product given the other product</p>	
				<p class="text-info"><mark>Lift</mark> indicates likelihood of two products going together</p>		
			</div>
</div>
<div class="col-md-10" id="runaffinity">
	<div class="col-md-12">
	<h3>View Matrix Layout</h3>
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
			    				});
			            	  }); 
			              
			              $('#cat_div').on('click','a',function(){

			            	  $('#show').empty();
			            	  cat_name = $('#cat').val($(this).text()).val();
			            	  
			            	  $(this).parents('.btn-group').find('.dropdown-toggle').html(cat_name+' <span class="caret"></span>');
			            	  
			              });
			              
			              $('#affinitytype li').on('click', function(){
			      		    affinitytype =  $('#dropdownMenu4').val($(this).text()).val();
			      		    
			      		    console.log(affinitytype);
			      		});
					  }
				});
			});
            //ajaxindicatorstop();
						 
	</script>
	<div class="col-md-12">
		  <h5>Select Across</h5>
			<form role="form" id="SA">
				<div class="col-md-2">
					<div class="btn-group" id="dep_div">
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
						  <li><a href="#">Support</a></li>
						  <li><a href="#">Confidence</a></li>
						  <li><a href="#">Lift</a></li>
						</ul>
					</div>
				<div class="col-md-3">	
						<input type="text" class="form-control" id="affinityval">
					</div>
				<div class="col-md-3">	
				<button type="button" class="btn btn-primary" id="sin">Show Graph</button>
				<script>
				
			$('#sin').click(function(){
				
				//$("#anu").empty();
				
				d3.select("#matrixplot").remove();
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
		           	url:  "MatrixPlotController",
		            	contentType: "application/json; charset=utf-8",
		            	success: function(responseJson) {
		           
		            		ajaxindicatorstop();
						    var key = "map";
						    var op1 = responseJson[key];
						   
						    console.log(op1);
		            		showMatrixPlot(op1);
		    				$("#anu").show();
							
		            	}
				});
			});
			</script>
			
			
				</div>
				
			</form>
	</div>
<div class="col-md-12" id="anu">
	<!-- <h1>Affinity Association Matrix</h1> -->


	<aside style="margin-top:40px;">
	<p>Order: <select id="order">
	  <option value="name">by Name</option>
	  <option value="count">by Frequency</option>
	  <option value="group">by Cluster</option>
	</select>
	</aside>
<!-- 	<div class="col-md-8" >
		<div id="matrixplot" style="margin-top:100px;">		</div> -->
<!-- 	//</div>
<!--  	 <div class="col-md-4">
 		<div id="matrixlegend" style="margin-left:700px;margin-top:4px;right:0"></div>-->
<!-- 	</div>
 -->	<script type="text/javascript">
	function showMatrixPlot(data) {

		var margin = {top: 200, right: 0, bottom: 100, left: 200},
	    width = 420,
	    height = 420;
	
		var x = d3.scale.ordinal().rangeBands([0, width]),
	    z = d3.scale.linear().domain([0,1500]).clamp(true),
	   <!--  c = d3.scale.threshold().domain([0,1,2]).range(["red", "yellow", "green"]);  -->
		c = d3.scale.category10().domain(d3.range(10));
		 
	var svg = d3.select("#anu").append("svg")
		  	  .attr("id","matrixplot")
	    .attr("width", width + margin.left + margin.right)
	    .attr("height", height + margin.top + margin.bottom)
	    <!-- .style("margin-left", -margin.left + "px") -->
	  .append("g")
	    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
	
	//d3.json(responseJson, function(data) {
	
		console.log("data = "+data);
	  var matrix = [],
	      nodes = data.nodes.myArrayList,
	      n = nodes.length;
		console.log(nodes);
		links = data.links.myArrayList;
		console.log(links);
	  // Compute index per node.
	  nodes.forEach(function(node, i) {
	    node.index = i;
	    node.count = 0;
	    matrix[i] = d3.range(n).map(function(j) { return {x: j, y: i, z: 0}; });
	  });
	<!-- console.log(matrix[0]); -->
	  // Convert links to matrix; count character occurrences.
	  links.forEach(function(link1) {
		  
		link=link1.map;
	    matrix[link.source][link.target].z += link.value;
	    matrix[link.target][link.source].z += link.value;
	    matrix[link.target][link.target].z += link.value;
	    matrix[link.source][link.source].z += link.value;
	    nodes[link.source].count += link.value;
	    nodes[link.target].count += link.value;
		matrix[link.source][link.target].weight = link.value;
		
	  });
	
	  // Precompute the orders.
	  var orders = {
	    name: d3.range(n).sort(function(a, b) { return d3.ascending(nodes[a].map.name, nodes[b].map.name); }),
	    count: d3.range(n).sort(function(a, b) { return nodes[b].map.count - nodes[a].map.count; }),
	    group: d3.range(n).sort(function(a, b) { return nodes[b].map.group - nodes[a].map.group; })
	  };
	
	  // The default sort order.
	  x.domain(orders.name);
	
	  svg.append("rect")
	      .attr("class", "background")
	      .attr("width", width)
	      .attr("height", height)
	  
	  var row = svg.selectAll(".row")
	      .data(matrix)
	    .enter().append("g")
	      .attr("class", "row")
	      .attr("transform", function(d, i) { return "translate(0," + x(i) + ")"; })
	      .each(row);
		  <!-- console.log(row); -->
	
	  row.append("line")
	      .attr("x2", width);
	
	  row.append("text")
	      .attr("x", -6)
	      .attr("y", x.rangeBand() / 2)
	      .attr("dy", ".32em")
	      .attr("text-anchor", "end")
	      .text(function(d, i) { return nodes[i].map.name; });
	
	  var column = svg.selectAll(".column")
	      .data(matrix)
	    .enter().append("g")
	      .attr("class", "column")
	      .attr("transform", function(d, i) { return "translate(" + x(i) + ")rotate(-90)"; });
	
	  column.append("line")
	      .attr("x1", -width);
	
	  column.append("text")
	      .attr("x", 6)
	      .attr("y", x.rangeBand() / 2)
	      .attr("dy", ".32em")
	      .attr("text-anchor", "start")
	      .text(function(d, i) { return nodes[i].map.name; });
	
	  function row(row) {
	    var cell = d3.select(this).selectAll(".cell")
	        .data(row.filter(function(d) { return d.z; }))
			.enter().append("rect")
	        .attr("class", "cell")
	        .attr("x", function(d) { return x(d.x); })
	        .attr("width", x.rangeBand())
	        .attr("height", x.rangeBand())
	        .style("fill-opacity", function(d) { return z(d.z); })
	        <!-- .style("fill", function(d) { return nodes[d.x].group == nodes[d.y].group ? c(nodes[d.x].group) : null; }) -->
			.style("fill", function(d) {            // <== Add these
	            if (d.weight <= 20) {return "blue"}
				if (d.weight > 50) {return "green"}									// <== Add these
	            else    { return "yellow" };})
	        .on("mouseover", mouseover)
	        .on("mouseout", mouseout)
			.append("svg:title").text(function(d) { return d.weight; });
			<!-- console.log(matrix); -->
			  <!-- console.log(cell);  -->
			 <!-- console.log(nodes);  -->
	  }
		
	  function mouseover(p) {
	    d3.selectAll(".row text").classed("active", function(d, i) { return i == p.y; });
	    d3.selectAll(".column text").classed("active", function(d, i) { return i == p.x; });
		
	    window.status="(" + p.x + "/" + p.y + ")";
	  }
	
	  function mouseout() {
	    d3.selectAll("text").classed("active", false);
	  }
	
	  d3.select("#order").on("change", function() {
	    clearTimeout(timeout);
	    order(this.value);
	  });
	
	  function order(value) {
	    x.domain(orders[value]);
	
	    var t = svg.transition().duration(2500);
	
	    t.selectAll(".row")
	        .delay(function(d, i) { return x(i) * 4; })
	        .attr("transform", function(d, i) { return "translate(0," + x(i) + ")"; })
	      .selectAll(".cell")
	        .delay(function(d) { return x(d.x) * 4; })
	        .attr("x", function(d) { return x(d.x); });
	
	    t.selectAll(".column")
	        .delay(function(d, i) { return x(i) * 4; })
	        .attr("transform", function(d, i) { return "translate(" + x(i) + ")rotate(-90)"; });
	  }
	
	  var timeout = setTimeout(function() {
	    //order("group");
	    d3.select("#order").property("selectedIndex", 2).node().focus();
	  }, 5000);
	//});
}
</script>
	<!-- <p id="lifttext">Lift</p> -->
		<script>
		var w = 200,
    h = 200,
    r = 150,
    inner = 70,
    color = d3.scale.ordinal()
       <!-- .range(["#5553a2","#3287bd","#65c2a5","#aedca4","#fdae64","#f36e43","#a00042"]); -->
	   .range(["#008000","#FFFF00","#B6B6F1"]);

data = [{"label":"High Prevalence of buying together", "value":793},
        {"label":"Moderate Prevalence of buying together", "value":1929},
        {"label":"Low Prevalence of buying together", "value":1383}];
		
		var legend = d3.select("#anu").append("svg")
		.attr("id","matrixlegend")
		.attr("class", "legend")
		.attr("width", r* 2)
		.attr("height", r )
		.selectAll("g")
		.data(data)
		.enter().append("g")
		.attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

	legend.append("rect")
		.attr("width", 18)
		.attr("height", 18)
		.style("fill", function(d, i) { return color(i); });

	legend.append("text")
		.attr("x", 24)
		.attr("y", 9)
		.attr("dy", ".35em")
		.text(function(d) { return d.label; });			
</script>	
	</div>
</div>
<div id="footer">Copyright&nbsp;<span class="glyphicon glyphicon-copyright-mark"></span> 2015 by Affine Analytics</div>	
<div class="clearfix visible-lg"></div> 
</body>
</html>

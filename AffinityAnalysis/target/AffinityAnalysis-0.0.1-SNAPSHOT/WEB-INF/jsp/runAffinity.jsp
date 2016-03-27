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
<script src="resourcefiles/js/myscript.js"></script>

</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
		<a href="#" class="pull-left"><img src="resourcefiles/css/images/affine.png" width="100" height="50" style="margin-right:20px;"></a>

      <!--<a class="navbar-brand" href="#">AFFINE ANALYTICS</a>-->
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li><a href="home">Home</a></li>
        <li><a href="viewstrategies">Rules</a></li>
        <li><a href="scatteraffinity">Dashboard</a></li>
        <li><a href="#">Reports</a></li>
		<li class="active"><a href="runAffinity">Admin</a></li>
      </ul>
	  <ul class="nav navbar-nav navbar-right">
        <!--<li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>-->
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
				<li class="active" id="one"><a href="#"><span class="glyphicon glyphicon-play"></span> Run Affinity</a></li>
				<li><a href="viewAffinity"><span class="glyphicon glyphicon-camera"></span> View Affinity</a></li>
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


	<h3>Run Affinity Analysis</h3>		
		
		<div class="form-group">
			<p>Select transactions start date:</p>
            <div class='input-group date' id='datetimepicker6'>
                <input type='text' class="form-control" id='fromdate'/>
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        </div>
		<div class="form-group">
			<p>Select transactions end date:</p>
            <div class='input-group date' id='datetimepicker7'>
                <input type='text' class="form-control" id='todate' />
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        </div>
		<!--  <h3>Configure Support,Confidence and Lift</h3>
		<form class="form-horizontal" role="form">
			<div class="form-group">
				<label class="col-sm-4 control-label">Enter threshold for Support</label>
				<div class="col-sm-8">
				<input class="form-control" id="focusedInputS" type="text" value="0">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">Enter threshold for Confidence</label>
				<div class="col-sm-8">
				<input class="form-control" id="focusedInputC" type="text" value="0">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">Enter threshold for Lift</label>
				<div class="col-sm-8">
				<input class="form-control" id="focusedInputL" type="text" value="0">
				</div>
			</div>
		 </form>-->
			<button type="button" class="btn btn-primary" id="viewaffinitysubmit">Calculate Affinity</button>
			
			
	<script>
	
	
	$('#viewaffinitysubmit').click(function(){
		
		var fromdate = $('#fromdate').val();
		var todate = $('#todate').val();
		
		
		/*var mins = $('#focusedInputS').val();
		var minc = $('#focusedInputC').val();
		
		var minl = $('#focusedInputL').val();
		*/
		
		
		console.log(" from "+fromdate);
		console.log("to "+todate);

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

		console.log(datestring);
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
				  url: 'calculateAffinity',
				  type: "GET",
				  dataType: "text",
				  data: { from : fromdate,
	                    to:todate
	                    },
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
						 
			             /* $.get('UpdateRundate', function(responseJson) {
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
				            });*/
				   	  }
				  },
				}); 
			}
		});
	</script>
	
<script type="text/javascript">
    $(function () {
        $('#datetimepicker6').datepicker();
        $('#datetimepicker7').datepicker();
        $("#datetimepicker6").on("dp.change", function (e) {
            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker7").on("dp.change", function (e) {
            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
        });
    });
</script>	
</div>	
<div id="footer">Copyright&nbsp;<span class="glyphicon glyphicon-copyright-mark"></span> 2015 by Affine Analytics</div>	
<div class="clearfix visible-lg"></div> 
</body>
</html>

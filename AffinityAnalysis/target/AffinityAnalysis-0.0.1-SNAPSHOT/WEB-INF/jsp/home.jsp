<!DOCTYPE html>
<html lang="en">
<head>
  <title>Affine Affinity Tool</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="resourcefiles/css/mystyle.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="resourcefiles/js/d3.v3.js"></script>
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

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
		<a href="#" class="pull-left"><img src="resourcefiles/css/images/affine.png" width="100" height="50" style="margin-right:20px;"></a>
      <!-- <a class="navbar-brand" href="#">AFFINE ANALYTICS</a> -->
    </div>
    <div>
      <ul class="nav navbar-nav ">
        <li class="active"><a href="home">Home</a></li>
        <li><a href="viewstrategies">Rules</a></li>
        <li ><a href="scatteraffinity">Dashboard</a></li>
        <li><a href="#">Reports</a></li>
		<li ><a href="runAffinity">Admin</a></li>
      </ul>
	  <ul class="nav navbar-nav navbar-right">
        <!-- <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li> -->
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

<div class="col-md-12" id="hi">
	<h1 id="mainheading"><span id="market">Market</span><span id="basket"> Basket</span> Analysis for flexible sales</h1>
			<div class="col-md-3" id="pp">
				<img src="resourcefiles/css/images/pp.JPG" class="img-thumbnail" alt="Product Promotion">
				<p id="ppt">Considering insights on products bought together, the store managers could decide on the location of the items bought in a basket.</p>
			</div>
			<div class="col-md-3" id="ap">
				<img src="resourcefiles/css/images/ap.JPG" class="img-thumbnail" alt="Assortment Planning">
				<p id="apt">Considering insights on products bought together, the store managers could decide on the location of the items bought in a basket.</p>
			</div>
			<div class="col-md-3" id="rp">
				<img src="resourcefiles/css/images/rp.JPG" class="img-thumbnail" alt="Right Product Bundling">
				<p id="rpt">Considering insights on products bought together, the store managers could decide on the location of the items bought in a basket.</p>
			</div>
			<div class="col-md-3" id="sa">
				<img src="resourcefiles/css/images/sa.JPG" class="img-thumbnail" alt="Smart Assortment Planning">
				<p id="sat">Considering insights on products bought together, the store managers could decide on the location of the items bought in a basket.</p>
			</div>
	<div class="col-md-12">
		<div class="col-md-3" id="b1">
			<button type="button" class="btn btn-info" id="bu1">DOWNLOAD MANUAL</button>
		</div>
		<div class="col-md-3" id="b2">
			<button type="button" class="btn btn-info" id="bu2">INSTALLATION GUIDE</button>
		</div>
		<div class="col-md-3" id="b3">
			<button type="button" class="btn btn-info" id="bu3">VIEW DEMO</button>
		</div>
		<div class="col-md-3" id="b4">
			<button type="button" class="btn btn-info" id="bu4">LEARN MORE</button>
		</div>
	</div>		
</div>
<div id="footer">Copyright&nbsp;<span class="glyphicon glyphicon-copyright-mark"></span> 2015 by Affine Analytics</div>	
<div class="clearfix visible-lg"></div> 
</body>
</html>

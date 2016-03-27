<!DOCTYPE html>
<html lang="en">
<head>
  <title>Affinity Tool Login</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <link rel="stylesheet" href="resourcefiles/css/mystyle.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">            
  <!-- <img src="1.jpg" class="img-thumbnail" alt="Cinque Terre" width="1240" height="236">  -->

	<div class="header-shadow">
	<form action="login" method="POST">
	
		<!-- <h1 id="ht">AFFINE AFFINITY TOOL</h1> -->
		<div class="col-md-4" id="three">
			<div class="col-md-4" id="four">
					<img src="resourcefiles/css/images/avatar.jpg" class="img-thumbnail" alt="Avatar" id="avatar" width="1240" height="236">
			</div>
			<input type="text" class="form-control" id="usr" value=""  name="user">
			<input type="password" class="form-control" id="pwd" value=""  name="pass">
			<div class="col-md-12" id="fl">
				<div class="col-md-6">
				<span id="fp"><u>Forgot Password</u>?</span>
				</div>
				<div class="col-md-6">
				<button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
				</div>	
			</div>
		</div>
	</form>
	
	<%
  String message = "";
  try{
	  message = (String) request.getAttribute("message");
	  if(!message.isEmpty())
		  %>
		  <script>
	  	alert("Username or Password are invalid.Please try again !!");
	  	</script>
	  	<%
  }
  catch(Exception e){
	  if(message!=null)
	  	out.println(message);
  }
%>
</div>

<div id="footer">Copyright&nbsp;<span class="glyphicon glyphicon-copyright-mark"></span> 2015 by Affine Analytics</div>	
</div>
</body>
</html>

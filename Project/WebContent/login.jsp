<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Centennial College | Food</title>
</head>
<body style="">
	<div class="hdr-outer">
		<div class="hdr-inner">
			<img src="logo.svg" height="60" style="background-color: #303030; margin-top: 15px; ">
			<img src="fiftieth-anniversary.png" height="54" style="margin-top: 17px; ">
			<img src="mainlogo.png" height="50" style="margin-left: 20px; margin-bottom:4px;">
			<div style="width: 300px; height: 40px; margin-top: 25px; background-color: #9ba50e; float:right;">
				<input type="text" style="height: 38px; width:245px; background-color: #9ba50e; border: none; outline: none; color:white; font-family: sans-serif; margin-left: 10px; font-size: 20px; float:left;">
				<div style="background-color: red; width: 40px; height: 40px; float:left;">
					<button style="width:40px; height:40px; border:none; outline:none; background-color: #9ba50e;">
					<img src="search.png" height="30" width="30" style="margin-top:5px">
					</button>
				</div>
			</div>
			
		</div>
	</div>
	<div class="menu-outer">
		<div class="menu-inner">
			<a href="index_home.jsp">
				<div class="menu-button" style="width: 210px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Home</v>
				</div>
			</a>
			
			<a href="#">
				<div class="menu-button" style="width: 210px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Food</v>
				</div>
			</a>
			
			<a href="login.jsp">
				<div class="menu-button" style="width: 210px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Login</v>
				</div>
			</a>
			
			<a href="#">
				<div class="menu-button" style="width: 210px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">About</v>
				</div>
			</a>
			<a href="cart.jsp">
				<div class="menu-button" style="width: 154px;">
					<v class="menu-title" style="width: 100px; height: 50px; float:left;">Cart</v>
					<div class="cart-number">12</div>
				</div>
			</a>
		</div>
	</div>
<div class="content">
	<div style="width:100px; height:50px; float:left;">
	</div>
	<div style="width: 1000px; height: 50px;">
	<div style="width:330px; height:50px; float:left;">
		<input type="text" placeholder="User ID" style="height: 30px; width: 300px; margin-top: 7px; font-size: 18px;">
	</div>
	<div style="width:330px; height:50px; float:left;">
		<input type="password" placeholder="Password" style="height: 30px; width: 300px; margin-top: 7px; font-size: 18px;">
	</div>
	<div style="width:140px; height:50px; float:left;">
		<input class="ui-button" style="width:140px; height:40px; margin-top:5px; background-color:black; color:white; font-size:18px; border:none;" type="button" value="Log In">
	</div>
	<div style="width:100px; height:50px; float:left;">
	</div>
	</div>
</div>
</body>
</html>
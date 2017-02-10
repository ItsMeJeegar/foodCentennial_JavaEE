<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div style="width: 100%; height: 100px; float: left; background-color: #222222; border-bottom: 2px solid #d4df38;">
<div class="hdr-inner">
			<img src="logo.svg" height="60" style="background-color: #505050; margin-top: 15px; float: left; ">
			
			<% 
			if(session.getAttribute("empres")==null)
			{
				session.setAttribute("empres", "Tim Hortons");
			}
			
			if(session.getAttribute("empid")==null) {
				response.sendRedirect("employee_login.jsp");
			}
			%>
			<br>
			<h2 style="color: white; float: left; margin-left: 250px;"><%=session.getAttribute("empres").toString()%></h2>
			</div>
</div>
<div class="menu-outer" style="border-bottom: 2px solid #d4df38;">
		<div class="menu-inner">
			<a href="employee_orders.jsp">
				<div class="menu-button" style="width: 168px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Orders</v>
				</div>
			</a>
			
			<a href="order_pickup.jsp">
				<div class="menu-button" style="width: 168px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Pickup List</v>
				</div>
			</a>
			
			<a href="employee_manage_items.jsp">
				<div class="menu-button" style="width: 168px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Manage Items</v>
				</div>
			</a>
			

				<div class="menu-button" style="width: 320px;">
					<v class="menu-title">
					<%
					if(session.getAttribute("empid")==null)
					{
						out.print("No Log In");
					}
					else {
						out.print(session.getAttribute("empid").toString());
					}
					
					%>
					</v>
				</div>
			
			<a href="#">
				<div class="menu-button" style="width: 168px; ">
					<v class="menu-title">
					<form action="EmployeeServlet" method="post">
					<input type="submit" class="ui-button" style="width:140px; height:36px; margin-top:7px; background-color:#d4df38; color:#222222; font-size:18px; border:none;" name="employeeAction"  value="Logout">
					</form>
					</v>
				</div>
			</a>
			
		</div>
		
	</div>
	
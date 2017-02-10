<%@ page language="java" contentType="text/html; charset=US-ASCII"
	import="java.sql.*" pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<META HTTP-EQUIV="refresh" CONTENT="10">
<title>Centennial College | Food</title>
</head>
<body style="font-family: sans-serif;">
	<%@include file="header.jsp"%>
	<%
		if (session.getAttribute("userid") == null) {
	%>
	<%@include file="order_track.jsp"%>
	<%
		}

		else {
	%>
	<div style="margin:auto; width: 1000px; height:1000px; overflow:auto; background-color: #eeeeee;">
		
		<div style="width: 1000px; height: 50px; float: left;"></div>
		<div
			style="width: 1000px; height: auto; min-height: 500px; float: left;">



			<%
				Connection conn = null;
					Statement stmt = null;
					ResultSet rs = null;
					float subTotal = 0;
					String userId = "";
					String userType = "";

					if (session.getAttribute("userid") == null) {
						userType = "guest";
						userId = session.getAttribute("guestid").toString();
					} else {
						userType = "member";
						userId = session.getAttribute("userid").toString();
					}

					try {
						String sql = "select * from OrderMain where userId='" + userId + "' and userType = '" + userType
								+ "' order by orderNumber desc";
						Class.forName("com.mysql.jdbc.Driver");

						conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231", "root", "coinage");
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql);

						while (rs.next()) {
			%>
			
			
			<div style="margin-left: 50px; margin-top: 20px;">
			<b>ORDER NUMBER: <%=rs.getString("orderNumber")%></b>
			</div> 
			<table
				style="border: 1px solid #bbbbbb; color: #333333; text-align: center; background-color: #e0e0e0; width: 900px; margin-left: 50px; margin-top: 20px; border-collapse: collapse;">
				<tr>
					<td
						style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 10px;"><b>ITEM</b></td>
					<td style="border: 1px solid #bbbbbb; width: 200px; padding: 5px;"><b>RESTAURANT</b></td>
					<td style="border: 1px solid #bbbbbb; width: 100px; padding: 5px;"><b>PRICE</b></td>
					<td style="border: 1px solid #bbbbbb; width: 100px; padding: 5px;"><b>QUANTITY</b></td>
					<td style="border: 1px solid #bbbbbb; width: 100px; padding: 5px;"><b>SUBTOTAL</b></td>

					<td style="border: 1px solid #bbbbbb; width: 150px; padding: 5px;"><b>STATUS</b></td>
				</tr>

				<%
					stmt = conn.createStatement();
								String odsql = "select * from OrderDetail where userId='" + userId + "' and userType = '"
										+ userType + "' and orderNumber = " + rs.getString("orderNumber")
										+ " order by restaurant";
								ResultSet od = stmt.executeQuery(odsql);

								while (od.next()) {
				%>

				<tr>

					<td
						style="border-bottom: 1px solid #bbbbbb; width: 300px; padding: 10px;"><%=od.getString("itemName")%></td>
					<td style="border: 1px solid #bbbbbb; width: 90px; padding: 10px;">
						<%=od.getString("restaurant")%>
					</td>
					<td style="border: 1px solid #bbbbbb; width: 80px; padding: 10px;">
						$ <%=od.getString("cost")%>
					</td>

					<td style="border: 1px solid #bbbbbb; width: 100px; padding: 10px;">
						<%=od.getString("quantity")%>
					</td>
					<td style="border: 1px solid #bbbbbb; width: 90px; padding: 10px;">
						<%
							Float t = Float.parseFloat(od.getString("totalCost"));
											t = (float) Math.round(t * 100.0) / (float) 100.0;
						%> $ <%=t%>
					</td>




					<%
						if (od.getString("orderStatus").equals("Placed")) {
					%>
					<td
						style="border: 1px solid #bbbbbb; width: 250px; padding: 5px; color: black;">
						Placed</td>
					<%
						}

										else if (od.getString("orderStatus").equals("Preparing")) {
					%>
					<td
						style="border: 1px solid #bbbbbb; width: 250px; padding: 5px; color: #aa00aa;">
						Preparing</td>
					<%
						}

										else if (od.getString("orderStatus").equals("Cancelled")) {
											%>
											<td
												style="border: 1px solid #bbbbbb; width: 250px; padding: 5px; color: red;">
												Cancelled</td>
											<%
												}

										else if (od.getString("orderStatus").equals("Ready!")) {
					%>
					<td
						style="border: 1px solid #bbbbbb; width: 250px; padding: 5px; color: green;">
						Ready!</td>
					<%
						}
										else if (od.getString("orderStatus").equals("Picked Up")) {
											%>
											<td
												style="border: 1px solid #bbbbbb; width: 250px; padding: 5px; color: blue;">
												Ready!</td>
											<%
						}
										else {
											%>
											<td
												style="border: 1px solid #bbbbbb; width: 250px; padding: 5px; color: black;">
												<%=od.getString("orderStatus")%></td>
											<%
						}
					%>

				</tr>
				<%
					}
					od.close();
				%>

				<tr>
					<td colspan="4"
						style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 10px; text-align: right;">
						<b>TOTAL</b>
					</td>
					<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;">
						<b>$ <%=rs.getString("total")%></b>
					</td>
					<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;"></td>
				</tr>
				<tr>
					<td colspan="4"
						style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 10px; text-align: right;">
						<b>TAX</b>
					</td>
					<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;">
						<b>$ <%=rs.getString("tax")%></b>
					</td>
					<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;"></td>
				</tr>
				<tr>
					<td colspan="4"
						style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 10px; text-align: right;">
						<b>GRAND TOTAL</b>
					</td>
					<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;">
						<b>$ <%=rs.getString("totalWithTax")%></b>
					</td>
					<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;"></td>
				</tr>
			</table>
			<br>
			<%
				subTotal = subTotal
									+ ((float) Math.round(Float.parseFloat(rs.getString("total")) * 100.0) / (float) 100.0);
							subTotal = (float) Math.round(subTotal * 100.0) / (float) 100.0;
						}
						rs.close();
						stmt.close();
						conn.close();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			%>



		</div>
	</div>
	<%} %>
	<%@include file="footer.jsp"%>
</body>
</html>
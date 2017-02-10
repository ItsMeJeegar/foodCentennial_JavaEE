package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Order;
import models.OrderDetail;

import java.sql.*;


/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String orderAction = request.getParameter("orderAction");
		HttpSession session = request.getSession();
		if(orderAction.equals("place") && orderAction!=null) {
			
			placeOrder(request, response);
			response.sendRedirect("order_success.jsp");
		}
		
		else if(orderAction.equals("updateStatus")) {
			
			OrderDetail order = new OrderDetail();
			order.setOrderNumber(Integer.parseInt(request.getParameter("ordernumber").toString()));
			order.setRestaurant(request.getParameter("restaurant"));
			updateOrderStatus(request, response, order);
			response.sendRedirect("employee_orders.jsp");
		}
		else if(orderAction.equals("cancelStatus")) {
			
			OrderDetail order = new OrderDetail();
			order.setOrderNumber(Integer.parseInt(request.getParameter("ordernumber").toString()));
			order.setRestaurant(request.getParameter("restaurant"));
			cancelOrderStatus(request, response, order);
			response.sendRedirect("employee_orders.jsp");
		}
		else if(orderAction.equals("pickupStatus")) {
			
			OrderDetail order = new OrderDetail();
			order.setOrderNumber(Integer.parseInt(request.getParameter("ordernumber").toString()));
			order.setRestaurant(request.getParameter("restaurant"));
			pickupOrderStatus(request, response, order);
			response.sendRedirect("order_pickup.jsp");
		}
		
		else if(orderAction.equals("guestTrack")) {
			session.setAttribute("ordernumber", request.getParameter("trackordernumber"));
			response.sendRedirect("order_guest.jsp");
		}
		
		
	}
	
	private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response, OrderDetail orderDetail) {
		// TODO Auto-generated method stub
		
		Connection conn = null;
		Statement stmt = null;
		
		try {
			String sql = "update OrderDetail set orderStatus = 'Ready!' where orderNumber='"+orderDetail.getOrderNumber()+"' and restaurant='"+orderDetail.getRestaurant()+"'";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);			
			
			stmt.close();
			conn.close();
		}
		catch(Exception sqle) {
			sqle.printStackTrace();
			
		}
	}
	
	private void cancelOrderStatus(HttpServletRequest request, HttpServletResponse response, OrderDetail orderDetail) {
		// TODO Auto-generated method stub
		
		Connection conn = null;
		Statement stmt = null;
		
		try {
			String sql = "update OrderDetail set orderStatus = 'Cancelled' where orderNumber='"+orderDetail.getOrderNumber()+"' and restaurant='"+orderDetail.getRestaurant()+"'";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);			
			
			stmt.close();
			conn.close();
		}
		catch(Exception sqle) {
			sqle.printStackTrace();
			
		}
	}
	
	private void pickupOrderStatus(HttpServletRequest request, HttpServletResponse response, OrderDetail orderDetail) {
		// TODO Auto-generated method stub
		
		Connection conn = null;
		Statement stmt = null;
		
		try {
			String sql = "update OrderDetail set orderStatus = 'Picked Up' where orderNumber='"+orderDetail.getOrderNumber()+"' and restaurant='"+orderDetail.getRestaurant()+"'";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);			
			
			stmt.close();
			conn.close();
		}
		catch(Exception sqle) {
			sqle.printStackTrace();
			
		}
	}

	public void placeOrder(HttpServletRequest request, HttpServletResponse response) {

		
		String totalStr = request.getParameter("total");
		String taxStr = request.getParameter("tax");
		float total = Float.parseFloat(totalStr);
		float tax = Float.parseFloat(taxStr);
		total = (float)Math.round(total * 100.0) / (float)100.0;
		tax = (float)Math.round(tax * 100.0) / (float)100.0;
		float totalWithTax = total + tax;
		totalWithTax = (float)Math.round(totalWithTax * 100.0) / (float)100.0;
		
		String userId = "";
		String userType = "";
		HttpSession session = request.getSession(); 
		if(session.getAttribute("userid")==null) 
		{
			userType="guest";
			userId=session.getAttribute("guestid").toString();
		}
		else {
			userType = "member";
			userId=session.getAttribute("userid").toString();
		}
		System.out.println("Usertype: "+userType+" UserID: "+userId);
		Connection conn = null;
		Statement stmt = null, instmt = null;
		ResultSet rs = null, od = null;
		int orderNumber = 0;
		try {
			String ordersql = "select value from Imp where id = 'order'";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			instmt = conn.createStatement();
			od = stmt.executeQuery(ordersql);
			
			while(od.next()) {
				System.out.println("Inside IMP LOOP");
				String orderStr = od.getString("value");
				orderNumber = Integer.parseInt(orderStr);
			}
			
			session.setAttribute("placedorder", orderNumber);
			System.out.println("Found order number: "+orderNumber);
			int newOrder = orderNumber + 1;
			stmt.executeUpdate("update Imp set value = "+newOrder+" where id = 'order'");
			
			
			
			String place = "insert into OrderMain(orderNumber,userId,userType,total,tax,totalWithTax) values ("+orderNumber+","+userId+",'"+userType+"','"+total+"','"+tax+"','"+totalWithTax+"')";
			System.out.println(place);
			stmt = conn.createStatement();
			stmt.executeUpdate(place);
			
			String sql = "select * from cart where userId='"+userId+"' and userType = '"+userType+"'";
			rs = stmt.executeQuery(sql);
			String insert = "";
			while(rs.next()) {
				
				insert = "insert into OrderDetail(orderNumber,userId,userType,itemId, itemName, restaurant, quantity, cost, totalCost, orderStatus) "
						+ "values("+orderNumber+","+userId+",'"+userType+"','"+rs.getString("itemId")+"','"+rs.getString("itemName")+"','"+rs.getString("restaurant")+"',"+rs.getString("quantity")+",'"+rs.getString("cost")+"','"+rs.getString("total")+"','Placed')";
				
				instmt.executeUpdate(insert);
			}
			
			stmt.executeUpdate("delete from Cart where userId='"+userId+"' and userType = '"+userType+"'");
			
			rs.close();
			stmt.close();
			conn.close();
		}
		catch(Exception sqle) {
			sqle.printStackTrace();
			
		}
	}

}

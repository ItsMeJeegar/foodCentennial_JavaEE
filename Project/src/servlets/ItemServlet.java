package servlets;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import models.Item;

/**
 * Servlet implementation class ItemServlet
 */
@WebServlet("/ItemServlet")
public class ItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if(request.getParameter("itemAction")!=null && request.getParameter("itemAction").equals("Add"))
		{
			System.out.println("LOL");
			String itemPicture = "images/items/no.png";
			Item item = new Item();
			
			String itemName = request.getParameter("itemName");
			String category = request.getParameter("category");
			String description = request.getParameter("description");
			String restaurant = session.getAttribute("empres").toString();
			String cost = request.getParameter("cost");
			String availability = request.getParameter("availability");
			if(availability==null) {
				item.setAvailability("Not Available");
			}
			System.out.println(availability);
			item.setRestId(3);
			item.setItemName(itemName);	
			item.setRestaurant(restaurant);
			item.setItemPicture(itemPicture);
			item.setDescription(description);
			if(availability==null) {
				item.setAvailability("Not Available");
			}
			else {
				item.setAvailability("Available");
				
			}
			item.setCategory(category);
			item.setCost(Float.parseFloat(cost));
			System.out.println(item.getRestaurant());
			System.out.println("Inserted item with path:"+itemPicture);
			String itemId = insert(item);
			session.setAttribute("pictureItemId", itemId);
			response.sendRedirect("employee_add_picture.jsp?itemId="+itemId+"&itemName="+itemName);
		}
		
		if(request.getParameter("itemAction")!=null && request.getParameter("itemAction").equals("Update"))
		{
			Item item = new Item();
			int itemId = Integer.parseInt(request.getParameter("itemId"));
			String itemName = request.getParameter("itemName");
			String category = request.getParameter("category");
			String description = request.getParameter("description");
			String restaurant = session.getAttribute("empres").toString();
			String cost = request.getParameter("cost");
			String availability = request.getParameter("availability");
			if(availability==null) {
				item.setAvailability("Not Available");
			}
			System.out.println(availability);
			item.setItemId(itemId);
			item.setItemName(itemName);	
			item.setDescription(description);
			if(availability==null) {
				item.setAvailability("Not Available");
			}
			else {
				item.setAvailability("Available");
				
			}
			System.out.println(item.getRestaurant());
			item.setCategory(category);
			item.setCost(Float.parseFloat(cost));
			update(item);
			response.sendRedirect("employee_manage_items.jsp");
			
		}
		else if(request.getParameter("itemAction")!=null && request.getParameter("itemAction").equals("Change"))
		{
			Item item = new Item();
			item.setItemId(Integer.parseInt(request.getParameter("itemId")));
			item.setAvailability(request.getParameter("availability"));
			changeAvailability(item);
			response.sendRedirect("employee_manage_items.jsp");
		}
		
		else if(request.getParameter("itemAction")!=null && request.getParameter("itemAction").equals("Remove"))
		{
			Item item = new Item();
			item.setItemId(Integer.parseInt(request.getParameter("itemId")));
			remove(item);
			response.sendRedirect("employee_manage_items.jsp");
		}
	}
	
	private void changeAvailability(Item item) {
		// TODO Auto-generated method stub
		Connection conn = null;
		Statement stmt = null;
		
		
		try {
			String sql = "update Item set availability='"+item.getAvailability()+"' where itemId="+item.getItemId()+"";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);

			stmt.close();
			conn.close();
		} 
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String insert(Item item) {
		Connection conn = null, idconn = null;
		Statement stmt = null, idstmt = null;
		String itemId = "1";
		ResultSet rs = null;
		System.out.println("Inside Insert");
		
		try {
			String sql = "insert into Item(restId,itemName,restaurant,itemPicture,description,availability,category,cost)"
					+ " values('"+item.getRestId()+"','"+item.getItemName()+"','"+item.getRestaurant()+"','"+item.getItemPicture()+"','"+item.getDescription()+"','"+item.getAvailability()+"','"+item.getCategory()+"','"+item.getCost()+"');";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			stmt.close();
			conn.close();

			idconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			idstmt = idconn.createStatement();
			rs = idstmt.executeQuery("select * from Item where itemName='"+item.getItemName()+"' order by itemId desc limit 1");
			while(rs.next()) {
				System.out.println("lol");
				itemId = rs.getString("itemId");
			}
			rs.close();
			idstmt.close();
			idconn.close();
		} 
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(itemId);
		return itemId;
	}

	public void update(Item item) {
		Connection conn = null, idconn = null;
		Statement stmt = null, idstmt = null;
		String itemId = "1";
		ResultSet rs = null;
		System.out.println("Inside Update");
		
		try {
			String sql = "update Item set itemName='"+item.getItemName()+"',description='"+item.getDescription()+"',availability='"+item.getAvailability()+"',"
					+ "category='"+item.getCategory()+"',cost='"+item.getCost()+"' where itemId='"+item.getItemId()+"'";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			stmt.close();
			conn.close();

			idconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			idstmt = idconn.createStatement();
			rs = idstmt.executeQuery("select * from Item where itemName='"+item.getItemName()+"' order by itemId desc limit 1");
			while(rs.next()) {
				System.out.println("lol");
				itemId = rs.getString("itemId");
			}
			rs.close();
			idstmt.close();
			idconn.close();
		} 
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(itemId);
		
	}

	public void manualDelete(Item item) {
		Connection conn = null;
		Statement stmt = null;
		
		
		try {
			String sql = "delete from Item where itemName='Tea' and itemPicture='images/items/coffee.png'";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);

			stmt.close();
			conn.close();
		} 
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void remove(Item item) {
		Connection conn = null;
		Statement stmt = null;
		
		
		try {
			String sql = "delete from Item where itemId="+item.getItemId();
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);

			stmt.close();
			conn.close();
		} 
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void manualQuery(Item item) {
		Connection conn = null;
		Statement stmt = null;
		
		
		try {
			String sql = "ALTER TABLE Item DROP COLUMN restName";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);

			stmt.close();
			conn.close();
		} 
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void displayItems() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from Item";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while(rs.next()) {
				for (int i = 1; i <= 10; i++) {
					System.out.print(rs.getString(i)+"\t");
					
				}	
				System.out.println(" -");
			}
			rs.close();
			stmt.close();
			conn.close();
		} 
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}

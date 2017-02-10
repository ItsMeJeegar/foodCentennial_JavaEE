package servlets;

import java.io.IOException;
import java.sql.Driver;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import models.*;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("doGet Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		String cartAction = "";
		String userType = "";
		int userid = -1;
		if(session.getAttribute("userid")!=null)
		{
			userid = Integer.parseInt(session.getAttribute("userid").toString());
			userType = "member";
		}
		else {
			userid = Integer.parseInt(session.getAttribute("guestid").toString());
			userType = "guest";
		}
		if(request.getParameter("cartAction")!=null)
		{
			cartAction = request.getParameter("cartAction");
		}
		
		if(cartAction.equals("insert"))
		{
			float total = 0;
			int qty = Integer.parseInt(request.getParameter("quantity"));
			Cart cart = new Cart();
			Item item = new Item();
			item = getItem(Integer.parseInt(request.getParameter("itemId")));
			System.out.println(item.getItemId());
			//cart.setItemId(Integer.parseInt(request.getParameter("itemId")));
			cart.setUserId(userid);
			cart.setUserType(userType);
			cart.setItemId(item.getItemId());
			cart.setItemName(item.getItemName());
			cart.setItemPicture(item.getItemPicture());
			cart.setRestaurant(item.getRestaurant());
			cart.setCost(item.getCost());
			total = item.getCost() * qty;
			cart.setTotal(total);
			cart.setQuantity(Integer.parseInt(request.getParameter("quantity")));
			
			int result = insert(cart,session);
			if(result>0)
			{
				int count = Integer.parseInt(session.getAttribute("cartCount").toString());
				if(result==1)
					session.setAttribute("cartCount", count+1);
				request.setAttribute("cartMessage", "Item successfully added to cart!");
			}
			else if(result==-1) {
				request.setAttribute("cartMessage", "Oops! The item could not be added to cart because of a limit of 5 per item!");
			}
			
		}
		else if(cartAction.equals("update"))
		{
			Cart cart = new Cart();
			cart.setCartId(Integer.parseInt(request.getParameter("cartId")));
			cart.setQuantity(Integer.parseInt(request.getParameter("quantity")));
			cart.setCost(Float.parseFloat(request.getParameter("cost")));
			int result = update(cart, session);
			if(result>0)
			{
				request.setAttribute("cartMessage", "Item successfully updated in cart!");
			}
			else if(result==-1) {
				request.setAttribute("cartMessage", "Oops! The item could not be added to cart because of a limit of 5 per item!");
			}
		}
		else if(cartAction.equals("delete"))
		{
			Cart cart = new Cart();
			cart.setCartId(Integer.parseInt(request.getParameter("cartId")));
			delete(cart);
			request.setAttribute("cartMessage", "Item successfully removed from the cart!");
		}
		System.out.println(request.getAttribute("cartMessage"));
		request.getRequestDispatcher("cart.jsp").forward(request, response);
	}
	
	public void select(Cart cart) {
		Cart[] cartItems;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			Statement stmt = conn.createStatement();
			ResultSet rs;
			String sql = "";
			rs = stmt.executeQuery(sql);
			rs.close();
			stmt.close();
		}
		catch(Exception sqle) {
			System.out.println("Error at CartServlet select");
		}
	}
	
	public int insert(Cart cart, HttpSession session) {
		
		String userType = "";
		int userid = -1;
		if(session.getAttribute("userid")!=null)
		{
			userid = Integer.parseInt(session.getAttribute("userid").toString());
			userType = "member";
		}
		else {
			userid = Integer.parseInt(session.getAttribute("guestid").toString());
			userType = "guest";
		}
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			Statement stmt = conn.createStatement();
			int qty = 0;
			System.out.println("searching for item with "+cart.getItemId());
			ResultSet rs = stmt.executeQuery("select * from cart where userId='"+userid+"' and userType='"+userType+"' and itemId='"+cart.getItemId()+"'");
			while(rs.next()) {
				
				qty = qty + Integer.parseInt(rs.getString("quantity"));
				qty = qty + cart.getQuantity();
				Cart newCart = new Cart();
				newCart.setCartId(Integer.parseInt(rs.getString("cartId")));
				newCart.setQuantity(qty);
				newCart.setCost(Float.parseFloat(rs.getString("cost")));
				int rt = update(newCart, session);
				System.out.println("Found item with cart id "+newCart.getCartId());
				return rt;
			}
			
			
			
			
			String sql = "insert into Cart(userId,userType,itemId,itemName,itemPicture,restaurant,quantity,cost,total)"
					+ " values ("+cart.getUserId()+",'"+cart.getUserType()+"','"+cart.getItemId()+"','"+cart.getItemName()+"','"+cart.getItemPicture()+"','"+cart.getRestaurant()+"','"+cart.getQuantity()+"','"+cart.getCost()+"','"+cart.getTotal()+"');";
			int result = stmt.executeUpdate(sql);
			stmt.close();
			conn.close();
			return result;

		}
		catch(Exception sqle) {
			System.out.println("Error at CartServlet insert: "+sqle.getMessage());
		}
		
		return 0;
	}
	
	public int update(Cart cart, HttpSession session) {
		
		
		
		try {
			int qty = 0;
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			Statement stmt = conn.createStatement();
			
			
			qty = qty + cart.getQuantity();
			System.out.println("Inside update quantity is "+qty+"and cart id is "+cart.getCartId());
//			if(qty>5)
//				return -1;
			
			double total = cart.getCost() * cart.getQuantity();
			
			System.out.println("new total is "+total);
			String sql = "update Cart set quantity="+qty+", total='"+total+"' where cartId="+cart.getCartId()+"";
			int result = stmt.executeUpdate(sql);
			stmt.close();
			conn.close();
			return result;

		}
		catch(Exception sqle) {
			System.out.println("Error at CartServlet update");
		}
		
		
		return 0;
	}
	
	public int delete(Cart cart) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			Statement stmt = conn.createStatement();
			String sql = "delete from Cart where cartId='"+cart.getCartId()+"'";
			int result = stmt.executeUpdate(sql);
			stmt.close();
			conn.close();
			return result;

		}
		catch(Exception sqle) {
			System.out.println("Error at CartServlet delete");
		}
		
		return 0;
	}
	
	public Item getItem(int itemId) {
		Item item = new Item();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			Statement stmt = conn.createStatement();
			String sql = "select * from Item where itemId = "+itemId;
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				item.setItemId(itemId);
				item.setItemName(rs.getString("itemName"));
				item.setCost(Float.parseFloat(rs.getString("cost")));
				item.setDescription(rs.getString("description"));
				item.setItemPicture(rs.getString("itemPicture"));
				item.setRestaurant(rs.getString("restaurant"));
			}
			
			rs.close();
			stmt.close();
			conn.close();
			

		}
		catch(Exception sqle) {
			System.out.println("Error at CartServlet delete");
		}
		
		return item;
		
	}

}

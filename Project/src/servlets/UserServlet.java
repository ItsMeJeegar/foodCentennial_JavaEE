package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.User;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
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
		HttpSession session = request.getSession();
		//System.out.println(request.getParameter("loginid").toString());
		if(request.getParameter("userAction").toString().equals("Login"))
		{
			
			try {User user = new User();
			user.setId(Integer.parseInt(request.getParameter("loginid").toString()));
			user.setPassword(request.getParameter("loginpass").toString());
			
			int id = loginCheck(request, response, user, session);
			if(id!=0) {
				session.setAttribute("userid", id);
				
			}
			else {
				session.removeAttribute("userid");
				request.setAttribute("login", "fail");
				
			}
			}
			catch(Exception e) {
				session.removeAttribute("userid");
			}
		}
		
		else if(request.getParameter("userAction").toString().equals("Logout"))
		{
			session.invalidate();
		}
		
		request.getRequestDispatcher("index_home.jsp").forward(request, response);
	}

	private int loginCheck(HttpServletRequest request, HttpServletResponse response, User user, HttpSession session) {
		
		int id = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			Statement stmt = conn.createStatement();
			ResultSet rs;
			String sql = "select * from User where id = "+user.getId()+" and password = '"+user.getPassword()+"'";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				id = Integer.parseInt(rs.getString("id"));
				session.setAttribute("username", rs.getString("firstName") + " " + rs.getString("lastName"));
			}
			rs.close();
			stmt.close();
			conn.close();
			

		}
		catch(Exception sqle) {
			System.out.println("Error at UserServlet loginCheck");
		}
		return id;
	}

}

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

import models.Employee;
import models.Item;

/**
 * Servlet implementation class EmployeeServlet
 */
@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		session.setAttribute("empres", request.getParameter("res").toString());
		response.sendRedirect("employee_orders.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if(request.getParameter("employeeAction")!=null && request.getParameter("employeeAction").equals("Log In")) {
			Employee employee = new Employee();
			employee.setEmployeeId(Integer.parseInt(request.getParameter("empid")));
			employee.setPassword(request.getParameter("emppass"));
			boolean flag = checkLogin(employee, session);
			if(flag==true) {
				
				response.sendRedirect("employee_orders.jsp");
			}
			else {
				request.setAttribute("emplogin", "fail");
				request.getRequestDispatcher("employee_login.jsp").forward(request, response);
				
			}
			
		}
		
		if(request.getParameter("employeeAction")!=null && request.getParameter("employeeAction").equals("Logout")) {
			session.removeAttribute("empid");
			response.sendRedirect("employee_login.jsp");
		}
	}

	private boolean checkLogin(Employee employee, HttpSession session) {
		// TODO Auto-generated method stub
		int id = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			Statement stmt = conn.createStatement();
			ResultSet rs;
			String sql = "select * from Employee where employeeId = "+employee.getEmployeeId()+" and password = '"+employee.getPassword()+"'";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				session.setAttribute("empname", rs.getString("firstName") + " " + rs.getString("lastName"));
				session.setAttribute("empid", rs.getString("employeeId"));
				session.setAttribute("empres", rs.getString("restaurant"));
				return true;
			}
			rs.close();
			stmt.close();
			conn.close();
			

		}
		catch(Exception sqle) {
			System.out.println("Error at UserServlet loginCheck");
		}
		return false;
	}
	
	
	

}

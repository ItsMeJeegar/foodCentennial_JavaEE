package models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Employee {

	private int employeeId;
	private String firstName;
	private String lastName;
	private String password;
	private int restaurantId;
	private String restaurant;
	private boolean isManager;
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}
	public String getRestaurant() {
		return restaurant;
	}
	public void setRestaurant(String restaurant) {
		this.restaurant = restaurant;
	}
	public boolean isManager() {
		return isManager;
	}
	public void setManager(boolean isManager) {
		this.isManager = isManager;
	}
	
	public static void main(String[] args) {
	
		Employee emp = new Employee();
		emp.setEmployeeId(300834567);
		emp.setFirstName("Employee");
		emp.setLastName("Employee");
		emp.setPassword("12345");
		emp.setRestaurant("Subway");
		emp.setManager(true);
		
		emp.manualInsert(emp);
		
		emp.displayItems();
	}
	
	public void manualInsert(Employee employee) {
		Connection conn = null;
		Statement stmt = null;
		
		
		try {
			String sql = "insert into Employee(employeeId, firstName, lastName, password, restaurant, isManager)"
					+ " values('"+employee.getEmployeeId()+"','"+employee.getFirstName()+"','"+employee.getLastName()+"','"+employee.getPassword()+"','"+employee.getRestaurant()+"','"+employee.isManager()+"')";
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
	
	public void manualDelete(Employee employee) {
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
	
	public void manualQuery(Employee employee) {
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
			String sql = "select * from Employee";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while(rs.next()) {
				for (int i = 1; i <= 7; i++) {
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

package models;
import java.sql.*;
import java.util.Date;
public class Item {
	
	private int itemId;
	private int restId;
	private String itemName;
	private String restaurant;
	private String itemPicture;
	private String description;
	private String availability;
	private String category;
	private float cost;
	private Date addedDate;
	
	public static void main(String[] args) {
		
		Item item = new Item();
		
		item.setItemId(11);
		item.manualDelete(item);
		item.displayItems();
	}
	
	public void manualInsert(Item item) {
		Connection conn = null;
		Statement stmt = null;
		System.out.println(item.getRestaurant());
		
		try {
			String sql = "insert into Item(restId,itemName,restaurant,itemPicture,description,availability,category,cost)"
					+ " values('"+item.getRestId()+"','"+item.getItemName()+"','"+item.getRestaurant()+"','"+item.getItemPicture()+"','"+item.getDescription()+"','"+item.getAvailability()+"','"+item.getCategory()+"','"+item.getCost()+"');";
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
	
	public void manualDelete(Item item) {
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

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public int getRestId() {
		return restId;
	}

	public void setRestId(int restId) {
		this.restId = restId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getRestaurant() {
		return restaurant;
	}

	public void setRestaurant(String restaurant) {
		this.restaurant = restaurant;
	}

	public String getItemPicture() {
		return itemPicture;
	}

	public void setItemPicture(String itemPicture) {
		this.itemPicture = itemPicture;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAvailability() {
		return availability;
	}

	public void setAvailability(String availability) {
		this.availability = availability;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public float getCost() {
		return cost;
	}

	public void setCost(float d) {
		this.cost = d;
	}

	public Date getAddedDate() {
		return addedDate;
	}

	public void setAddedDate(Date addedDate) {
		this.addedDate = addedDate;
	}
	
	
}

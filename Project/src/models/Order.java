package models;

import java.util.Date;

public class Order {

	private int orderId;
	private int orderNumber;
	private int userId;
	private String userType;
	private float total;
	private float tax;
	private float totalWithTax;
	private Date orderDate;
	
	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(int orderNumber) {
		this.orderNumber = orderNumber;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public float getTotalWithTax() {
		return totalWithTax;
	}

	public void setTotalWithTax(float totalWithTax) {
		this.totalWithTax = totalWithTax;
	}
}

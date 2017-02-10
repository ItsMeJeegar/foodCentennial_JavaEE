package servlets;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
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
 * Servlet implementation class PictureUploadServlet
 */
@WebServlet("/PictureUploadServlet")
public class PictureUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PictureUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		String itemId = session.getAttribute("pictureItemId").toString();
		String itemPicture = "no.png";
		if(ServletFileUpload.isMultipartContent(request)){
			System.out.println("Inside multipart");
			try {
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        String name = new File(item.getName()).getName();
                        name = itemId + name;
                        itemPicture = "images/items/"+ name;
                        item.write( new File("/Users/Jeegar/Documents/workspace/workspace2016EE/Project/WebContent/" + itemPicture));
                    }
                }
           
               //File uploaded successfully
               request.setAttribute("message", "File Upload Successful.");
               
               System.out.println("Inserted illltem with path:"+itemPicture);
               Item item = new Item();
               item.setItemId(Integer.parseInt(itemId));
               item.setItemPicture(itemPicture);
               addPicture(item);
               System.out.println(";p;");
               
            } catch (Exception ex) {
               ex.printStackTrace();
            }          
         
        }else{
            request.setAttribute("message",
                                 "Sorry this Servlet only handles file upload request");
        }
        session.setAttribute("session", "valid");
        try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        response.sendRedirect("employee_manage_items.jsp");

	}
	
	private void addPicture(Item item) {
		// TODO Auto-generated method stub
		Connection conn = null;
		Statement stmt = null;
		
		System.out.println(item.getItemId()+" for "+item.getItemPicture());
		try {
			String sql = "update Item set itemPicture='"+item.getItemPicture()+"' where itemId="+item.getItemId()+"";
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


}

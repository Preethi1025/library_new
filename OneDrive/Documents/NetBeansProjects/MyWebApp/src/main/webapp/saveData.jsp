<%@ page import="java.sql.*" %>
<%
    // MySQL Connection Parameters
    String url = "jdbc:mysql://localhost:3306/library"; // Change "library" to your actual database name
    String user = "root"; // Your MySQL username
    String password = "Preethi1002@"; // Your MySQL password

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load MySQL Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish Connection
        conn = DriverManager.getConnection(url, user, password);

        // SQL Query
        String query = "INSERT INTO 2023_2024_data (id, semester, engg_mba, year, month, date_of_invoice, purchase_type, invoice_no, name_of_the_book_supplier, department_subject, book_accn_no_from, book_accn_no_to, no_of_books, no_of_books_purchased, no_of_books_donated, acc_reg_no, discount_percentage, gross_invoice_amount, discount_amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(query);

        // Set Parameters
        pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
        pstmt.setString(2, request.getParameter("semester"));
        pstmt.setString(3, request.getParameter("engg_mba"));
        pstmt.setInt(4, Integer.parseInt(request.getParameter("year")));
        pstmt.setInt(5, Integer.parseInt(request.getParameter("month")));
        pstmt.setString(6, request.getParameter("date_of_invoice"));
        pstmt.setString(7, request.getParameter("purchase_type"));
        pstmt.setString(8, request.getParameter("invoice_no"));
        pstmt.setString(9, request.getParameter("name_of_the_book_supplier"));
        pstmt.setString(10, request.getParameter("department_subject"));
        pstmt.setInt(11, Integer.parseInt(request.getParameter("book_accn_no_from")));
        pstmt.setInt(12, Integer.parseInt(request.getParameter("book_accn_no_to")));
        pstmt.setInt(13, Integer.parseInt(request.getParameter("no_of_books")));
        pstmt.setString(14, request.getParameter("no_of_books_purchased"));
        pstmt.setString(15, request.getParameter("no_of_books_donated"));
        pstmt.setInt(16, Integer.parseInt(request.getParameter("acc_reg_no")));
        pstmt.setString(17, request.getParameter("discount_percentage"));
        pstmt.setInt(18, Integer.parseInt(request.getParameter("gross_invoice_amount")));
        pstmt.setDouble(19, Double.parseDouble(request.getParameter("discount_amount")));

        // Execute Query
        int rowsInserted = pstmt.executeUpdate();
        if (rowsInserted > 0) {
            out.print("Success");
        } else {
            out.print("Error: No rows inserted!");
        }
    } catch (Exception e) {
        e.printStackTrace(); // Print error on server console
        out.print("Database Error: " + e.getMessage()); // Display error on webpage
    } finally {
        // Close resources
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

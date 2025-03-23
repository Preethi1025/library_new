<%@ page import="java.sql.*" %>
<%
    String year = request.getParameter("year");
    String semester = request.getParameter("semester");
    String supplier = request.getParameter("supplier");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int totalBooks = 0, totalPurchased = 0, totalDonated = 0;
    double totalNetAmount = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "username", "password");

        // Build query for summary statistics
        String query = "SELECT SUM(no_of_books) AS total_books, SUM(no_of_books_purchased) AS total_purchased, SUM(no_of_books_donated) AS total_donated, SUM(net_amount) AS total_net FROM 2023_2024_data WHERE year = ? AND semester = ?";
        if (supplier != null && !supplier.isEmpty()) {
            query += " AND name_of_the_book_supplier = ?";
        }

        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, year);
        pstmt.setString(2, semester);
        if (supplier != null && !supplier.isEmpty()) {
            pstmt.setString(3, supplier);
        }

        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalBooks = rs.getInt("total_books");
            totalPurchased = rs.getInt("total_purchased");
            totalDonated = rs.getInt("total_donated");
            totalNetAmount = rs.getDouble("total_net");
        }

        // Close previous result set and statement
        rs.close();
        pstmt.close();

        // Fetch full records for table display
        query = "SELECT * FROM 2023_2024_data WHERE year = ? AND semester = ?";
        if (supplier != null && !supplier.isEmpty()) {
            query += " AND name_of_the_book_supplier = ?";
        }

        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, year);
        pstmt.setString(2, semester);
        if (supplier != null && !supplier.isEmpty()) {
            pstmt.setString(3, supplier);
        }

        rs = pstmt.executeQuery();
%>

<!-- Display Summary Report -->
<div class="mb-3">
    <h5>Summary Report (<%= supplier == null || supplier.isEmpty() ? "All Suppliers" : supplier %>)</h5>
    <table class="table table-bordered">
        <tr>
            <th>Total Books</th>
            <th>Total Purchased</th>
            <th>Total Donated</th>
            <th>Total Net Amount</th>
        </tr>
        <tr>
            <td><%= totalBooks %></td>
            <td><%= totalPurchased %></td>
            <td><%= totalDonated %></td>
            <td>? <%= String.format("%.2f", totalNetAmount) %></td>
        </tr>
    </table>
</div>

<!-- Display Detailed Table -->
<table class="table table-bordered">
    <thead>
        <tr>
            <th>ID</th>
            <th>Semester</th>
            <th>Engg/MBA</th>
            <th>Year</th>
            <th>Month</th>
            <th>Date of Invoice</th>
            <th>Purchase Type</th>
            <th>Invoice No</th>
            <th>Book Supplier</th>
            <th>Department</th>
            <th>No. of Books</th>
            <th>No. of Purchased Books</th>
            <th>No. of Donated Books</th>
            <th>Net Amount</th>
        </tr>
    </thead>
    <tbody>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("semester") %></td>
            <td><%= rs.getString("engg_mba") %></td>
            <td><%= rs.getInt("year") %></td>
            <td><%= rs.getInt("month") %></td>
            <td><%= rs.getDate("date_of_invoice") %></td>
            <td><%= rs.getString("purchase_type") %></td>
            <td><%= rs.getString("invoice_no") %></td>
            <td><%= rs.getString("name_of_the_book_supplier") %></td>
            <td><%= rs.getString("department_subject") %></td>
            <td><%= rs.getInt("no_of_books") %></td>
            <td><%= rs.getInt("no_of_books_purchased") %></td>
            <td><%= rs.getInt("no_of_books_donated") %></td>
            <td>? <%= String.format("%.2f", rs.getDouble("net_amount")) %></td>
        </tr>
        <% } %>
    </tbody>
</table>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<%@ page import="java.sql.*" %>
<%@ include file="dConfig.jsp" %>

<%
    String semester = request.getParameter("semester");
    String year = request.getParameter("year");
    String purchaseType = request.getParameter("purchaseType");
    String department = request.getParameter("department");

    try (Connection conn = getConnection()) {
        String query = "SELECT * FROM 2023_2024_data WHERE 1=1";
        if (!semester.isEmpty()) query += " AND semester = ?";
        if (!year.isEmpty()) query += " AND year = ?";
        if (!purchaseType.isEmpty()) query += " AND purchase_type = ?";
        if (!department.isEmpty() ) query += " AND department_subject = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            int index = 1;
            if (!semester.isEmpty()) pstmt.setString(index++, semester);
            if (!year.isEmpty()) pstmt.setString(index++, year);
            if (!purchaseType.isEmpty()) pstmt.setString(index++, purchaseType);
            if (!department.isEmpty()) pstmt.setString(index++, department);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getString("semester") + "</td>");
                    out.println("<td>" + rs.getString("engg_mba") + "</td>");
                    out.println("<td>" + rs.getString("date_of_invoice") + "</td>");
                    out.println("<td>" + rs.getString("purchase_type") + "</td>");
                    out.println("<td>" + rs.getString("book_accn_no_from") + "</td>");
                    out.println("<td>" + rs.getString("book_accn_no_to") + "</td>");
                    out.println("<td>" + rs.getString("invoice_no") + "</td>");
                    out.println("<td>" + rs.getString("name_of_the_book_supplier") + "</td>");
                    out.println("<td>" + rs.getString("department_subject") + "</td>");
                    out.println("<td>"+rs.getString("no_of_books")+"</td>");
                    out.println("<td>" + rs.getString("gross_invoice_amount") + "</td>");
                    out.println("<td>" + rs.getString("discount_amount") + "</td>");
                    out.println("<td>" + rs.getString("net_amount") + "</td>");
                    out.println("</tr>");
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<%@ page import="java.sql.*" %>
<%@ include file="dConfig.jsp" %>

<%
    String semester = request.getParameter("semester");
    String year = request.getParameter("year");
    String purchaseType = request.getParameter("purchaseType");
    String department = request.getParameter("department");
    String supplier = request.getParameter("supplier"); // Added supplier filter

    try (Connection conn = getConnection()) {
        StringBuilder query = new StringBuilder("SELECT * FROM 2023_2024_data WHERE 1=1");

        if (semester != null && !semester.isEmpty()) query.append(" AND semester = ?");
        if (year != null && !year.isEmpty()) query.append(" AND year = ?");
        if (purchaseType != null && !purchaseType.isEmpty()) query.append(" AND purchase_type = ?");
        if (department != null && !department.isEmpty()) query.append(" AND department_subject = ?");
        if (supplier != null && !supplier.isEmpty()) query.append(" AND name_of_the_book_supplier = ?");

        try (PreparedStatement pstmt = conn.prepareStatement(query.toString())) {
            int index = 1;
            if (semester != null && !semester.isEmpty()) pstmt.setString(index++, semester);
            if (year != null && !year.isEmpty()) pstmt.setString(index++, year);
            if (purchaseType != null && !purchaseType.isEmpty()) pstmt.setString(index++, purchaseType);
            if (department != null && !department.isEmpty()) pstmt.setString(index++, department);
            if (supplier != null && !supplier.isEmpty()) pstmt.setString(index++, supplier);

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
                    out.println("<td>" + rs.getString("name_of_the_book_supplier") + "</td>"); // Supplier Column
                    out.println("<td>" + rs.getString("department_subject") + "</td>");
                    out.println("<td>" + rs.getString("no_of_books") + "</td>");
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

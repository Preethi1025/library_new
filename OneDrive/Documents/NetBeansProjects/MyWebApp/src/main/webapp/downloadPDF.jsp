<%--<%@ page import="java.sql.*, java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>
<%@ include file="dConfig.jsp" %>

<%
    String semester = request.getParameter("semester");
    String year = request.getParameter("year");
    String purchaseType = request.getParameter("purchaseType");
    String department = request.getParameter("department");
    String supplier = request.getParameter("supplier");

// Set the PDF response type
response.setContentType("application/pdf");
response.setHeader("Content-Disposition", "attachment; filename=Library_Report.pdf");

try {
    Document document = new Document();
    PdfWriter.getInstance(document, response.getOutputStream());
    document.open();

    // Title
    Font titleFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
    Paragraph title = new Paragraph("Library Report\n\n", titleFont);
    title.setAlignment(Element.ALIGN_CENTER);
    document.add(title);

    // Table Header
    PdfPTable table = new PdfPTable(8); // 8 columns
    table.setWidthPercentage(100);
    table.addCell("ID");
    table.addCell("Semester");
    table.addCell("Engg/MBA");
    table.addCell("Date of Invoice");
    table.addCell("Purchase Type");
    table.addCell("Invoice No");
    table.addCell("Supplier Name");
    table.addCell("Department");

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
                    table.addCell(String.valueOf(rs.getInt("id")));
                    table.addCell(rs.getString("semester"));
                    table.addCell(rs.getString("engg_mba"));
                    table.addCell(rs.getString("date_of_invoice"));
                    table.addCell(rs.getString("purchase_type"));
                    table.addCell(rs.getString("invoice_no"));
                    table.addCell(rs.getString("name_of_the_book_supplier"));
                    table.addCell(rs.getString("department_subject"));
                }
            }
        }
    }

    document.add(table);
    document.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>--%>

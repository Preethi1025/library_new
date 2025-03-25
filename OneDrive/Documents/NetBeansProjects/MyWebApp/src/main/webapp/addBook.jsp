<%@ page import="java.sql.*, java.io.*" %>
<%@ include file="dConfig.jsp" %>
<%
    // Database credentials
//    String URL = "jdbc:mysql://localhost:3306/library";
//    String USER = "root";
//    String PASSWORD = "Preethi1002@";

    // Retrieve form data safely (handling null and empty values inline)
    int id = (request.getParameter("id") != null && !request.getParameter("id").trim().isEmpty()) 
             ? Integer.parseInt(request.getParameter("id")) : 0;

    String semester = request.getParameter("semester");
    String engg_mba = request.getParameter("engg_mba");

    int year = (request.getParameter("year") != null && !request.getParameter("year").trim().isEmpty()) 
               ? Integer.parseInt(request.getParameter("year")) : 0;

    int month = (request.getParameter("month") != null && !request.getParameter("month").trim().isEmpty()) 
                ? Integer.parseInt(request.getParameter("month")) : 0;

    String date_of_invoice = request.getParameter("date_of_invoice");
    String purchase_type = request.getParameter("purchase_type");
    String invoice_no = request.getParameter("invoice_no");
    String name_of_the_book_supplier = request.getParameter("name_of_the_book_supplier");
    String department_subject = request.getParameter("department_subject");

    int book_accn_no_from = (request.getParameter("book_accn_no_from") != null && !request.getParameter("book_accn_no_from").trim().isEmpty()) 
                            ? Integer.parseInt(request.getParameter("book_accn_no_from")) : 0;

    int book_accn_no_to = (request.getParameter("book_accn_no_to") != null && !request.getParameter("book_accn_no_to").trim().isEmpty()) 
                          ? Integer.parseInt(request.getParameter("book_accn_no_to")) : 0;

    int no_of_books = (request.getParameter("no_of_books") != null && !request.getParameter("no_of_books").trim().isEmpty()) 
                      ? Integer.parseInt(request.getParameter("no_of_books")) : 0;

    int no_of_books_purchased = (request.getParameter("no_of_books_purchased") != null && !request.getParameter("no_of_books_purchased").trim().isEmpty()) 
                                 ? Integer.parseInt(request.getParameter("no_of_books_purchased")) : 0;

    int no_of_books_donated = (request.getParameter("no_of_books_donated") != null && !request.getParameter("no_of_books_donated").trim().isEmpty()) 
                               ? Integer.parseInt(request.getParameter("no_of_books_donated")) : 0;

    int acc_reg_no = (request.getParameter("acc_reg_no") != null && !request.getParameter("acc_reg_no").trim().isEmpty()) 
                     ? Integer.parseInt(request.getParameter("acc_reg_no")) : 0;

    int accn_register_page_no_from = (request.getParameter("accn_register_page_no_from") != null && !request.getParameter("accn_register_page_no_from").trim().isEmpty()) 
                                     ? Integer.parseInt(request.getParameter("accn_register_page_no_from")) : 0;

    int accn_register_page_no_to = (request.getParameter("accn_register_page_no_to") != null && !request.getParameter("accn_register_page_no_to").trim().isEmpty()) 
                                   ? Integer.parseInt(request.getParameter("accn_register_page_no_to")) : 0;

    double discount_percentage = (request.getParameter("discount_percentage") != null && !request.getParameter("discount_percentage").trim().isEmpty()) 
                                 ? Double.parseDouble(request.getParameter("discount_percentage")) : 0.0;

    int gross_invoice_amount = (request.getParameter("gross_invoice_amount") != null && !request.getParameter("gross_invoice_amount").trim().isEmpty()) 
                               ? Integer.parseInt(request.getParameter("gross_invoice_amount")) : 0;

    double discount_amount = (request.getParameter("discount_amount") != null && !request.getParameter("discount_amount").trim().isEmpty()) 
                             ? Double.parseDouble(request.getParameter("discount_amount")) : 0.0;

    int net_amount = (request.getParameter("net_amount") != null && !request.getParameter("net_amount").trim().isEmpty()) 
                     ? Integer.parseInt(request.getParameter("net_amount")) : 0;

    // Insert data into MySQL
    try (Connection connection = getConnection();
         PreparedStatement statement = connection.prepareStatement(
                 "INSERT INTO `2023_2024_data` (id, semester, engg_mba, year, month, date_of_invoice, purchase_type, invoice_no, " +
                 "name_of_the_book_supplier, department_subject, book_accn_no_from, book_accn_no_to, no_of_books, no_of_books_purchased, " +
                 "no_of_books_donated, acc_reg_no, accn_register_page_no_from, accn_register_page_no_to, discount_percentage, " +
                 "gross_invoice_amount, discount_amount, net_amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {

        statement.setInt(1, id);
        statement.setString(2, semester);
        statement.setString(3, engg_mba);
        statement.setInt(4, year);
        statement.setInt(5, month);
        statement.setString(6, date_of_invoice);
        statement.setString(7, purchase_type);
        statement.setString(8, invoice_no);
        statement.setString(9, name_of_the_book_supplier);
        statement.setString(10, department_subject);
        statement.setInt(11, book_accn_no_from);
        statement.setInt(12, book_accn_no_to);
        statement.setInt(13, no_of_books);
        statement.setInt(14, no_of_books_purchased);
        statement.setInt(15, no_of_books_donated);
        statement.setInt(16, acc_reg_no);
        statement.setInt(17, accn_register_page_no_from);
        statement.setInt(18, accn_register_page_no_to);
        statement.setDouble(19, discount_percentage);
        statement.setInt(20, gross_invoice_amount);
        statement.setDouble(21, discount_amount);
        statement.setInt(22, net_amount);

        statement.executeUpdate();
        out.println("<script>alert('Record added successfully!');</script>");
    } catch (Exception e) {
        out.println("<script>alert('Error saving record: " + e.getMessage() + "');</script>");
        e.printStackTrace();
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%!  
    public static Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/library"; 
        String user = "root"; 
        String password = "Preethi1002@"; 
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }
%>

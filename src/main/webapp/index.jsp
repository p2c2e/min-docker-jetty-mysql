<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.*,javax.sql.*"%>
<%@page import="in.diyd2.*"%>

<%
String query = "Select * FROM TestTable";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=us-ascii">

    <title>Simple JSP - MySQL Webpage</title>
</head> 

<body>
    <h1>Simple JSP - MySQL Webpage</h1>
    
    <%
    Connection connection = null;

    try {
	String dbname = "TestDB";
	String hostname = "mysql-server";
	String user = "root";
	String password = "mysqlpass";
	String port = "3306";

	String dbUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbname;

	Class.forName("com.mysql.jdbc.Driver");
	connection =  DriverManager.getConnection(dbUrl, user, password);
        
        if (connection != null && !connection.isClosed()) {
        
            out.println("<p>Connected to MySQL</p>");

            Statement s = connection.createStatement();
            int count;
            
            s.executeUpdate("DROP TABLE IF EXISTS TestTable");
            s.executeUpdate("CREATE TABLE TestTable (" + "id INT UNSIGNED NOT NULL AUTO_INCREMENT," + "PRIMARY KEY (id)," + "name CHAR(40), comment CHAR(40))");

            out.println("<p>Table successfully created.</p>");

            count = s.executeUpdate("INSERT INTO TestTable (name, comment)" + " VALUES" + "('John Doe', 'Resident of many states')," + "('Jane Doe', 'Friend of John')");

            out.println("<p>" + count + " rows were inserted.</p>");

            count = 0;
            ResultSet rs = s.executeQuery("select * from TestTable");
	    out.println("<table border='1'><tr><td>ID</td><td>Name</td><td>Comments</td></tr>");
            while (rs.next()) {
                count++;
		out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td></tr>");
            }
	    out.println("</table>");
            out.println("<p>" + count + " rows were fetched.</p>");

            s.close();
        } else {
        	out.println("<b>Something is not quite right : "+connection+"</b>");
        }
    } catch (Exception e) {
        out.println(e.getMessage());
    } finally {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }

        connection = null;
    }
    %>
</body>
</html>

<%@ page import="java.sql.*" %>
<html>
<head><title>Employee Salary Report</title></head>
<body>
<%
    String inputEmpNo = request.getParameter("empno");
    String inputEmpName = request.getParameter("empname");
    String inputBasicSalary = request.getParameter("basicsalary");

    Connection conn = null;
    PreparedStatement pst = null;
    Statement stmt = null;
    ResultSet rs = null;
    double grandTotal = 0.0;

    String url = "jdbc:mysql://localhost:3306/Employee?useSSL=false&serverTimezone=UTC";
    String user = "root"; // Change as needed
    String pass = "";     // Change as needed

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);

        // Insert only if parameters are provided
        if (inputEmpNo != null && inputEmpName != null && inputBasicSalary != null &&
            !inputEmpNo.isEmpty() && !inputEmpName.isEmpty() && !inputBasicSalary.isEmpty()) {

            pst = conn.prepareStatement("INSERT INTO Emp (Emp_No, Emp_Name, BasicSalary) VALUES (?, ?, ?)");
            pst.setInt(1, Integer.parseInt(inputEmpNo));
            pst.setString(2, inputEmpName);
            pst.setDouble(3, Double.parseDouble(inputBasicSalary));
            pst.executeUpdate();
        }

        // Fetch all records
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM Emp");
%>
        <h2>Salary Report</h2>
        <pre>
<%
        while (rs.next()) {
            int eno = rs.getInt("Emp_No");
            String ename = rs.getString("Emp_Name");
            double sal = rs.getDouble("BasicSalary");
            grandTotal += sal;
%>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Emp_No   : <%= eno %>
Emp_Name : <%= ename %>
Basic    : <%= sal %>
<%
        }
%>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grand Salary : <%= grandTotal %>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
</pre>
<%
    } catch (Exception e) {
%>
    <p style="color:red;">Error: <%= e.getMessage() %></p>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pst != null) pst.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

<%@ page import="java.sql.*" %>
<%
    String empno = request.getParameter("empno");
    String empname = request.getParameter("empname");
    String basicsalary = request.getParameter("basicsalary");

    Connection conn = null;
    PreparedStatement pst = null;
    Statement stmt = null;
    ResultSet rs = null;

    String url = "jdbc:mysql://localhost:3306/Employee?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String pass = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);

        if (empno != null && !empno.isEmpty() && empname != null && !empname.isEmpty()
                && basicsalary != null && !basicsalary.isEmpty()) {
            // Use exact column names here!
            pst = conn.prepareStatement("UPDATE Emp SET Emp_Name = ?, BasicSalary = ? WHERE Emp_No = ?");
            pst.setString(1, empname);
            pst.setDouble(2, Double.parseDouble(basicsalary));
            pst.setInt(3, Integer.parseInt(empno));

            int updated = pst.executeUpdate();

            if (updated > 0) {
%>
                <p style="color:green;">Employee updated successfully!</p>
<%
            } else {
%>
                <p style="color:red;">Employee with Emp_No <%= empno %> not found!</p>
<%
            }
        } else {
%>
            <p style="color:blue;">Please enter Emp_No, Emp_Name, and BasicSalary.</p>
<%
        }

        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM Emp");
%>
        <h2>Employee Table</h2>
        <table border="1">
            <tr>
                <th>Emp No</th>
                <th>Emp Name</th>
                <th>Basic Salary</th>
            </tr>
<%
        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("Emp_No") %></td>
                <td><%= rs.getString("Emp_Name") %></td>
                <td><%= rs.getDouble("BasicSalary") %></td>
            </tr>
<%
        }
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
        </table>

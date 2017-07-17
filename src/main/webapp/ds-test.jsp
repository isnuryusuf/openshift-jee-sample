<%@page import="java.sql.*, java.io.*, javax.sql.DataSource, javax.naming.*"%> 

<%! 
String dsName = "java:jboss/mufinsCX2"; 
%> 
<% 
String req = request.getParameter ("dsName"); 
if (req != null) { 
dsName = req; 
} 
%> 
<form method="post" action="<%=request.getRequestURI()%>"> 
Enter Datasource Name:<input type="text" value="<%=dsName%>" name="dsName"/><br> 
<input type="submit" value="submit"/> 
</form> 

<% 
try { 
String driver = ""; 
String db = ""; 


if (!dsName.equals("")) { 
InitialContext ctx = new InitialContext(); 
DataSource dataSource = (DataSource) ctx.lookup (dsName); 
Connection con = dataSource.getConnection(); 
DatabaseMetaData dmd = con.getMetaData(); 
db = dmd.getDatabaseProductName() + " " + dmd.getDatabaseProductVersion(); 
driver = dmd.getDriverName() + " " + dmd.getDriverVersion(); 

%> 
Success! We looked up and got a connection to <%=dsName%><br> 
Database: <%=db%> <br> 
Driver version: <%=driver%><br> 
<% 
} 
} 
catch (Exception e) { 
PrintWriter pw = new PrintWriter (out); 
%> 
There was an exeption getting a connection to or looking up the datasource:<%=dsName%><br> 
        <%
        e.printStackTrace (pw);
        %>
    

<% 

} 
%> 

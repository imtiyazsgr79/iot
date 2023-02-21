<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@  taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@  taglib  uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"  %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table align="center" border="1">
<tr><th colspan="4">ALL outputs </th></tr>

<th>ID</th>
<th>BOARD</th>
<th>GPIO</th>
<th>NAME</th>
<th>STATE</th>

<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/iot" user="root" password="" />
<sql:query var="rs" dataSource="${db}">select * from outputs</sql:query>
<c:forEach items="${rs.rows }" var="outputs">
<tr><td>${outputs.id }</td><td>${outputs.board }</td><td>${outputs.gpio }</td><td>${outputs.name }</td><td>${outputs.state }</td></tr>

</c:forEach>
</table>
<c:out value="${board }"></c:out>
</body>
</html>
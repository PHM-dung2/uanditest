<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2> Test Table List </h2>
	<table border="1">
		<tr>
			<th> userno </th>
			<th> username </th>
		</tr>
		<c:forEach var="item" items="${list}" >
			<tr>
				<td>${item.userNo}</td>
				<td>${item.userName}</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>
<%@page import="domain.Payment"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td, th {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #dddddd;
}
</style>
</head>
<body>
	<%
		Payment pay = (Payment) request.getAttribute("PAY");
	%>
	<form action="PaymentController" method="POST">
		<table>
			<tr>
				<td>Customer Number</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"customernumber\" readonly value=" + pay.getCustomer().getCustomernumber());
					%>
				</td>
			</tr>
			<tr>
				<td>Check Number</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"checknumber\" value=" + pay.getId().getChecknumber());
					%>
				</td>
			</tr>
			<tr>
				<td>Payment Date</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"paymentdate\" value=" + pay.getPaymentdate());
					%>
				</td>
			</tr>
			<tr>
				<td>Amount</td>
				<td>
					<%
						out.println("<input type=\"text\" name=\"amount\" value=" + pay.getAmount());
					%>
				</td>
			</tr>
		</table>
		<input type="submit" name="UPDATE" value="UPDATE" /> 
		<input type="submit" name="DELETE" value="DELETE" />
	</form>
</body>
</html>
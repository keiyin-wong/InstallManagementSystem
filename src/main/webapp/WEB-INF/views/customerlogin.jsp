<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Customer Login</title>
</head>
<body>
    <div style="text-align: center">
        <h1>Customer Login</h1>
        <form action="CustomerLoginServlet" method="post">
            <label for="email">Email:</label>
            <input name="name" size="30" />
            <br><br>
            <label for="password">Password:</label>
            <input type="password" name="password" size="30" />
             <input hidden="password" name="currentPage" value="1" />
            <br>${message}
            <br><br>           
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
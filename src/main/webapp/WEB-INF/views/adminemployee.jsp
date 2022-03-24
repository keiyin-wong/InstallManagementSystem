<%@page import="domain.Employee"%>
<%@page import="domain.Product"%>
<%@page import="java.util.List"%>
<%@page import="domain.Order"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->
<head>
<!-- 
Kool Store Template
http://www.templatemo.com/preview/templatemo_428_kool_store
-->
<meta charset="utf-8">
<title>Kool Store - Responsive eCommerce Template</title>

<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<link
	href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800"
	rel="stylesheet">

<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/normalize.min.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/templatemo-misc.css">
<link rel="stylesheet" href="css/templatemo-style.css">

<script src="js/vendor/modernizr-2.6.2.min.js"></script>

<style>
.delete:hover {
	background-color: #713031;
}

.delete.selected {
	background-color: #713031;
}

.delete.selected .deleteBox {
	opacity: 1;
	-ms-filter:
		"progid:DXImageTransform.Microsoft.Alpha(Opacity=$opacityIE)";
	filter: alpha(opacity = 100);
	top: -110px;
	width: 275px;
	height: 100px;
	overflow: visible;
	-webkit-transition: opacity 0.3s, top 0.3s, width 0s, height 0s;
	-webkit-transition-delay: 0s, 0s, 0s, 0s;
	-moz-transition: opacity 0.3s, top 0.3s, width 0s 0s, height 0s 0s;
	-o-transition: opacity 0.3s, top 0.3s, width 0s 0s, height 0s 0s;
	transition: opacity 0.3s, top 0.3s, width 0s 0s, height 0s 0s;
	z-index: 2;
	position: absolute;
	top: -110px;
}

.delete .deleteBox {
	position: absolute;
	top: -90px;
	left: 50%;
	margin-left: -137px;
	overflow: hidden;
	background: #1C242B;
	width: 0px;
	height: 0px;
	border-radius: 5px;
	text-indent: 0px;
	cursor: default;
	opacity: 0;
	-ms-filter:
		"progid:DXImageTransform.Microsoft.Alpha(Opacity=$opacityIE)";
	filter: alpha(opacity = 0);
	-webkit-transition: opacity 0.3s, top 0.3s, width 0s, height 0s;
	-webkit-transition-delay: 0s, 0s, 0.3s, 0.3s;
	-moz-transition: opacity 0.3s, top 0.3s, width 0s 0.3s, height 0s 0.3s;
	-o-transition: opacity 0.3s, top 0.3s, width 0s 0.3s, height 0s 0.3s;
	transition: opacity 0.3s, top 0.3s, width 0s 0.3s, height 0s 0.3s;
	z-index: -1;
}

.delete .deleteBox:after {
	content: '';
	display: block;
	width: 0px;
	left: 0px;
	border-top: 5px solid #1C242B;
	border-left: 5px solid transparent;
	border-right: 5px solid transparent;
	position: absolute;
	bottom: -5px;
	left: 50%;
	margin-left: -5px;
}

.delete .deleteBox p {
	margin: 10px 0 3px;
}

.delete .deleteBox span {
	display: -moz-inline-stack;
	display: inline-block;
	vertical-align: middle;
	*vertical-align: auto;
	zoom: 1;
	*display: inline;
	margin: 0 10px;
	color: #FFF;
	border-radius: 3px;
	width: 80px;
	height: 25px;
	line-height: 25px;
	cursor: pointer;
	-webkit-transition: background 0.3s;
	-moz-transition: background 0.3s;
	-o-transition: background 0.3s;
	transition: background 0.3s;
}

.delete .deleteBox span.confirm {
	background: #38B87C;
}

.delete .deleteBox span.confirm:hover {
	background: #2c9162;
}

.delete .deleteBox span.cancel {
	background: #696F73;
}

.delete .deleteBox span.cancel:hover {
	background: #515558;
}

.delete .deleteBox:before {
	content: 'Deleting...';
	display: block;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 0px;
	height: 0px;
	text-align: center;
	line-height: 60px;
	opacity: 0;
	-ms-filter:
		"progid:DXImageTransform.Microsoft.Alpha(Opacity=$opacityIE)";
	filter: alpha(opacity = 0);
	border-radius: 5px;
	background: #1c242b
		url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAzMiAzMiIgd2lkdGg9IjMyIiBoZWlnaHQ9IjMyIiBmaWxsPSJ3aGl0ZSI+CiAgPGNpcmNsZSB0cmFuc2Zvcm09InRyYW5zbGF0ZSg4IDApIiBjeD0iMCIgY3k9IjE2IiByPSIwIj4gCiAgICA8YW5pbWF0ZSBhdHRyaWJ1dGVOYW1lPSJyIiB2YWx1ZXM9IjA7IDQ7IDA7IDAiIGR1cj0iMS4ycyIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIGJlZ2luPSIwIgogICAgICBrZXl0aW1lcz0iMDswLjI7MC43OzEiIGtleVNwbGluZXM9IjAuMiAwLjIgMC40IDAuODswLjIgMC42IDAuNCAwLjg7MC4yIDAuNiAwLjQgMC44IiBjYWxjTW9kZT0ic3BsaW5lIiAvPgogIDwvY2lyY2xlPgogIDxjaXJjbGUgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMTYgMCkiIGN4PSIwIiBjeT0iMTYiIHI9IjAiPiAKICAgIDxhbmltYXRlIGF0dHJpYnV0ZU5hbWU9InIiIHZhbHVlcz0iMDsgNDsgMDsgMCIgZHVyPSIxLjJzIiByZXBlYXRDb3VudD0iaW5kZWZpbml0ZSIgYmVnaW49IjAuMyIKICAgICAga2V5dGltZXM9IjA7MC4yOzAuNzsxIiBrZXlTcGxpbmVzPSIwLjIgMC4yIDAuNCAwLjg7MC4yIDAuNiAwLjQgMC44OzAuMiAwLjYgMC40IDAuOCIgY2FsY01vZGU9InNwbGluZSIgLz4KICA8L2NpcmNsZT4KICA8Y2lyY2xlIHRyYW5zZm9ybT0idHJhbnNsYXRlKDI0IDApIiBjeD0iMCIgY3k9IjE2IiByPSIwIj4gCiAgICA8YW5pbWF0ZSBhdHRyaWJ1dGVOYW1lPSJyIiB2YWx1ZXM9IjA7IDQ7IDA7IDAiIGR1cj0iMS4ycyIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIGJlZ2luPSIwLjYiCiAgICAgIGtleXRpbWVzPSIwOzAuMjswLjc7MSIga2V5U3BsaW5lcz0iMC4yIDAuMiAwLjQgMC44OzAuMiAwLjYgMC40IDAuODswLjIgMC42IDAuNCAwLjgiIGNhbGNNb2RlPSJzcGxpbmUiIC8+CiAgPC9jaXJjbGU+Cjwvc3ZnPg==")
		no-repeat center 50px;
	-webkit-transition: opacity 0.3s, top 0.3s, left 0.3s;
	-moz-transition: opacity 0.3s, top 0.3s, left 0.3s;
	-o-transition: opacity 0.3s, top 0.3s, left 0.3s;
	transition: opacity 0.3s, top 0.3s, left 0.3s;
}

.delete .deleteBox.loading:before {
	opacity: 1;
	-ms-filter:
		"progid:DXImageTransform.Microsoft.Alpha(Opacity=$opacityIE)";
	filter: alpha(opacity = 100);
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
}

.delete .deleteBox.deleted:before {
	content: attr(title);
	background: #1c242b
		url("data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoKCSB3aWR0aD0iNTEycHgiIGhlaWdodD0iNTEycHgiIHZpZXdCb3g9IjAgMCA1MTIgNTEyIiBlbmFibGUtYmFja2dyb3VuZD0ibmV3IDAgMCA1MTIgNTEyIiB4bWw6c3BhY2U9InByZXNlcnZlIj4KCjxwb2x5Z29uIGlkPSJjaGVjay1tYXJrLTctaWNvbiIgcG9pbnRzPSI1MCwyNDcuNzg3IDc3LjA5LDIxOS44MzMgMjA5Ljg1OSwyOTkuMjIyIDQzOC43ODcsODEuMjQ1IDQ2MiwxMDQuNSAyMTkuODYzLDQzMC43NTUgIiBmaWxsPSIjRkZGIi8+Cgo8L3N2Zz4=")
		no-repeat center 55px;
	background-size: 20px 20px;
}
</style>
</head>
<body>
	<!--[if lt IE 7]>
    <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
    <![endif]-->
	<%
	String admin = (String) session.getAttribute("admin");
	%>

	<header class="site-header">

		<div class="main-header">
			<div class="container">
				<div class="row">
					<div class="col-md-4 col-sm-6 col-xs-8">
						<div class="logo">
							<h1>
								<a href="index.html">Kool Store</a>
							</h1>
						</div>
						<!-- /.logo -->
					</div>
					<!-- /.col-md-4 -->
					<div class="col-md-8 col-sm-6 col-xs-4">
						<div class="main-menu">
							<a href="#" class="toggle-menu"> <i class="fa fa-bars"></i>
							</a>
							<ul class="menu">
								<li><a href="EmployeeOrderServlet?currentPage=1">Order</a></li>
								<li><a href="EmployeeEditPersonalInformation">Personal
										Information</a></li>
								<li><a href="EmployeeProductServlet?currentPage=1">Product</a></li>
								<li><a href="PaymentPaginationServlet?recordsPerPage=10 &currentPage=1">Payment</a></li>
								<%
								if (admin != null) {
								%>
								<li><a href="AdminEmployeeServlet?currentPage=1">Employee</a></li>
								<%
								}
								%>
								<li><a href="LogoutServlet">Logout</a></li>
							</ul>
						</div>
						<!-- /.main-menu -->
					</div>
					<!-- /.col-md-8 -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container -->
		</div>
		<!-- /.main-header -->

	</header>
	<!-- /.site-header -->

	<div class="content-section" style="z-index: 1">
		<main class='container' role='main'>
			<%
			if (admin != null) {
				String output = admin.substring(0, 1).toUpperCase() + admin.substring(1);
			%>
			<h2 class="container">
				Hello,
				<%=output%>!!!
			</h2>
			<%
			}
			%>
			<div class='container' style="margin-top: 60px">
				<h2>Employee list</h2>
				<div class='row'>
					<div class='col-xs-12'>
						<div class='orders-filter-container' role='tabpanel'>
							<ul class='nav nav-tabs' role='tablist'>
								<li class='active' role='presentation'><a href='#'
									role='tab'> Employees </a></li>
							</ul>
							<div class='tab-content'>
								<div class='tab-pane active' id='search' role='tabpanel'>
									<div class='row'>
										<div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'>
											<form class="form-inline orders-filter"
												action="AdminEmployeeServlet" accept-charset="UTF-8" method="get">
												<div class='col-xs-12 col-sm-7 col-md-6 col-lg-7'>
													<div class='row'>
														<div class="form-group col-sm-6 string optional">
															<label class="string optional col-sm-8 control-label">Employee Number</label>
															<div class="col-sm-8">
																<input value="" class="string optional form-control"
																	type="text" name="searchValue">
															</div>
														</div>
														<div class="col-sm-4" style="margin-top: 15px">
															<input type="submit" name="commit" value="Search"
																class="btn btn-primary" />
															<input type="hidden" name="currentPage" value="1">
														</div>
													</div>
													<div class='row'>
														<div class="form-group col-sm-7 string optional ">
															<div class="col-sm-8">
																<button class="btn btn-primary col-sm-8" type="button" onclick="window.location.href='AdminEmployeeDetailsServlet?createEmployee=CREATEEMPLOYEE'"
																	style="display: inline-block; margin-top: 10px; background-color: transparent; color: #428bca; border: 1px solid #ddd;">
																	Add a employee</button>
															</div>
														</div>
													</div>

												</div>
												<!-- ------------ -->


											</form>


										</div>
									</div>
								</div>
								<div class='tab-pane active' id='filter' role='tabpanel'>
									<div class='row'></div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class='row' id="tableContent">
					<div class='col-xs-12'>
						<div class='table-responsive orders-list'>
							<table class='table table-striped table-hover'>
								<%
								int currentPage = (int) request.getAttribute("currentPage");
								int nOfPages = (int) request.getAttribute("nOfPages");
								%>
								<thead>
									<tr>
										<th>Employee Number</th>
										<th>Last Name</th>
										<th>First Name</th>
										<th>Extension</th>
										<th>Email</th>
										<th>Office code</th>
										<th>Reports to</th>
										<th>Job title</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<%
									List<Employee> employees = (List<Employee>) request.getAttribute("employees");
									if (employees.size() != 0) {
										for (Employee p : employees) {
											out.println("<tr>");
											out.println("<td><a href=\"" + "AdminEmployeeDetailsServlet?empNumber=" + p.getEmployeenumber().toString()
											+ "\"</a>" + p.getEmployeenumber().toString() + "</td>");
											out.println("<td>" + p.getLastname() + "</td>");
											out.println("<td>" + p.getFirstname() + "</td>");
											out.println("<td>" + p.getExtension() + "</td>");
											out.println("<td>" + p.getEmail() + "</td>");
											out.println("<td>" + p.getOffice().getOfficecode().toString() + "</td>");
											out.println("<td>" + p.getReportsto() + "</td>");
											out.println("<td>" + p.getJobtitle() + "</td>");
											out.println("<td>" + "<button class=\"btn btn-primary delete\" type=\"button\"" + " value=\""
											+ p.getEmployeenumber() + "\""
											+ " style=\"display: inline-block; background-color: transparent; color: #428bca; border: 1px solid #ddd; position: relative;\">Delete</button>"
											+ "</td>");
											out.println("</tr>");
										}

									} else {
										out.println("<tr>");
										String status = "No records";
										for (int i = 0; i < 8; i++) {
											out.println("<td>" + status + "</td>");
										}
										out.println("</tr>");

									}
									%>
									<!-- <tr>
								<td><a href="/orders/ORD-12">ORD-12</a></td>
								<td>Pizza Order</td>
								<td><span><i class='fa fa-gears'></i> In progress</span></td>
								<td>03/09/2021 13:10 PM</td>
								<td>David Jones</td>
								<td></td>
								<td></td>
							</tr> -->
								<tbody>
							</table>
						</div>
					</div>
					<nav aria-label="Navigation for staffs">
						<ul class="pagination">

							<%
							if (currentPage != 1 && nOfPages != 0) {
							%>

							<%
							out.println("<li class=\"page-item\">");
							out.println("<a class=\"page-link\" href=\"" + "AdminEmployeeServlet?recordsPerPage=" + 10 + "&currentPage=1"
									+ "\">First</a>");
							out.println("</li>");
							%>


							<li class="page-item">
								<%
								out.println("<a class=\"page-link\" href=\"" + "AdminEmployeeServlet?recordsPerPage=" + 10 + "&currentPage="
										+ (currentPage - 1) + "\">Previous</a>");
								%>
							</li>
							<%
							}
							%>
							<%
							if (currentPage < nOfPages) {
								out.println("<li class=\"page-item\">");
								out.println("<a class=\"page-link\" href=\"" + "AdminEmployeeServlet?recordsPerPage=" + 10 + "&currentPage="
								+ (currentPage + 1) + "\">Next</a>");
								out.println("</li>");

								out.println("<li class=\"page-item\">");
								out.println("<a class=\"page-link\" href=\"" + "AdminEmployeeServlet?recordsPerPage=" + 10 + "&currentPage="
								+ nOfPages + "\">Last</a>");
								out.println("</li>");
							}
							%>

						</ul>
					</nav>
					<%
					if (nOfPages != 0) {
						out.println("<p class=\"pageref\">");
						out.println(currentPage + " of " + nOfPages);
						out.println("</p>");
					}

					//out.println("Text of Text");
					%>

				</div>

			</div>
		</main>
	</div>
	<!-- /.content-section -->



	<footer class="site-footer">
		<div class="our-partner">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="customNavigation">
							<a class="btn prev"><i class="fa fa-angle-left"></i></a> <a
								class="btn next"><i class="fa fa-angle-right"></i></a>
						</div>
						<div id="owl-demo" class="owl-carousel">
							<div class="item">
								<a href="#"><img src="images/tm-170x80-1.jpg" alt=""></a>
							</div>
							<div class="item">
								<a href="#"><img src="images/tm-170x80-2.jpg" alt=""></a>
							</div>
							<div class="item">
								<a href="#"><img src="images/tm-170x80-1.jpg" alt=""></a>
							</div>
							<div class="item">
								<a href="#"><img src="images/tm-170x80-2.jpg" alt=""></a>
							</div>
							<div class="item">
								<a href="#"><img src="images/tm-170x80-1.jpg" alt=""></a>
							</div>
							<div class="item">
								<a href="#"><img src="images/tm-170x80-2.jpg" alt=""></a>
							</div>
							<div class="item">
								<a href="#"><img src="images/tm-170x80-1.jpg" alt=""></a>
							</div>
							<div class="item">
								<a href="#"><img src="images/tm-170x80-2.jpg" alt=""></a>
							</div>
							<div class="item">
								<a href="#"><img src="images/tm-170x80-1.jpg" alt=""></a>
							</div>
							<div class="item">
								<a href="#"><img src="images/tm-170x80-2.jpg" alt=""></a>
							</div>
						</div>
						<!-- /#owl-demo -->
					</div>
					<!-- /.col-md-12 -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container -->
		</div>
		<!-- /.our-partner -->
		<div class="main-footer">
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<div class="footer-widget">
							<h3 class="widget-title">About Us</h3>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Eligendi, debitis recusandae.
							<ul class="follow-us">
								<li><a href="#"><i class="fa fa-facebook"></i>Facebook</a></li>
								<li><a href="#"><i class="fa fa-twitter"></i>Twitter</a></li>
							</ul>
							<!-- /.follow-us -->
						</div>
						<!-- /.footer-widget -->
					</div>
					<!-- /.col-md-3 -->
					<div class="col-md-3">
						<div class="footer-widget">
							<h3 class="widget-title">Why Choose Us?</h3>
							Kool Store is free responsive eCommerce template provided by
							templatemo website. You can use this layout for any website. <br>
							<br>Tempore cum mollitia eveniet laboriosam corporis
							voluptas earum voluptate. Lorem ipsum dolor sit amet. <br> <br>Credit
							goes to <a rel="nofollow" href="http://unsplash.com">Unsplash</a>
							for all images.
						</div>
						<!-- /.footer-widget -->
					</div>
					<!-- /.col-md-3 -->
					<div class="col-md-2">
						<div class="footer-widget">
							<h3 class="widget-title">Useful Links</h3>
							<ul>
								<li><a href="#">Our Shop</a></li>
								<li><a href="#">Partners</a></li>
								<li><a href="#">Gift Cards</a></li>
								<li><a href="#">About Us</a></li>
								<li><a href="#">Help</a></li>
							</ul>
						</div>
						<!-- /.footer-widget -->
					</div>
					<!-- /.col-md-2 -->
					<div class="col-md-4">
						<div class="footer-widget">
							<h3 class="widget-title">Our Newsletter</h3>
							<div class="newsletter">
								<form action="#" method="get">
									<p>Sign up for our regular updates to know when new
										products are released.</p>
									<input type="text" title="Email" name="email"
										placeholder="Your Email Here"> <input type="submit"
										class="s-button" value="Submit" name="Submit">
								</form>
							</div>
							<!-- /.newsletter -->
						</div>
						<!-- /.footer-widget -->
					</div>
					<!-- /.col-md-4 -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container -->
		</div>
		<!-- /.main-footer -->
		<div class="bottom-footer">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center">
						<span>Copyright &copy; 2084 <a href="#">Company Name</a> |
							Design: <a href="http://www.templatemo.com">templatemo</a></span>
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Accusantium, expedita soluta mollitia accusamus ut architecto
							maiores cum fugiat. Pariatur ipsum officiis fuga deleniti alias
							quia nostrum veritatis enim doloremque eligendi?</p>
					</div>
					<!-- /.col-md-12 -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container -->
		</div>
		<!-- /.bottom-footer -->
	</footer>
	<!-- /.site-footer -->


	<script src="js/vendor/jquery-1.10.1.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="js/vendor/jquery-1.10.1.min.js"><\/script>')
	</script>
	<script src="js/jquery.easing-1.3.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/plugins.js"></script>
	<script src="js/main.js"></script>


	<!-- Google Map -->
	<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
	<script src="js/vendor/jquery.gmap3.min.js"></script>

	<!-- Google Map Init-->
	<script type="text/javascript">
		jQuery(function($) {
			$('.first-map, .map-holder').gmap3({
				marker : {
					address : '40.7828839,-73.9652425'
				},
				map : {
					options : {
						zoom : 15,
						scrollwheel : false,
						streetViewControl : true
					}
				}
			});
		});
	</script>
	<script>
		function deleteFunction(a) {
			var answer = confirm("Delete data?");
			//var b = {Delete:"Delete", productCode:a};
			//var data = JSON.stringify(b);
			//alert(data);
			var data = "delete=Delete&productCode=" + a;
			if (answer) {
				//window.location.assign("EmployeeProductDetailsServlet?delete=Delete"+ "&productCode=" + a);
				$.post("EmployeeProductDetailsServlet", data).done(
						function(data) {
							alert(data);
							location.reload();
						});
			} else {

			}
		}
	</script>
	<script>
		$(function() {
			var deleteBox = '<span class="deleteBox"><p>Are you sure you want to delete?</p><span class="cancel">Cancel</span><span class="confirm">Yes</span></span>';
			$('.delete')
					.each(function() {
						$(this).append(deleteBox);
					})
					.click(
							function() {
								if (!$(this).hasClass('selected')) {
									$(this).addClass('selected');
									var owner = $(this);

									var a = $(this).val();

									$(this).find('.cancel').unbind('click')
											.bind('click', function() {
												owner.removeClass('selected');
												return false;
											})

									$(this)
											.find('.confirm')
											.unbind('click')
											.bind(
													'click',
													function() {
														$(this)
																.parent()
																.addClass(
																		'loading');
														var parent = $(this)
																.parent(); //parent is deletebox

														//ajax to delete

														var data = "delete=Delete&empNumber="
																+ a;
														$
																.post(
																		"AdminEmployeeDetailsServlet",
																		data)
																.done(
																		function(
																				data) {
																			setTimeout(
																					function() { //On success
																						parent
																								.attr(
																										"title",
																										data);
																						parent
																								.addClass('deleted');

																						setTimeout(
																								function() {
																									owner
																											.fadeOut(600);
																									location
																											.reload();
																									//remove item deleted

																									setTimeout(
																											function() {
																												owner
																														.find(
																																'.deleted')
																														.removeClass(
																																'loading')
																														.removeClass(
																																'deleted');
																												owner
																														.removeClass('selected');
																												owner
																														.show();

																											},
																											1000)
																								},
																								1000)
																					},
																					1000)
																		});

														return false;
													})

								}
								return false;
							});

		})
	</script>


</body>
</html>
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

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/templatemo-misc.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/templatemo-style.css">

<script src="${pageContext.request.contextPath}/js/vendor/modernizr-2.6.2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.easing-1.3.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>


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
	function confirmDeleteModal(id){
	    $('#deleteModal').modal();
		$('#deleteButton').html('<a class="btn btn-danger" onclick="deleteData('+id+')">Delete</a>');
	}     
	function deleteData(id){
	  // do your stuffs with id
	  $("#successMessage").html("Record With id "+id+" Deleted successfully!");
	  $('#deleteModal').modal('hide'); // now close modal
	}  
</script>
</head>
<body>
	<!--[if lt IE 7]>
    <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
    <![endif]-->
	<header>


	</header>
	<!-- /.site-header -->

	<div class="content-section" style="z-index: 1">
		<main class='container' role='main'>
		<h2 class="container"></h2>
		<div class='container' style="margin-top: 60px">
			<h2>Product list</h2>
			<div class='row'>
				<div class='col-xs-12'>
					<div class='orders-filter-container' role='tabpanel'>
						<ul class='nav nav-tabs' role='tablist'>
							<li class='active' role='presentation'><a href='#'
								role='tab'> Products </a></li>
						</ul>
						<div class='tab-content'>
							<div class='tab-pane active' id='search' role='tabpanel'>
								<button class="btn btn-primary" type="button"
									onclick="window.location.href='EmployeeProductDetailsServlet?createProduct=CREATEPRODUCT'"
									style="display: inline-block; margin-top: 10px; background-color: transparent; color: #428bca; border: 1px solid #ddd;">
									Add a new product</button>
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
							<thead>
								<tr>
									<th>Product Code</th>
									<th>Product Name</th>
									<th>Product Line</th>
									<th>Product Scale</th>
									<th>Product Vendor</th>
									<th>Product Description</th>
									<th>Quantity In Stock</th>
									<th>Buy Price</th>
									<th>MSRP</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>P123</td>
									<td>name</td>
									<td>Product Line</td>
									<td>Product Scale</td>
									<td>Product Vendor</td>
									<td>Product Description</td>
									<td>Quantity In Stock</td>
									<td>Buy Price</td>
									<td>MSRP</td>
									<td><button class="btn btn-primary delete" type="button"
											value="qwe" onclick="confirmDeleteModal('112')" 
											style="display: inline-block; background-color: transparent; color: #428bca; border: 1px solid #ddd; position: relative;">Delete</button></td>
								</tr>
							<tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
		</main>
	</div>
	<!-- /.content-section -->
	
	<!----modal starts here--->
	<div id="deleteModal" class="modal fade" role='dialog'>
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title">Delete </h4>
	            </div>
	            <div class="modal-body">
	                <p>Do You Really Want to Delete This ?</p>
	                
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<span id= 'deleteButton'></span>
	            </div>
				
	        </div>
	      </div>
	  </div>
	<!--Modal ends here--->
	
	<script>
		window.jQuery
				|| document
						.write('<script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.1.min.js"><\/script>')
	</script>

</body>
</html>
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
-->
<meta charset="utf-8">

<title>WAH SHOON ENTERPRISE</title>

<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<link
	href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/normalize.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/font-awesome.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/animate.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/templatemo-misc.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/templatemo-style.css">

<script
	src="${pageContext.request.contextPath}/js/vendor/modernizr-2.6.2.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.easing-1.3.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>


<style>
.pagination ul > .active {
	background-color: #f5f5f5;
}
.pagination ul > li {
    display: inline;
    float: left;
    padding: 4px 12px;
    line-height: 20px;
    text-decoration: none;
    background-color: #ffffff;
    border: 1px solid #dddddd;
}
.pagination ul > li:hover{
	background-color: #f5f5f5;
}

.pagination ul > li > a{
 	display: block;
  	width: 100%;
}


</style>

<script>
var storedCurrentpage = 1;
	$(document).ready(function(){
		displayPage(storedCurrentpage);
		$("#createProductForm").submit(function( event ) {
			event.preventDefault();
			var parameter = $('#createProductForm').serialize();
			var spinner = $('#loader');
			spinner.show();
			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/product/createProduct",
				cache : false,
				data: parameter,
				success: function(data){
					spinner.hide();
					displayPage(storedCurrentpage);
					$('#createProductModel').modal('hide');
				},
				error : function(jgXHR){
					spinner.hide();
					alert(jgXHR.responseText);
				}
			}).done(function(){spinner.hide();});
			
		});
	});

	function deleteFunction(a) {
		var answer = confirm("Delete data?");
		//var b = {Delete:"Delete", productCode:a};
		//var data = JSON.stringify(b);
		//alert(data);
		var data = "delete=Delete&productCode=" + a;
		if (answer) {
			//window.location.assign("EmployeeProductDetailsServlet?delete=Delete"+ "&productCode=" + a);
			$.post("EmployeeProductDetailsServlet", data).done(function(data) {
				alert(data);
				location.reload();
			});
		} else {

		}
	}
	function confirmDeleteModal(productNumber) {
		$('#deleteModal').modal();
		$('#deleteButton').html(
				'<a class="btn btn-danger" onclick="deleteData(' + productNumber + ')">Delete</a>');
	}
	function deleteData(productNumber) {
		// do your stuffs with id
		var spinner = $('#loader');
		spinner.show();
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/product/deleteProduct?productNumber="+productNumber,
			success : function(data) {
				displayPage(storedCurrentpage);
			},
			error : function(jgXHR) {
				spinner.hide();
				alert(jgXHR.responseText);
			}
		}).done(function(){
			spinner.hide();
			$('#deleteModal').modal('hide'); // now close modal
		});
	}

	function viewModal(productNumber) {
		$('#viewModal').modal();
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/product/getProduct?productNumber="+productNumber,
			dataType : 'json',
			success : function(data) {
				$('#product_number').val(data.productNumber);
				let date = new Date(data.date.year, data.date.monthValue-1, data.date.dayOfMonth+1);
				$('#product_date').val(date.toISOString().slice(0, 10));
				var tableBodyHtml = "";
				if (data.productDetail.length == 0) {
					tableBodyHtml += "<tr><td colspan='6' style='text-align: center;'>No Records Found</td></tr>";
				}
				var totalSum = 0.0;
				
				$.each(data.productDetail, function(index, item) {
					var isLastElement = index == data.productDetail.length -1;
					let desc = item.description == null? "": item.description;
					let totalPrice = item.type.directPrice == true? item.finalPrice * item.quantity : (item.finalPrice * Math.round(((item.width)/304.8) * 10) / 10);
					let width = item.type.directPrice == true? "-" : item.width;
					let height = item.type.directPrice == true? "-" : item.height;
					let ft = item.type.directPrice == true? "-" :  Math.round(((item.width)/304.8) * 10) / 10;
					let quantity = item.type.directPrice == true? item.quantity : '-';
					index += 1;
					tableBodyHtml += "<tr>"
							+ '<td>' + index + '</td>'
							+ '<td>' + item.type.desc_chinese + ' (' + item.type.desc_eng + ')</td>'
							+ '<td>' + width + '</td>'
							+ '<td>' + height  + '</td>'
							+ '<td>' + ft + '</td>'
							+ '<td>' + quantity + '</td>'
							+ '<td>' + item.finalPrice + '</td>'
							+ '<td>' + totalPrice + '</td>'
							+ '</tr>';
					totalSum += totalPrice;
							
					if(isLastElement){
						$('#createLineNumber').val(this.productLineNumber + 1);
						$('#createLineNumberShow').val(index+1);
						tableBodyHtml += "<tr>"
						+ '<td></td>'
						+ '<td></td>'
						+ '<td></td>'
						+ '<td></td>'
						+ '<td></td>'
						+ '<td></td>'
						+ '<td>Total</td>'
						+ '<td>'+ totalSum +'</td>'
						+ "<tr>";
					}
				});
				$('#quickViewProductDetailTableBody').html(tableBodyHtml);
				
			},
			error : function(jgXHR) {
				alert(jgXHR.responseText);
			},
		});
		
	}

	function displayPage(currentPage){
		storedCurrentpage = currentPage;
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/product/productListPag?currentPage="+storedCurrentpage+"&currentLimit=10",
			dataType : 'json',
			success : function(data) {
				var productList = data.result;
				renderTable(productList);
				displayLinks(data);
			},
			error : function(jgXHR) {
				alert(jgXHR.responseText);
			},
		});
	}

	function viewData(id) {
		// do your stuffs with id
		$("#successMessage").html(
				"Record With id " + id + " Deleted successfully!");
		$('#deleteModal').modal('hide'); // now close modal
	}

	function renderTable(data) {
		var tableBodyHtml = "";
		if (data.length == 0) {
			tableBodyHtml += "<tr><td colspan='6' style='text-align: center;'>No Records Found</td></tr>";
		}
		$.each(data, function() {
			var totalPrice = 0;
			var productDetailList = this.productDetail;
			$.each(productDetailList, function(index, pd) {
				totalPrice +=  pd.type.directPrice == true? pd.finalPrice * pd.quantity : (pd.finalPrice * Math.round(((pd.width)/304.8) * 10) / 10);
			});
			tableBodyHtml += '<tr>'
					+ '<td><a href="${pageContext.request.contextPath}/product/productDetail.html?productNumber='+ this.productNumber +'">'+ this.productNumber + "</a></td>"
					+ '<td>'
					+ this.date.dayOfMonth + ' ' +this.date.month + ' ' + this.date.year
					+ '</td>'
					+ '<td>'
					+ 'RM' + totalPrice
					+ '</td>'
					+ '<td>'
					+ '<button class="btn btn-primary btn-sm" type="button" value="qwe" onclick="viewModal('+this.productNumber+')">View</button>'
					+ '<button class="btn btn-danger btn-sm" type="button" value="qwe" onclick="confirmDeleteModal('+this.productNumber+')">Delete</button>'
					+ '<a class="btn btn-info btn-sm" type="button" target="_blank" href="${pageContext.request.contextPath}/product/generateProductDetailReport.do?productNumber='+this.productNumber+'">Print</a>'
					+ '</td>' + '</tr>';
		});
		$('#productTableBody').html(tableBodyHtml);
	}

	function createProductModal(){
		$('#createProductNumber').val("");
		$('#createProductDate').val(new Date().toISOString().substring(0, 10));
		$('#createProductModel').modal();
	}
	
	function displayLinks(data, element) {
		var targetElement = '';
		//default target element if no element is given.
		if(element == null){
			targetElement = '.pagination ul';
		}else{
			targetElement = element;
		}
		
		var totalResult = parseInt(data.totalResult);
		var limit = parseInt(data.currentLimit);
		var totalPage = parseInt(totalResult / limit);
		var balance = totalResult % limit;
		var currentPage = parseInt(data.currentPage);
		storedCurrentpage = currentPage;
		
		totalPage = (balance != 0)  ? totalPage + 1 : totalPage;

		var different = 5;
		var firstLink = parseInt(parseInt(currentPage) - different);
		var lastLink = parseInt(parseInt(currentPage) + different);

		lastLink = (currentPage < different) ? lastLink + (different - parseInt(currentPage)) : lastLink;
		
		firstLink = (currentPage > (totalPage - different)) ? currentPage - parseInt(((different * 2) - (totalPage - currentPage))) : firstLink; 
		firstLink = (firstLink < 1) ? 1 : firstLink;
		lastLink = (lastLink > totalPage) ? totalPage : lastLink; 
		var nextPage = currentPage + 1;
		var previousPage = currentPage - 1;
		nextPage = (nextPage >= lastLink) ? lastLink : nextPage;
		previousPage = (previousPage <= 1) ? 1 : previousPage;
		
		var paginationHtml = "";
		
		if(currentPage > 1){
			paginationHtml += "<li><a href=\"javascript:displayPage("+previousPage+")\">&larr;</a></li>";
		}else{
			paginationHtml += '<li class="disabled"><a>&larr;</a></li>';
		}
		var debugVariable = ('total result: '+totalResult+'\nlimit: '+limit+'\ntotal page: '
				+totalPage+'\nremainder: '+balance+'\ncurrent page: '+currentPage+'\nfirst link: '
				+firstLink+'\nlast link: '+lastLink+'\nnext page: '+nextPage+'\nprevious page:'
				+previousPage+'\Generated html: '+paginationHtml);	
		//alert(debugVariable);
		for ( var i = firstLink; i <= lastLink; i++) {		
			var paginationLink = '';
			if (currentPage == i) {
				paginationHtml += "<li class=\"active\"><a>"+i+"</a>";
			} else {
				paginationHtml += "<li>";
				paginationLink = "<a href=\"javascript:displayPage(" +i+ ")\">" + i + "</a>";
			}
			paginationHtml += paginationLink;
			paginationHtml += "</li>";
		}
		if(currentPage < lastLink){
			paginationHtml += "<li><a href=\"javascript:displayPage("+nextPage+")\">&rarr;</a></li>";
		}else{
			paginationHtml += '<li class="disabled"><a>&rarr;</a></li>';
		}
		if(totalPage > 1){
			$(targetElement).html(paginationHtml);
			$(targetElement).show();
		}else{
			$(targetElement).html("");
			$(targetElement).hide();
		}		

	}

</script>
</head>
<body>
	<!--[if lt IE 7]>
    <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
    <![endif]-->
	<header> </header>
	<!-- /.site-header -->

	<div class="content-section" style="z-index: 1">
		<main class='container' role='main'>
			<h2></h2>
			<div>
				<h2>Order list</h2>
				<div class='row'>
					<div class='col-xs-12'>
						<div class='orders-filter-container' role='tabpanel'>
							<ul class='nav nav-tabs' role='tablist'>
								<li class='active' role='presentation'><a href='#'
									role='tab'> Orders </a></li>
							</ul>
							<div class='tab-content'>
								<div class='tab-pane active' id='search' role='tabpanel'>
									<button class="btn btn-primary" type="button"
										onclick=createProductModal()
										style="display: inline-block; margin-top: 10px; background-color: transparent; color: #428bca; border: 1px solid #ddd;">
										Add a new order</button>
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
										<th>Order Number</th>
										<th>Date</th>
										<th>Total Price</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody id='productTableBody'>
									<!-- 								<tr>
									<td>P123</td>
									<td>March</td>
									<td>1</td>
									<td>RM20</td>
									<td>1200</td>
									<td>900</td>
									<td><button class="btn btn-danger delete" type="button"
											value="qwe" onclick="confirmDeleteModal('112')" 
											>Delete</button></td>
								</tr> -->
								<tbody>
							</table>
						</div>
					</div>
					<div class='col-xs-12 pagination'><ul></ul></div>
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
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">Delete</h4>
				</div>
				<div class="modal-body">
					<p>Do You Really Want to Delete This ?</p>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<span id='deleteButton'></span>
				</div>

			</div>
		</div>
	</div>

	<div class="modal fade" id="viewModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header border-bottom-0">
					<h5 class="modal-title" id="exampleModalLabel">View Order</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form>
					<div class="modal-body" style="overflow:auto;">
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="email1">Order Number</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="product_number" name="product_number" value=10001 readonly>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="email1">Date</label>
							<div class="col-sm-9">
								<input type="date" class="form-control" id="product_date" name="product_date" style='width:60%;' readonly>
							</div>
						</div>
						<div class='row attribute-row' style="margin-bottom: 10px;">
						<div class='col-xs-12' title='Order Details:'>
							<div style="display: inline-block;" class='value'>
								<div class='col-xs-12'>
									<div class='table-responsive orders-list'>
										<table id="table" class='table table-striped table-hover'>
											<thead>
												<tr>
													<th>Line number</th>
													<th>Type</th>
													<th>Width</th>
													<th>Height</th>
													<th>Ft</th>
													<th>Quantity</th>
													<th>Price</th>
													<th>Total price</th>
												</tr>
											</thead>
											<tbody id="quickViewProductDetailTableBody">
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
					
					<!-- <div
						class="modal-footer border-top-0 d-flex justify-content-center">
						<button type="submit" class="btn btn-success">Submit</button>
					</div> -->
				</form>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="createProductModel" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header border-bottom-0">
					<h3 class="modal-title" id="exampleModalLabel">Create Order</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="createProductForm">
					<div class="modal-body">
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="email1">Order Number</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="createProductNumber" name="createProductNumber" value="" required>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="email1">Date</label>
							<div class="col-sm-9">
								<input type="date" class="form-control" id="createProductDate" name="createProductDate" value="" required>
							</div>
						</div>
					</div>
					<div
						class="modal-footer border-top-0 d-flex justify-content-center">
						<button type="submit" class="btn btn-success">Submit</button>
					</div>
				</form>
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
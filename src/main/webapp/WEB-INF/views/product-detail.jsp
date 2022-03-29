<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html class="no-js hbw-styles">
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

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/templatemo-misc.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/templatemo-style.css">

<script src="${pageContext.request.contextPath}/js/vendor/modernizr-2.6.2.min.js"></script>
<script src="${pageContext.request.contextPath}/js/vendor/jquery-1.10.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.easing-1.3.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>


<style>
#loader {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  width: 100%;
  background: rgba(0,0,0,0.75) url(${pageContext.request.contextPath}/images/loading.gif) no-repeat center center;
  z-index: 10000;
  background-size: 50px 50px
}

.attribute-row {
	font-weight: bold;
}

.attribute-row .value {
	font-weight: normal;
}

#table th {
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	font-weight: bold;
	color: #777777;
}

/* #table th, #table tr {
	border: 1px solid #ddd;
}
 */
.container>h2 {
	font-family: "Open Sans", Arial, sans-serif;
	font-weight: 700;
}
</style>

</head>
<script type="text/javascript">
const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
$(document).ready(function(){
	$.ajax({
	    type: "GET",
	    url: "getInstallTypeList",
	    dataType: 'json',
	    success: function(data) {
	        var $el = $("#type");
	        var $createEl = $("#createType");
	        $el.empty();
	        //console.log("data >> " + JSON.stringify(data));
	        $.each(data, function() {
		        let desc_chinese = this.desc_chinese == null ? '' : this.desc_chinese;
		        let desc_eng = this.desc_eng == null ? '' : this.desc_eng;
	            $el.append($("<option></option>").attr("value", this.id).html(desc_chinese+" ("+desc_eng+")"));
	            $createEl.append($("<option></option>").attr("value", this.id).html(desc_chinese+" ("+desc_eng+")"));
	        });

	    	$('#createType').change(function(){
	    		var changedValue = this.value;
	    		for(let i = 0; i < data.length; i++){
					if(data[i].id == changedValue){
						if(data[i].diff_price == true){
							var heightValue = $('#createHeight').val() == ""? 0 : $('#createHeight').val();
							$.ajax({
				    			type : "GET",
				    			url : "getInstallTypeDiffPrice?type="+data[i].id+"&height="+heightValue,
				    			success : function(data) {
				    				$('#createPrice').val(data);
				    			},
				    			error : function(jgXHR) {
				    				alert(jgXHR.responseText);
				    			}
				    		});
						}else
							$('#createPrice').val(data[i].price);
						break;
					}
		    	}
	    	});

	    	$('#type').change(function(){
	    		var changedValue = this.value;
	    		for(let i = 0; i < data.length; i++){
					if(data[i].id == changedValue){
						if(data[i].diff_price == true){
							var heightValue = $('#height').val() == ""? 0 : $('#height').val();
							$.ajax({
				    			type : "GET",
				    			url : "getInstallTypeDiffPrice?type="+data[i].id+"&height="+heightValue,
				    			success : function(data) {
				    				$('#price').val(data);
				    			},
				    			error : function(jgXHR) {
				    				alert(jgXHR.responseText);
				    			}
				    		});
						}else
							$('#price').val(data[i].price);
						break;
					}
		    	}
	    	});

	    	$('#createHeight').change(function(){
	    		var typeValue = $('#createType').val();
	    		for(let i = 0; i < data.length; i++){
					if(data[i].id == typeValue){
						typeValue = data[i];
						break;
					}
		    	}
		    	if(typeValue.diff_price == true){
		    		$.ajax({
		    			type : "GET",
		    			url : "getInstallTypeDiffPrice?type="+typeValue.id+"&height="+this.value,
		    			success : function(data) {
		    				$('#createPrice').val(data);
		    			},
		    			error : function(jgXHR) {
		    				alert(jgXHR.responseText);
		    			}
		    		});
			    }
	    	});

			$('#height').change(function(){
	    		var typeValue = $('#type').val();
	    		for(let i = 0; i < data.length; i++){
					if(data[i].id == typeValue){
						typeValue = data[i];
						break;
					}
		    	}
		    	if(typeValue.diff_price == true){
		    		$.ajax({
		    			type : "GET",
		    			url : "getInstallTypeDiffPrice?type="+typeValue.id+"&height="+this.value,
		    			success : function(data) {
		    				$('#price').val(data);
		    			},
		    			error : function(jgXHR) {
		    				alert(jgXHR.responseText);
		    			}
		    		});
			    }
	    	});
	    }
	});



	
	
	rendertable();

	$("#productDetailForm").submit(function( event ) {
		event.preventDefault();
		var parameter = $('#productDetailForm').serialize();
		var spinner = $('#loader');
		spinner.show();
		$.ajax({
			type: "POST",
			url: "updateProductDetail?productNumber="+ urlParams.get('productNumber'),
			cache : false,
			data: parameter,
			success: function(data){
				spinner.hide();
				rendertable();
				$('#editModal').modal('hide');
			},
			error : function(data){
				spinner.hide();
				alert(jgXHR.responseText);
			}
		}).done(function(){spinner.hide();});
		
	});

	$("#productForm").submit(function( event ) {
		event.preventDefault();
		var parameter = $('#productForm').serialize();
		var spinner = $('#loader');
		spinner.show();
		$.ajax({
			type: "POST",
			url: "updateProduct",
			cache : false,
			data: parameter,
			success: function(data){
				spinner.hide();
				rendertable();
			},
			error : function(data){
				spinner.hide();
				alert(jgXHR.responseText);
			}
		}).done(function(){spinner.hide();});
		
	});

	$("#createProductDetailForm").submit(function( event ) {
		event.preventDefault();
		var parameter = $('#createProductDetailForm').serialize();
		var spinner = $('#loader');
		spinner.show();
		$.ajax({
			type: "POST",
			url: "createProductDetail?productNumber=" + urlParams.get('productNumber'),
			cache : false,
			data: parameter,
			success: function(data){
				spinner.hide();
				rendertable();
				$('#createProductDetailModal').modal('hide');
			},
			error : function(data){
				spinner.hide();
				alert(jgXHR.responseText);
			}
		}).done(function(){spinner.hide();});
		
	});

	
});

function rendertable(){
	$.ajax({
		type : "GET",
		url : "getProduct?productNumber="+urlParams.get('productNumber'),
		dataType : 'json',
		success : function(data) {
			$('#productNumber').val(data.productNumber);
			let date = new Date(data.date.year, data.date.monthValue-1, data.date.dayOfMonth+1);
			$('#productDate').val(date.toISOString().slice(0, 10));
			var tableBodyHtml = "";
			if (data.productDetail.length == 0) {
				tableBodyHtml += "<tr><td colspan='6' style='text-align: center;'>No Records Found</td></tr>";
				$('#createLineNumberShow').val("1");
				$('#createLineNumber').val("1");
			}
			var totalSum = 0.0;
			$.each(data.productDetail, function(index, item) {
				var isLastElement = index == data.productDetail.length -1;
				index += 1;
				tableBodyHtml += "<tr>"
						+ '<td>' + index + '</td>'
						+ '<td>' + item.type.desc_chinese + ' (' + item.type.desc_eng + ')</td>'
						+ '<td>' + item.width + '</td>'
						+ '<td>' + Math.round(((item.width)/304.8) * 10) / 10  + '</td>'
						+ '<td>' + item.height + '</td>'
						+ '<td>' + item.finalPrice + '</td>'
						+ '<td>' + (item.finalPrice * Math.round(((item.width)/304.8) * 10) / 10) + '</td>'
						+ '<td>'
						+ '<button class="btn btn-primary btn-sm" type="button" value="qwe" onclick="editProductDetail('+this.productNumber+','+ this.productLineNumber+','+index+')">Edit</button>'
						+ '<button class="btn btn-danger btn-sm" type="button" value="qwe" onclick="confirmDeleteModal('+this.productNumber+','+this.productLineNumber+')">Delete</button>'
						+ '</td>'
						+ '</tr>';
				totalSum += (item.finalPrice * Math.round(((item.width)/304.8) * 10) / 10);
						
				if(isLastElement){
					$('#createLineNumber').val(this.productLineNumber + 1);
					$('#createLineNumberShow').val(index+1);
					tableBodyHtml += "<tr>"
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
			$('#ProductDetailTableBody').html(tableBodyHtml);
			
		},
		error : function(jgXHR) {
			alert(jgXHR.responseText);
		},
	});
}

function editProductDetail(productNumber, lineNumber, index){
	$('#editModal').modal();
	$.ajax({
		type : "GET",
		url : "getProductDetail?productNumber="+productNumber+"&lineNumber="+lineNumber,
		dataType : 'json',
		success : function(data) {
			$('#lineNumberShow').val(index);
			$('#lineNumber').val(lineNumber);
			$('#type').val(data.type.id);
			$('#width').val(data.width);
			$('#height').val(data.height);
			$('#price').val(data.finalPrice);
		},
		error : function(jgXHR) {
			alert(jgXHR.responseText);
		}
	});
}

function createProductDetail(){
	$('#lineNumberShow').val("");
	$('#createType').val("");
	$('#createWidth').val("");
	$('#createHeight').val("");
	$('#createPrice').val("");
	$('#createProductDetailModal').modal();
}

function confirmDeleteModal(productNumber, lineNumber) {
	$('#deleteModal').modal();
	$('#deleteButton').html(
			'<a class="btn btn-danger" onclick="deleteData('+productNumber+','+ lineNumber +')">Delete</a>');
}
function deleteData(productNumber, lineNumber) {
	// do your stuffs with id
	var spinner = $('#loader');
	spinner.show();
	$.ajax({
		type : "GET",
		url : "deleteProductDetail?productNumber="+productNumber+"&lineNumber="+lineNumber,
		success : function(data) {
			rendertable();
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
</script>

<body class='hbw-select2'>
	<!--[if lt IE 7]>
    <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
    <![endif]-->

	<header class="site-header">
	</header>
	<!-- /.site-header -->
	<main class='container' role='main'>
		<div class='container'>
			<div>
				<form action="${pageContext.request.contextPath}/product/product.html" method="post">
				    <button  class="btn btn-info" type="submit" name="your_name" value="your_value" class="btn-link">Back</button>
				</form>
<%-- 				<a class="btn btn-info" style="margin-top: 10px" type="button" href="${pageContext.request.contextPath}/product/product.html">Back</a>
 --%>				<h2>Order Details</h2>
			</div>
			<div class='row'>
				<div class='col-xs-12'>
					<div id='hbw-bp-control-buttons-container'></div>
					<div class='row'>
						<div class='col-xs-6'>
							<form class="simple_form form-horizontal productForm "
								id="productForm" accept-charset="UTF-8" method="post">
								<div class="form-group row string optional">
									<label class="string optional col-sm-4 control-label">Order
										Number</label>
									<div class="col-sm-8">
										<input value="" class="string optional form-control"
											type="text" name="productNumber" id="productNumber" readonly>
									</div>
								</div>
								<div class="form-group row string optional">
									<label class="string optional col-sm-4 control-label">Date</label>
									<div class="col-sm-8">
										<input value="" class="string optional form-control"
											type="date" name="productDate" id="productDate">
									</div>
								</div>
								<div class="form-group row string optional">
									<!-- <a class="btn btn-primary pull-right btn-sm" type="button" style="margin-left: 5px" href="product.html">Back</a> -->
									<input type="submit" class="btn btn-primary pull-right btn-sm"
										value="Edit">
								</div>
							</form>
						</div>
						<div class='col-xs-6'>
								<FORM NAME="Calc" onsubmit="return false;">
									<TABLE BORDER=4>
										<TR>
											<TD><INPUT TYPE="text" NAME="Input" Size="16"
												style="width: auto;"> <br></TD>
										</TR>
										<TR>
											<TD><INPUT TYPE="button" NAME="one" VALUE="  1  "
												OnClick="Calc.Input.value += '1'"> <INPUT
												TYPE="button" NAME="two" VALUE="  2  "
												OnCLick="Calc.Input.value += '2'"> <INPUT
												TYPE="button" NAME="three" VALUE="  3  "
												OnClick="Calc.Input.value += '3'"> <INPUT
												TYPE="button" NAME="plus" VALUE="  +  "
												OnClick="Calc.Input.value += ' + '"> <br> <INPUT
												TYPE="button" NAME="four" VALUE="  4  "
												OnClick="Calc.Input.value += '4'"> <INPUT
												TYPE="button" NAME="five" VALUE="  5  "
												OnCLick="Calc.Input.value += '5'"> <INPUT
												TYPE="button" NAME="six" VALUE="  6  "
												OnClick="Calc.Input.value += '6'"> <INPUT
												TYPE="button" NAME="minus" VALUE="  -  "
												OnClick="Calc.Input.value += ' - '"> <br> <INPUT
												TYPE="button" NAME="seven" VALUE="  7  "
												OnClick="Calc.Input.value += '7'"> <INPUT
												TYPE="button" NAME="eight" VALUE="  8  "
												OnCLick="Calc.Input.value += '8'"> <INPUT
												TYPE="button" NAME="nine" VALUE="  9  "
												OnClick="Calc.Input.value += '9'"> <INPUT
												TYPE="button" NAME="times" VALUE="  x  "
												OnClick="Calc.Input.value += ' * '"> <br> <INPUT
												TYPE="button" NAME="clear" VALUE="  c  "
												OnClick="Calc.Input.value = ''"> <INPUT
												TYPE="button" NAME="zero" VALUE="  0  "
												OnClick="Calc.Input.value += '0'"> <INPUT
												TYPE="button" NAME="DoIt" VALUE="  =  "
												OnClick="Calc.Input.value = eval(Calc.Input.value)">
												<INPUT TYPE="button" NAME="div" VALUE="  /  "
												OnClick="Calc.Input.value += ' / '"> <br></TD>
										</TR>
									</TABLE>
								</FORM>
						</div>
						<div class='col-xs-12'>
							<div class='row attribute-row' style="margin-bottom: 10px;">
								<div class='col-xs-12' title='Order Details:'>
									<div class='value'>
										<div class='col-xs-12'>
											<button class="btn btn-primary" onclick=createProductDetail()>Add
												service</button>
											<div style="padding-bottom: 10px"></div>
										</div>
										<div class='col-xs-12'>
											<div class='table-responsive orders-list'>
												<table id="table" class='table table-striped table-hover'>
													<thead>
														<tr>
															<th>Line number</th>
															<th>Type</th>
															<th>Width</th>
															<th>FT</th>
															<th>Height</th>
															<th>Price per service</th>
															<th>Total price</th>
															<th>Actions</th>
														</tr>
													</thead>
													<tbody id="ProductDetailTableBody">
														<tr>
															<td>1</td>
															<th>Wall unit</th>
															<th>1000</th>
															<th>2000</th>
															<th>30</th>
															<th>30000</th>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	
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
	
	

	<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header border-bottom-0">
					<h5 class="modal-title" id="exampleModalLabel">Order details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="productDetailForm">
					<div class="modal-body">
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="email1">Line Number</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="lineNumberShow" name="lineNumberShow" value="" readonly disabled>
								<input type="hidden" class="form-control" id="lineNumber" name="lineNumber" value="" readonly>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="type">Type</label>
							<div class="col-sm-9">
								<select id="type" name="type" 
											data-placeholder="type"
											class="form-control order_state-picker" form="productDetailForm" required>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="width">Width</label>
							<div class="col-sm-9">
								<input type="number" class="form-control" id="width" name="width" value="" min="1" step="0.01" required>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="height">Height</label>
							<div class="col-sm-9">
								<input type="number" class="form-control" id="height" name="height" value="" min="1" step="0.01" required>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="price">Price per service</label>
							<div class="col-sm-9">
								<input type="number" class="form-control" id="price" name="price" value="" min="1" step="0.01" required>
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
	
	<div class="modal fade" id="createProductDetailModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header border-bottom-0">
					<h3 class="modal-title" id="exampleModalLabel">Create order details</h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="createProductDetailForm">
					<div class="modal-body">
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="email1">Line Number</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="createLineNumberShow" name="createLineNumberShow" value="" readonly disabled>
								<input type="hidden" class="form-control" id="createLineNumber" name="createLineNumber" value="">
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="createType">Type</label>
							<div class="col-sm-9">
								<select id="createType" name="createType" 
											data-placeholder="createType"
											class="form-control order_state-picker" form="createProductDetailForm" required>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="createWidth">Width</label>
							<div class="col-sm-9">
								<input type="number" class="form-control" id="createWidth" name="createWidth" value="" min="1" step="1" required>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="createHeight">Height</label>
							<div class="col-sm-9">
								<input type="number" class="form-control" id="createHeight" name="createHeight" value="" min="1" step="1" required>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-sm-3 col-form-label" for="createPrice">Price per service</label>
							<div class="col-sm-9">
								<input type="number" class="form-control" id="createPrice" name="createPrice" value="" min="1" step="1" required>
							</div>
						</div>
						
					</div>
					<div
						class="modal-footer border-top-0 d-flex justify-content-center">
						<button type="submit" class="btn btn-success">Create</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div id="loader"></div>


	
	<script>
		window.jQuery
				|| document
						.write('<script src="js/vendor/jquery-1.10.1.min.js"><\/script>')
	</script>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="windows-1256">
<title>Add Book</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script type="text/javascript" src="/js/app.js"></script>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/main.css" />
<!-- For any Bootstrap that uses JS or jQuery-->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">
		<c:if test="${success != null}">
			<div class="alert alert-success" role="alert">
				<c:out value="${success}" />
			</div>
		</c:if>
	</div>
	<div class="d-flex justify-content-center m-4 container">
		<div class="align-items-center">
			<div class="row ml-5 mt-1 ">
				<div class="span6">
					<div class="row ml-5 mt-2 mr-3 ">
					<div class="d-flex justify-content-between">
						<h1><c:out value="${event.name}"></c:out></h1>
						<form class="form align-items-right ml-4 mt-2" action="/dashboard" method="GET">
							<button type="submit" class="btn btn-link text-right">Go to Dashboard</button>
						</form>
						</div>
						<!-- ----------------------------------------------------------- -->
						<form:form  class="form align-items-center mt-4 ml-3" action="/process/${eventId}" method="POST" 
						modelAttribute="event">							
						<div class="row mb-3">
						<input type="hidden" value="PUT" name="_method">
						
							 <form:label class="form-label" path="name">Name:</form:label>
								<div class="col-12">
									<form:input type="text" path="name" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="name"/>
								</div>
							</div>	
							
							
							<div class="row mb-3">
							 <form:label class="form-label" path="eventdate">Date:</form:label>
								<div class="col-12">
									<form:input type="date" path="eventdate" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="eventdate"/>
								</div>
							</div>	
							
							
							<div class="row mb-3">
							 <form:label class="form-label" path="location">Location:</form:label>
								<div class="col-12">
									<form:input type="text" path="location" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="location"/>
								</div>
							</div>	
								
							<div class="mb-3">
							<form:select class="form-select" path="state"
								aria-label="Default select example">
									<form:option value="NY">NY</form:option>
									<form:option value="CU">CU</form:option>
									<form:option value="CU">WA</form:option>
									<form:option value="CU">MN</form:option>
									<form:option value="CU">IL</form:option>
							</form:select>
							<form:errors cssClass="invalid-feedback" path="state" />
						</div>
							
							<div class="row mb-3">
								<div class="col-12">
									<button class="btn btn-large btn-dark" type="submit">Edit</button>
								</div>
							</div>

						</form:form>

					</div>

				</div>

			</div>
		</div>
	</div>
</body>
</html>
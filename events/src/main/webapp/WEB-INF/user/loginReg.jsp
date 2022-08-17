<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login and Registration</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
  <script type="text/javascript" src="/js/app.js"></script>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/css/main.css"/>
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
   <div class="d-flex justify-content-center container">
		<div class="align-items-center">
			<div class="row ml-5 mt-1 ">
				<div class="span6">
					<div class="row ml-5 mt-2 mr-3 ">
						<h1 class="head">WELCOME</h1>
						<!------------------------- REGISTRATION ------------------------------------ -->
						<h1 class="mt-4">Registration</h1>
						<form:form  class="form align-items-center mt-4" action="/register" method="POST" modelAttribute="newUser">
						<div class="row mb-3">
							 <form:label class="form-label" path="firstName">First Name:</form:label>
								<div class="col-12">
									<form:input type="text" path="firstName" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="firstName"/>
								</div>
							</div>	
							
							<div class="row mb-3">
							 <form:label class="form-label" path="lastName">Last Name:</form:label>
								<div class="col-12">
									<form:input type="text" path="lastName" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="lastName"/>
								</div>
							</div>	
						
							
							<div class="row mb-3">
							 <form:label class="form-label" path="email">Email:</form:label>
								<div class="col-12">
									<form:input type="text" path="email" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="email"/>
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
									<form:option value="WA">WA</form:option>
									<form:option value="MN">MN</form:option>
									<form:option value="IL">IL</form:option>
							</form:select>
							<form:errors cssClass="invalid-feedback" path="state" />
						</div>
						
							
							<div class="row mb-3">
							 <form:label class="form-label" path="password">Password:</form:label>
								<div class="col-12">
									<form:input type="text"  path="password" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="password"/>
								</div>
							</div>
							
							<div class="row mb-3">
							 <form:label class="form-label" path="confirm">Confirm Password:</form:label>
								<div class="col-12">
									<form:input type="text" path="confirm" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="confirm"/>
								</div>
							</div>

							<div class="row mb-3">
								<div class="col-12">
									<button class="btn btn-large btn-dark" type="submit">Register</button>
								</div>
							</div>

						</form:form>

					</div>

				</div>
				<!---------------------------- LOGIN ------------------------------- -->
				<h1>Login</h1>
						<form:form  class="form align-items-center mt-4" action="/login" method="POST" modelAttribute="newLogin">
							<div class="row mb-3">
							 <form:label class="form-label" path="email">Email:</form:label>
								<div class="col-12">
									<form:input type="text" path="email" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="email"/>
								</div>
							</div>		
							
							
							<div class="row mb-3">
							 <form:label class="form-label" path="password">Password:</form:label>
								<div class="col-12">
									<form:input type="text"  path="password" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
									<form:errors cssClass="invalid-feedback" path="password"/>
								</div>
							</div>
							
							<div class="row mb-3">
								<div class="col-12">
									<button class="btn btn-large btn-dark" type="submit">login</button>
								</div>
							</div>
						</form:form>
			</div>
		</div>
	</div>
</body>
</html>


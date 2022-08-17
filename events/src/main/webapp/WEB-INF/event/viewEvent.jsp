<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="windows-1256">
<title>Event Details</title>
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
	<div class="d-flex justify-content-center container">
		<div class="align-items-center">
			<div class="row ml-5 mt-1 ">
				<div class="span6">
					<div class="row ml-5 mt-2 mr-3 ">
						<h1 class="form-heading mb-5 mr-3">
							<c:out value="${event.name}"></c:out>
						</h1>

						<!-- ----------------------------------------------------------- -->
						<div class="row mb-3">
							<h4>
								Host:
								<c:out value="${event.createdByName}" />
							</h4>
						</div>

						<div class="row mb-3">
							<h4>
								Date:
								<c:out value="${event.eventdate}" />
							</h4>
						</div>

						<div class="row mb-3">
							<h4>
								Location:
								<c:out value="${event.location}" />
							</h4>
						</div>

						<div class="row mb-3">
							<h4>
								People who are attending this event:
								<c:out value="${num}" />
							</h4>
						</div>

						<!-- -------------------------------- -->
						<c:if test="${! empty eventList }">
						<table class="table table-hover display nowrap mt-4">
							<thead>
								<tr>
									<th colspan="1">Name</th>
									<th colspan="1">Location</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${eventList}">
									<tr>
										<td colspan="1"><c:out value="${item.firstName}" /> <c:out
												value="${item.lastName}" /></td>
										<td colspan="1"><c:out value="${item.location}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>						
						</c:if>						
						<!-- -------------------------------- -->
						<div class="form-group">
						<label class="header head">Messages Wall</label>
							<div class="form-control scroll">
							
								<c:forEach items="${commtnts}" var="item">
									<p>
							<c:out value="${item.user.firstName}" /> <c:out value="${item.user.lastName}" /> :: <c:out value="${item.commentString}" />
							<hr>		
									</p>
								</c:forEach>
							</div>
						</div>
						<!-- -------------------------------- -->
						<div class="row mb-3">
							<form:form class="form align-items-center mt-4 ml-3"
								action="/comment/${event.id}" method="POST"
								modelAttribute="comment">

								<div class="row mb-3">
									<form:label class="form-label" path="commentString">Add Comment:</form:label>
									<div class="col-12">
										<form:input type="text" path="commentString"
											cssClass="form-control"
											cssErrorClass="form-control is-invalid" />
										<form:errors cssClass="invalid-feedback" path="commentString" />
									</div>
								</div>
								<form:input type="hidden" path="user" value="${id}" />
								<form:input type="hidden" path="event" value="${event.id}" />
								<div class="row mb-3">
									<div class="col-12">
										<button class="btn btn-large btn-dark" type="submit">Submit</button>
									</div>
								</div>
							</form:form>
						</div>
						<!-- -------------------------------------------------------- -->
						<form class="form align-items-right ml-4 mt-5" action="/dashboard"
							method="GET">
							<button type="submit" class="btn btn-link text-right">Go
								to Dashboard</button>
						</form>

					</div>

				</div>

			</div>
		</div>
	</div>
</body>
</html>
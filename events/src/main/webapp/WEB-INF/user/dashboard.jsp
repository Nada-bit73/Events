<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
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
		<div class="row mt-5">
			<div class="span6">
				<div class="d-flex justify-content-between">
					<h1 class="head">
						Welcome ,
						<c:out value="${userFirstName}" />
						!
					</h1>
					<p class="ml-4 mt-2">
						<a href="/logout">Logout</a>
					</p>
				</div>

				<div class="d-flex justify-content-between mt-3">
					<p>
						<a href="/add">Add Event</a>
					</p>
				</div>
				<div class="justify-content-center container ml-4">
					<div class="row mt-4">
						<p>Here are some of the events in your state:</p>
						<table class="table table-hover display nowrap mt-4">
							<thead>
								<tr>
									<th colspan="1">Name</th>
									<th colspan="1">Date</th>
									<th colspan="1">Location</th>
									<th colspan="1">Host</th>
									<th colspan="1">Action/State</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="myEvent" items="${myCreatedEvents}">
									<tr>
										<td><a href="/view/${myEvent.id}">
										<c:out value="${myEvent.name}" />
										</a>
										</td>
										<td><c:out value="${myEvent.eventdate}" /></td>
										<td><c:out value="${myEvent.location}" /></td>
										<td><c:out value="${myEvent.createdByName}" /></td>
										<td><a href="/editEvent/${myEvent.id}">Edit</a>
										<a href="/deleteEvent/${myEvent.id}">Delete</a>
										</td>
									</tr>
								</c:forEach>
								<c:forEach var="myEvent" items="${myJoiningEvents}">
									<tr>
									<c:if test="${myEvent.createdById != userId}">
										<td><a href="/view/${myEvent.id}">
										<c:out value="${myEvent.name}" />
										</a>
										</td>
										<td><c:out value="${myEvent.eventdate}" /></td>
										<td><c:out value="${myEvent.location}" /></td>
										<td><c:out value="${myEvent.createdByName}" /></td>
										<td>joining  <a href="/unjoin/${myEvent.id}">Cancel</a></td>
										</c:if>
									</tr>
								</c:forEach>
								<c:forEach var="myEvent" items="${notJoiningEvents}">
									<tr>
									<c:if  test="${myEvent.state == state}">
									
									<td><a href="/view/${myEvent.id}">
										<c:out value="${myEvent.name}" />
										</a>
										</td>
										<td><c:out value="${myEvent.eventdate}" /></td>
										<td><c:out value="${myEvent.location}" /></td>
										<td><c:out value="${myEvent.createdByName}" /></td>
										<td><a href="/join/${myEvent.id}">Join</a></td>
									</c:if>
									
										
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- --------------------------------------------------- -->
					<hr class="style-one">
					<div class="row mt-4">
						<p>Here are some of the events in other states:</p>
						<table class="table table-hover display nowrap mt-4">
							<thead>
								<tr>
									<th colspan="1">Name</th>
									<th colspan="1">Date</th>
									<th colspan="1">Location</th>
									<th colspan="1">State</th>
									<th colspan="1">Host</th>
									<th colspan="1">Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="myEvent" items="${otherSatesEventsNotJoined}">
									<tr>
										<td><a href="/view/${myEvent.id}">
										<c:out value="${myEvent.name}" />
										</a>
										</td>
										<td><c:out value="${myEvent.eventdate}" /></td>
										<td><c:out value="${myEvent.location}" /></td>
										<td><c:out value="${myEvent.state}" /></td>
										<td><c:out value="${myEvent.createdByName}" /></td>
										<td><a href="/join/${myEvent.id}">Join</a></td>									
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

			</div>
		</div>
	</div>
</body>
</html>


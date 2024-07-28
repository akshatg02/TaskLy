<%@page import="com.entities.Todo"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Taskly</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('${pageContext.request.contextPath}/resources/images/bg2.jpg');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
}

.list-group-item.active {
	background-color: #D2B48C;
	border-color: #D2B48C;
}

.semi-transparent-form {
	background-color: rgba(255, 255, 255, 0.4);
	border-radius: 0.25rem;
	padding: 1rem;
	box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.2);
}

.semi-transparent-input {
	background-color: rgba(255, 255, 255, 0.5);
}
</style>
</head>
<body>
	<div class="container mt-5">
		<div class="text-center mb-4">
			<h1 class="display-4">
				<b>Welcome to TaskLy</b>
			</h1>
		</div>

		<c:if test="${not empty msg}">
			<c:choose>
				<c:when test="${msg eq 'SUCCESS'}">
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<strong>Success!</strong> Task was successfully added.
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:when>
				<c:when test="${msg eq 'DELETE'}">
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<strong>Success!</strong> Task was successfully deleted.
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<strong>Error!</strong> Title cannot be empty.
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:otherwise>
			</c:choose>
		</c:if>

		<div class="row">
			<div class="col-md-3">
				<div class="list-group shadow-sm">
					<button type="button"
						class="list-group-item list-group-item-action active"
						aria-current="true">Menu</button>
					<a href="${pageContext.request.contextPath}/add"
						class="list-group-item list-group-item-action"
						<% String page1 = (String) request.getAttribute("page");
					    if ("add".equals(page1)) { %>
						style="background-color: #F5DEB3; height: 70px; line-height: 50px;"
						<% } else { %> style="height: 60px; line-height: 50px;" <% } %>>
						Add Task </a> <a id="viewTaskBtn"
						href="${pageContext.request.contextPath}/home"
						class="list-group-item list-group-item-action"
						<% if ("home".equals(page1)) { %>
						style="background-color: #F5DEB3; height: 70px; line-height: 50px;"
						<% } else { %> style="height: 60px; line-height: 50px;" <% } %>>
						View Task </a>
				</div>
			</div>
			<div class="col-md-9">
				<%
				if ("home".equals(page1)) {
				%>
				<!-- <h2 class="text-center">All ToDo</h2> -->
				<br />
				<%
				List<Todo> list = (List<Todo>) request.getAttribute("todos");
				for (Todo t : list) {
				%>
				<div class="card mb-3 shadow-sm semi-transparent-form">
					<div class="card-body">
						<h3 class="card-title"><%=t.getTodoTitle()%></h3>
						<p class="card-text"><%=t.getTodoContent()%></p>
						<small class="text-muted"><%=t.getTodoDate()%></small>
						<div class="mt-3">

							<button class="btn btn-sm me-2"
								style="background-color: #D2B48C; color: black;"
								onclick="showEditModal('<%=t.getId()%>', '<%=t.getTodoTitle()%>', '<%=t.getTodoContent()%>')">Edit</button>


							<button type="button" class="btn btn-danger btn-sm"
								onclick="confirmDelete('<%=t.getId()%>')">Delete</button>
						</div>
					</div>
				</div>
				<%
				}
				}
				%>

				<%
				if ("add".equals(page1)) {
				%>
				<!-- <h2 class="text-center">Add ToDo</h2> -->
				<form:form method="post"
					action="${pageContext.request.contextPath}/saveTodo"
					modelAttribute="todo" class="semi-transparent-form">
					<div class="form-group mb-3">
						<form:input path="todoTitle"
							cssClass="form-control semi-transparent-input"
							placeholder="Enter Title" />
					</div>

					<div class="form-group mb-3">
						<form:textarea path="todoContent"
							cssClass="form-control semi-transparent-input"
							placeholder="Enter Content" cssStyle="height:150px;" />
					</div>

					<div class="text-center">
						<button class="btn btn-outline-success">Add Task</button>
					</div>
				</form:form>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="editModal" tabindex="-1"
		aria-labelledby="editModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editModalLabel">Edit Todo</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form id="editForm" action="${pageContext.request.contextPath}/edit"
					method="post">
					<div class="modal-body">
						<input type="hidden" id="editId" name="id">
						<div class="form-group">
							<label for="editTitle">Title</label> <input type="text"
								class="form-control" id="editTitle" name="title" required>
						</div>
						<div class="form-group">
							<label for="editDescription">Description</label>
							<textarea class="form-control" id="editDescription"
								name="description"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary"
							style="background-color: #D2B48C; color: black;">Change</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
	<script>
		function showEditModal(id, title, description) {
			$('#editId').val(id);
			$('#editTitle').val(title);
			$('#editDescription').val(description);
			$('#editModal').modal('show');
		}

		function confirmDelete(id) {
			if (confirm("Are you sure you want to delete this task?")) {
				window.location.href = "${pageContext.request.contextPath}/delete?id="
						+ id;
			}
		}
	</script>
</body>
</html>

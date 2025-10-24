<%@ include file="../layout.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="Admin - User Management" />
<link href="<c:url value='/css/admin.css' />" rel="stylesheet">
</head>
<body>

	

	<!-- Admin Content -->
	<div class="container admin-container">
		<!-- Stats Overview -->
		<div class="stats-grid">
			<div class="stat-card">
				<div class="stat-number">${users.size()}</div>
				<div class="stat-label">Total Users</div>
			</div>
			<div class="stat-card">
				<div class="stat-number">
					<c:set var="activeUsers" value="${users.size()}" />
					${activeUsers}
				</div>
				<div class="stat-label">Active Users</div>
			</div>
		</div>

		<div class="admin-card mb-4">
			<div class="card-header">
				<h5>
					<i class="fas fa-file-pdf me-2"></i>User Reports
				</h5>
			</div>
			<div class="card-body">
				<div class="report-actions">
					<p class="text-muted mb-3">Download user reports in PDF format:</p>
					<div class="btn-group" role="group">
						<a href="<c:url value='/getUsersReport.pdf?clearance=ALL' />"
							class="btn btn-primary" target="_blank"> <i
							class="fas fa-download me-1"></i>All Users
						</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Users Table Card -->
		<div class="admin-card">
			<div class="card-header">
				<h5>
					<i class="fas fa-users-cog"></i> System Users
				</h5>
			</div>
			<div class="card-body">
				<c:if test="${not empty success}">
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<i class="fas fa-check-circle me-2"></i>${success}
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>

				<c:if test="${not empty error}">
					<div class="alert alert-danger alert-dismissible fade show"
						role="alert">
						<i class="fas fa-exclamation-circle me-2"></i>${error}
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>

				<c:if test="${empty users}">
					<div class="empty-state">
						<div class="empty-icon">
							<i class="fas fa-users-slash"></i>
						</div>
						<h3 class="empty-title">No Users Found</h3>
						<p class="empty-subtitle">There are no users in the system
							yet.</p>
					</div>
				</c:if>

				<c:if test="${not empty users}">
					<div class="table-responsive">
						<table class="users-table">
							<thead>
								<tr>
									<th>User</th>
									<th>User ID</th>
									<th>Username</th>
									<th>Email</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${users}" var="user">
									<tr class="${user.id == currentUser.id ? 'current-user' : ''}">
										<td>
											<div class="user-info">
												<div class="user-avatar">${user.username.charAt(0)}</div>
												<div>
													<div class="username">${user.username}</div>
													<c:if test="${user.id == currentUser.id}">
														<small class="text-primary">(You)</small>
													</c:if>
												</div>
											</div>
										</td>
										<td>
											<div class="user-id">#${user.id}</div>
										</td>
										<td>
											<div class="username">${user.username}</div>
										</td>
										<td>
											<div class="user-email">${user.email}</div>
										</td>
										<td>
											<div class="action-buttons">
												<c:if test="${user.id != currentUser.id}">
													<button type="button"
														class="btn btn-danger btn-sm delete-user-btn"
														data-user-id="${user.id}"
														data-user-name="${user.username}">
														<i class="fas fa-trash"></i> Delete
													</button>
												</c:if>
												<c:if test="${user.id == currentUser.id}">
													<span class="text-muted">Current User</span>
												</c:if>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:if>
			</div>
		</div>
	</div>

	<!-- Single Delete Confirmation Modal (not in loop) -->
	<div class="modal fade" id="deleteUserModal" tabindex="-1"
		aria-labelledby="deleteUserModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-danger text-white">
					<h5 class="modal-title" id="deleteUserModalLabel">
						<i class="fas fa-exclamation-triangle me-2"></i> Confirm User
						Deletion
					</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>
						Are you sure you want to delete user <strong id="userNameToDelete"></strong>?
					</p>
					<p class="text-danger mb-0">
						<i class="fas fa-exclamation-circle me-1"></i> This action cannot
						be undone. All user data will be permanently deleted.
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">
						<i class="fas fa-times me-1"></i> Cancel
					</button>
					<button type="button" class="btn btn-danger" id="confirmDeleteBtn">
						<i class="fas fa-trash me-1"></i> Delete User
					</button>
				</div>
			</div>
		</div>
	</div>

	<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Handle delete button clicks
        const deleteButtons = document.querySelectorAll('.delete-user-btn');
        const deleteUserModal = new bootstrap.Modal(document.getElementById('deleteUserModal'));
        const userNameElement = document.getElementById('userNameToDelete');
        const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
        
        let currentUserId = null;
        let csrfToken = '${_csrf.token}';
        let csrfParameterName = '${_csrf.parameterName}';
        
        // Get the base URL correctly
        const baseUrl = '<c:url value="/admin/users/delete/" />';
        
        deleteButtons.forEach(button => {
            button.addEventListener('click', function() {
                currentUserId = this.getAttribute('data-user-id');
                const userName = this.getAttribute('data-user-name');
                
                // Update modal content
                userNameElement.textContent = userName;
                
                // Show modal
                deleteUserModal.show();
            });
        });

        // Handle delete confirmation
        confirmDeleteBtn.addEventListener('click', function() {
            if (!currentUserId) return;
            
            // Disable button and show loading state
            const originalHtml = this.innerHTML;
            this.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i> Deleting...';
            this.disabled = true;
            
            // Create the correct URL
            const url = baseUrl + currentUserId;
            
            // Delete user using fetch API
            deleteUser(url);
        });

        // Function to delete user using fetch API
        function deleteUser(url) {
            // Create URLSearchParams for proper form data encoding
            const formData = new URLSearchParams();
            formData.append(csrfParameterName, csrfToken);
            formData.append('_method', 'DELETE');
            
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData
            })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                } else if (response.ok) {
                    window.location.reload();
                } else {
                    throw new Error('Delete request failed');
                }
            })
            .catch(error => {
                console.error('Error deleting user:', error);
                confirmDeleteBtn.innerHTML = '<i class="fas fa-trash me-1"></i> Delete User';
                confirmDeleteBtn.disabled = false;
                alert('Error deleting user. Please try again.');
            });
        }

        // Reset modal state when hidden
        deleteUserModal._element.addEventListener('hidden.bs.modal', function() {
            confirmDeleteBtn.innerHTML = '<i class="fas fa-trash me-1"></i> Delete User';
            confirmDeleteBtn.disabled = false;
            currentUserId = null;
        });

        // Auto-dismiss alerts
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                if (alert.parentNode) {
                    alert.style.opacity = '0';
                    setTimeout(() => {
                        if (alert.parentNode) {
                            alert.parentNode.removeChild(alert);
                        }
                    }, 300);
                }
            }, 5000);
        });
    });
    </script>
</body>
</html>
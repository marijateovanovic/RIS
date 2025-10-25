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
					<c:set var="blockedCount" value="0" />
					<c:forEach items="${users}" var="user">
						<c:if test="${user.blocked}">
							<c:set var="blockedCount" value="${blockedCount + 1}" />
						</c:if>
					</c:forEach>
					${blockedCount}
				</div>
				<div class="stat-label">Blocked Users</div>
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
						<button type="button" class="btn btn-primary" id="downloadReportBtn">
							<i class="fas fa-download me-1"></i>All Users
						</button>
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
									<th>Email</th>
									<th>Role</th>
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
												</div>
											</div>
										</td>
										<td>
											<div class="user-id">#${user.id}</div>
										</td>
										<td>
											<div class="user-email">${user.email}</div>
										</td>
										<td>
											<c:choose>
												<c:when test="${user.clearance == 'ADMIN'}">
													<span class="badge bg-danger">ADMIN</span>
												</c:when>
												<c:otherwise>
													<span class="badge bg-secondary">USER</span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<div class="action-buttons">
												<c:if test="${user.id != currentUser.id}">
													<!-- Make Admin Button (only for non-admins) -->
													<c:if test="${user.clearance != 'ADMIN'}">
														<button type="button"
															class="btn btn-warning btn-sm make-admin-btn"
															data-user-id="${user.id}"
															data-user-name="${user.username}">
															<i class="fas fa-crown"></i> Make Admin
														</button>
													</c:if>
													<!-- Block/Unblock Button -->
													<c:choose>
														<c:when test="${user.blocked}">
															<button type="button"
																class="btn btn-success btn-sm unblock-user-btn"
																data-user-id="${user.id}"
																data-user-name="${user.username}">
																<i class="fas fa-unlock"></i> Unblock
															</button>
														</c:when>
														<c:otherwise>
															<button type="button"
																class="btn btn-warning btn-sm block-user-btn"
																data-user-id="${user.id}"
																data-user-name="${user.username}">
																<i class="fas fa-ban"></i> Block
															</button>
														</c:otherwise>
													</c:choose>
													<!-- Delete Button -->
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

	<!-- Make Admin Confirmation Modal -->
	<div class="modal fade" id="makeAdminModal" tabindex="-1"
		aria-labelledby="makeAdminModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-warning text-dark">
					<h5 class="modal-title" id="makeAdminModalLabel">
						<i class="fas fa-crown me-2"></i> Confirm Admin Promotion
					</h5>
					<button type="button" class="btn-close"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>
						Are you sure you want to make <strong id="userNameToPromote"></strong> an admin?
					</p>
					<p class="text-warning mb-0">
						<i class="fas fa-info-circle me-1"></i> This user will have full administrative privileges.
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">
						<i class="fas fa-times me-1"></i> Cancel
					</button>
					<button type="button" class="btn btn-warning" id="confirmMakeAdminBtn">
						<i class="fas fa-crown me-1"></i> Make Admin
					</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Block User Confirmation Modal -->
	<div class="modal fade" id="blockUserModal" tabindex="-1"
		aria-labelledby="blockUserModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-warning text-dark">
					<h5 class="modal-title" id="blockUserModalLabel">
						<i class="fas fa-ban me-2"></i> Confirm User Block
					</h5>
					<button type="button" class="btn-close"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>
						Are you sure you want to block <strong id="userNameToBlock"></strong>?
					</p>
					<p class="text-warning mb-0">
						<i class="fas fa-info-circle me-1"></i> This user will not be able to log in until unblocked.
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">
						<i class="fas fa-times me-1"></i> Cancel
					</button>
					<button type="button" class="btn btn-warning" id="confirmBlockBtn">
						<i class="fas fa-ban me-1"></i> Block User
					</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Unblock User Confirmation Modal -->
	<div class="modal fade" id="unblockUserModal" tabindex="-1"
		aria-labelledby="unblockUserModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-success text-white">
					<h5 class="modal-title" id="unblockUserModalLabel">
						<i class="fas fa-unlock me-2"></i> Confirm User Unblock
					</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>
						Are you sure you want to unblock <strong id="userNameToUnblock"></strong>?
					</p>
					<p class="text-success mb-0">
						<i class="fas fa-info-circle me-1"></i> This user will be able to log in again.
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">
						<i class="fas fa-times me-1"></i> Cancel
					</button>
					<button type="button" class="btn btn-success" id="confirmUnblockBtn">
						<i class="fas fa-unlock me-1"></i> Unblock User
					</button>
				</div>
			</div>
		</div>
	</div>

	<script>
    document.addEventListener('DOMContentLoaded', function() {
        // CSRF token
        let csrfToken = '${_csrf.token}';
        let csrfParameterName = '${_csrf.parameterName}';
        
        // === DELETE USER FUNCTIONALITY ===
        const deleteButtons = document.querySelectorAll('.delete-user-btn');
        const deleteUserModal = new bootstrap.Modal(document.getElementById('deleteUserModal'));
        const userNameElement = document.getElementById('userNameToDelete');
        const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
        
        let currentDeleteUserId = null;
        const deleteBaseUrl = '<c:url value="/admin/users/delete/" />';
        
        deleteButtons.forEach(button => {
            button.addEventListener('click', function() {
                currentDeleteUserId = this.getAttribute('data-user-id');
                const userName = this.getAttribute('data-user-name');
                
                // Update modal content
                userNameElement.textContent = userName;
                
                // Show modal
                deleteUserModal.show();
            });
        });

        // Handle delete confirmation
        confirmDeleteBtn.addEventListener('click', function() {
            if (!currentDeleteUserId) return;
            
            // Disable button and show loading state
            this.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i> Deleting...';
            this.disabled = true;
            
            // Create the correct URL
            const url = deleteBaseUrl + currentDeleteUserId;
            
            // Delete user using fetch API
            deleteUser(url);
        });

        // Function to delete user using fetch API
        function deleteUser(url) {
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
            currentDeleteUserId = null;
        });

        // === MAKE ADMIN FUNCTIONALITY ===
        const makeAdminButtons = document.querySelectorAll('.make-admin-btn');
        const makeAdminModal = new bootstrap.Modal(document.getElementById('makeAdminModal'));
        const userNameToPromoteElement = document.getElementById('userNameToPromote');
        const confirmMakeAdminBtn = document.getElementById('confirmMakeAdminBtn');
        
        let currentPromoteUserId = null;
        const makeAdminBaseUrl = '<c:url value="/admin/users/make-admin/" />';
        
        makeAdminButtons.forEach(button => {
            button.addEventListener('click', function() {
                currentPromoteUserId = this.getAttribute('data-user-id');
                const userName = this.getAttribute('data-user-name');
                
                // Update modal content
                userNameToPromoteElement.textContent = userName;
                
                // Show modal
                makeAdminModal.show();
            });
        });

        // Handle make admin confirmation
        confirmMakeAdminBtn.addEventListener('click', function() {
            if (!currentPromoteUserId) return;
            
            // Disable button and show loading state
            this.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i> Promoting...';
            this.disabled = true;
            
            // Create the correct URL
            const url = makeAdminBaseUrl + currentPromoteUserId;
            
            // Make admin using fetch API
            makeUserAdmin(url);
        });

        // Function to make user admin using fetch API
        function makeUserAdmin(url) {
            const formData = new URLSearchParams();
            formData.append(csrfParameterName, csrfToken);
            
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
                    throw new Error('Make admin request failed');
                }
            })
            .catch(error => {
                console.error('Error promoting user:', error);
                confirmMakeAdminBtn.innerHTML = '<i class="fas fa-crown me-1"></i> Make Admin';
                confirmMakeAdminBtn.disabled = false;
                alert('Error promoting user. Please try again.');
            });
        }

        // Reset modal state when hidden
        makeAdminModal._element.addEventListener('hidden.bs.modal', function() {
            confirmMakeAdminBtn.innerHTML = '<i class="fas fa-crown me-1"></i> Make Admin';
            confirmMakeAdminBtn.disabled = false;
            currentPromoteUserId = null;
        });

        // === BLOCK USER FUNCTIONALITY ===
        const blockUserButtons = document.querySelectorAll('.block-user-btn');
        const blockUserModal = new bootstrap.Modal(document.getElementById('blockUserModal'));
        const userNameToBlockElement = document.getElementById('userNameToBlock');
        const confirmBlockBtn = document.getElementById('confirmBlockBtn');
        
        let currentBlockUserId = null;
        const blockBaseUrl = '<c:url value="/admin/users/block/" />';
        
        blockUserButtons.forEach(button => {
            button.addEventListener('click', function() {
                currentBlockUserId = this.getAttribute('data-user-id');
                const userName = this.getAttribute('data-user-name');
                
                // Update modal content
                userNameToBlockElement.textContent = userName;
                
                // Show modal
                blockUserModal.show();
            });
        });

        // Handle block confirmation
        confirmBlockBtn.addEventListener('click', function() {
            if (!currentBlockUserId) return;
            
            // Disable button and show loading state
            this.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i> Blocking...';
            this.disabled = true;
            
            // Create the correct URL
            const url = blockBaseUrl + currentBlockUserId;
            
            // Block user using fetch API
            blockUser(url);
        });

        // Function to block user using fetch API
        function blockUser(url) {
            const formData = new URLSearchParams();
            formData.append(csrfParameterName, csrfToken);
            
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
                    throw new Error('Block request failed');
                }
            })
            .catch(error => {
                console.error('Error blocking user:', error);
                confirmBlockBtn.innerHTML = '<i class="fas fa-ban me-1"></i> Block User';
                confirmBlockBtn.disabled = false;
                alert('Error blocking user. Please try again.');
            });
        }

        // Reset modal state when hidden
        blockUserModal._element.addEventListener('hidden.bs.modal', function() {
            confirmBlockBtn.innerHTML = '<i class="fas fa-ban me-1"></i> Block User';
            confirmBlockBtn.disabled = false;
            currentBlockUserId = null;
        });

        // === UNBLOCK USER FUNCTIONALITY ===
        const unblockUserButtons = document.querySelectorAll('.unblock-user-btn');
        const unblockUserModal = new bootstrap.Modal(document.getElementById('unblockUserModal'));
        const userNameToUnblockElement = document.getElementById('userNameToUnblock');
        const confirmUnblockBtn = document.getElementById('confirmUnblockBtn');
        
        let currentUnblockUserId = null;
        const unblockBaseUrl = '<c:url value="/admin/users/unblock/" />';
        
        unblockUserButtons.forEach(button => {
            button.addEventListener('click', function() {
                currentUnblockUserId = this.getAttribute('data-user-id');
                const userName = this.getAttribute('data-user-name');
                
                // Update modal content
                userNameToUnblockElement.textContent = userName;
                
                // Show modal
                unblockUserModal.show();
            });
        });

        // Handle unblock confirmation
        confirmUnblockBtn.addEventListener('click', function() {
            if (!currentUnblockUserId) return;
            
            // Disable button and show loading state
            this.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i> Unblocking...';
            this.disabled = true;
            
            // Create the correct URL
            const url = unblockBaseUrl + currentUnblockUserId;
            
            // Unblock user using fetch API
            unblockUser(url);
        });

        // Function to unblock user using fetch API
        function unblockUser(url) {
            const formData = new URLSearchParams();
            formData.append(csrfParameterName, csrfToken);
            
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
                    throw new Error('Unblock request failed');
                }
            })
            .catch(error => {
                console.error('Error unblocking user:', error);
                confirmUnblockBtn.innerHTML = '<i class="fas fa-unlock me-1"></i> Unblock User';
                confirmUnblockBtn.disabled = false;
                alert('Error unblocking user. Please try again.');
            });
        }

        // Reset modal state when hidden
        unblockUserModal._element.addEventListener('hidden.bs.modal', function() {
            confirmUnblockBtn.innerHTML = '<i class="fas fa-unlock me-1"></i> Unblock User';
            confirmUnblockBtn.disabled = false;
            currentUnblockUserId = null;
        });

        // === AUTO-DISMISS ALERTS ===
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

        // === DOWNLOAD REPORT WITHOUT LOADING SPINNER ===
        const downloadReportBtn = document.getElementById('downloadReportBtn');
        if (downloadReportBtn) {
            downloadReportBtn.addEventListener('click', function() {
                // Create a temporary link and trigger download
                const link = document.createElement('a');
                link.href = '<c:url value="/getUsersReport.pdf?clearance=ALL" />';
                link.download = 'users_report_ALL.pdf';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
        }
    });
    </script>
</body>
</html>
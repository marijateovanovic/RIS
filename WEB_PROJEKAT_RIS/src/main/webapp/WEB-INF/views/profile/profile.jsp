<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="My Profile" scope="request" />
<jsp:include page="../layout.jsp">
    <jsp:param name="content" value="profile" />
</jsp:include>

<style>
    .profile-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .profile-card {
        background: white;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }
    
    .profile-header {
        display: flex;
        align-items: center;
        gap: 30px;
        margin-bottom: 30px;
        padding-bottom: 30px;
        border-bottom: 2px solid var(--facebook-border);
    }
    
    .profile-photo-section {
        text-align: center;
    }
    
    .profile-photo {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid var(--facebook-blue);
        margin-bottom: 15px;
    }
    
    .profile-photo-placeholder {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        background: var(--facebook-blue);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 60px;
        font-weight: bold;
        border: 4px solid var(--facebook-blue);
        margin-bottom: 15px;
    }
    
    .profile-info {
        flex: 1;
    }
    
    .profile-username {
        font-size: 32px;
        font-weight: bold;
        color: var(--facebook-text);
        margin-bottom: 10px;
    }
    
    .profile-email {
        font-size: 18px;
        color: var(--facebook-text-secondary);
    }
    
    .section-title {
        font-size: 20px;
        font-weight: 600;
        color: var(--facebook-text);
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid var(--facebook-border);
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    .form-label {
        display: block;
        font-weight: 600;
        color: var(--facebook-text);
        margin-bottom: 8px;
    }
    
    .form-control {
        width: 100%;
        padding: 12px 16px;
        border: 1px solid var(--facebook-border);
        border-radius: 8px;
        font-size: 15px;
        transition: border-color 0.2s;
    }
    
    .form-control:focus {
        outline: none;
        border-color: var(--facebook-blue);
        box-shadow: 0 0 0 2px rgba(24, 119, 242, 0.2);
    }
    
    .btn {
        padding: 10px 24px;
        border: none;
        border-radius: 6px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
    }
    
    .btn-primary {
        background-color: var(--facebook-blue);
        color: white;
    }
    
    .btn-primary:hover {
        background-color: var(--facebook-dark-blue);
    }
    
    .btn-secondary {
        background-color: var(--facebook-bg);
        color: var(--facebook-text);
    }
    
    .btn-secondary:hover {
        background-color: var(--facebook-border);
    }
    
    .btn-danger {
        background-color: #dc3545;
        color: white;
    }
    
    .btn-danger:hover {
        background-color: #c82333;
    }
    
    .alert {
        padding: 12px 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-size: 15px;
    }
    
    .alert-success {
        background-color: #d4edda;
        border: 1px solid #c3e6cb;
        color: #155724;
    }
    
    .alert-error {
        background-color: #f8d7da;
        border: 1px solid #f5c6cb;
        color: #721c24;
    }
    
    .photo-preview-container {
        position: relative;
        display: inline-block;
    }
    
    .photo-preview {
        max-width: 150px;
        max-height: 150px;
        border-radius: 50%;
        object-fit: cover;
        display: none;
        border: 4px solid var(--facebook-blue);
    }
    
    .remove-photo-btn {
        position: absolute;
        top: -10px;
        right: -10px;
        background: #dc3545;
        color: white;
        border: none;
        border-radius: 50%;
        width: 30px;
        height: 30px;
        cursor: pointer;
        display: none;
        align-items: center;
        justify-content: center;
        font-size: 16px;
    }
    
    .remove-photo-btn:hover {
        background: #c82333;
    }
    
    .file-input-wrapper {
        display: inline-block;
        cursor: pointer;
    }
    
    .file-input {
        display: none;
    }
    
    .btn-group {
        display: flex;
        gap: 10px;
        margin-top: 15px;
    }
</style>

<div class="profile-container">
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>
    
    <!-- Profile Header -->
    <div class="profile-card">
        <div class="profile-header">
            <div class="profile-photo-section">
                <c:choose>
                    <c:when test="${not empty user.profilePhotoPath}">
                        <img src="${pageContext.request.contextPath}${user.profilePhotoPath}" 
                             alt="Profile Photo" class="profile-photo">
                    </c:when>
                    <c:otherwise>
                        <div class="profile-photo-placeholder">
                            ${user.username.charAt(0).toString().toUpperCase()}
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="profile-info">
                <div class="profile-username">${user.username}</div>
                <div class="profile-email">
                    <i class="fas fa-envelope"></i> ${user.email != null ? user.email : 'No email set'}
                </div>
            </div>
        </div>
        
        <!-- Update Profile Form -->
        <h3 class="section-title">
            <i class="fas fa-user-edit"></i> Update Profile
        </h3>
        
        <form action="${pageContext.request.contextPath}/profile/update" 
              method="POST" 
              enctype="multipart/form-data"
              id="profileForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="removePhoto" id="removePhotoInput" value="false">
            
            <div class="form-group">
                <label class="form-label" for="email">
                    <i class="fas fa-envelope"></i> Email
                </label>
                <input type="email" 
                       class="form-control" 
                       id="email" 
                       name="email" 
                       value="${user.email != null ? user.email : ''}"
                       placeholder="your.email@example.com">
            </div>
            
            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-camera"></i> Profile Photo
                </label>
                <div class="photo-preview-container">
                    <img id="photoPreview" class="photo-preview" alt="Photo Preview">
                    <button type="button" class="remove-photo-btn" id="removePreviewBtn">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="btn-group">
                    <label for="profilePhotoInput" class="btn btn-secondary file-input-wrapper">
                        <i class="fas fa-upload"></i> Choose Photo
                    </label>
                    <input type="file" 
                           class="file-input" 
                           id="profilePhotoInput" 
                           name="profilePhoto" 
                           accept="image/*">
                    <c:if test="${not empty user.profilePhotoPath}">
                        <button type="button" class="btn btn-danger" id="removeExistingPhotoBtn">
                            <i class="fas fa-trash"></i> Remove Current Photo
                        </button>
                    </c:if>
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Save Changes
            </button>
        </form>
    </div>
    
    <!-- Change Password Card -->
    <div class="profile-card">
        <h3 class="section-title">
            <i class="fas fa-lock"></i> Change Password
        </h3>
        
        <form action="${pageContext.request.contextPath}/profile/change-password" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            
            <div class="form-group">
                <label class="form-label" for="currentPassword">
                    <i class="fas fa-key"></i> Current Password
                </label>
                <input type="password" 
                       class="form-control" 
                       id="currentPassword" 
                       name="currentPassword" 
                       required
                       placeholder="Enter your current password">
            </div>
            
            <div class="form-group">
                <label class="form-label" for="newPassword">
                    <i class="fas fa-lock"></i> New Password
                </label>
                <input type="password" 
                       class="form-control" 
                       id="newPassword" 
                       name="newPassword" 
                       required
                       placeholder="Enter new password (min 6 characters)">
            </div>
            
            <div class="form-group">
                <label class="form-label" for="confirmPassword">
                    <i class="fas fa-lock"></i> Confirm New Password
                </label>
                <input type="password" 
                       class="form-control" 
                       id="confirmPassword" 
                       name="confirmPassword" 
                       required
                       placeholder="Confirm new password">
            </div>
            
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-key"></i> Change Password
            </button>
        </form>
    </div>
</div>

<script>
    // Photo preview functionality
    const photoInput = document.getElementById('profilePhotoInput');
    const photoPreview = document.getElementById('photoPreview');
    const removePreviewBtn = document.getElementById('removePreviewBtn');
    const removePhotoInput = document.getElementById('removePhotoInput');
    const removeExistingPhotoBtn = document.getElementById('removeExistingPhotoBtn');
    const profileForm = document.getElementById('profileForm');
    
    if (photoInput) {
        photoInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    photoPreview.src = e.target.result;
                    photoPreview.style.display = 'block';
                    removePreviewBtn.style.display = 'flex';
                };
                reader.readAsDataURL(file);
                removePhotoInput.value = 'false';
            }
        });
    }
    
    if (removePreviewBtn) {
        removePreviewBtn.addEventListener('click', function() {
            photoInput.value = '';
            photoPreview.style.display = 'none';
            removePreviewBtn.style.display = 'none';
        });
    }
    
    if (removeExistingPhotoBtn) {
        removeExistingPhotoBtn.addEventListener('click', function() {
            if (confirm('Are you sure you want to remove your profile photo?')) {
                removePhotoInput.value = 'true';
                profileForm.submit();
            }
        });
    }
    
    // Password confirmation validation
    const newPasswordInput = document.getElementById('newPassword');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    
    if (confirmPasswordInput) {
        confirmPasswordInput.addEventListener('input', function() {
            if (this.value !== newPasswordInput.value) {
                this.setCustomValidity('Passwords do not match');
            } else {
                this.setCustomValidity('');
            }
        });
    }
</script>


<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="${profileUser.username}'s Profile" scope="request" />
<jsp:include page="../layout.jsp">
    <jsp:param name="content" value="public-profile" />
</jsp:include>

<style>
    .back-button {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: white;
        color: var(--facebook-text);
        border: 1px solid var(--facebook-border);
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
        margin-bottom: 20px;
        text-decoration: none;
    }
    
    .back-button:hover {
        background: var(--facebook-hover);
        border-color: var(--facebook-blue);
        color: var(--facebook-blue);
    }
    
    .back-button i {
        font-size: 16px;
    }
    
    .profile-header-card {
        background: white;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 30px;
    }
    
    .profile-photo-wrapper {
        flex-shrink: 0;
    }
    
    .profile-photo-large {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid var(--facebook-blue);
        flex-shrink: 0;
    }
    
    .profile-photo-placeholder-large {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        background: var(--facebook-blue);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 48px;
        font-weight: bold;
        border: 4px solid var(--facebook-blue);
        flex-shrink: 0;
    }
    
    .profile-info-section {
        flex: 1;
        min-width: 0;
        overflow: hidden;
    }
    
    .profile-display-username {
        font-size: 32px;
        font-weight: bold;
        color: var(--facebook-text);
        margin-bottom: 10px;
        word-wrap: break-word;
    }
    
    .profile-display-email {
        font-size: 16px;
        color: var(--facebook-text-secondary);
        margin-bottom: 20px;
        word-wrap: break-word;
    }
    
    .posts-section-title {
        font-size: 24px;
        font-weight: 600;
        color: var(--facebook-text);
        margin-bottom: 20px;
        padding: 20px;
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    
    /* Post Card Styles */
    .post-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    
    .post-header {
        margin-bottom: 16px;
    }
    
    .post-user-info {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .post-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        flex-shrink: 0;
    }
    
    .post-author {
        font-weight: 600;
        color: var(--facebook-text);
        font-size: 15px;
    }
    
    .post-date {
        font-size: 13px;
        color: var(--facebook-text-secondary);
    }
    
    .post-content {
        color: var(--facebook-text);
        font-size: 15px;
        line-height: 1.5;
        margin-bottom: 16px;
        word-wrap: break-word;
        overflow-wrap: break-word;
    }
    
    .post-image-container {
        margin: 16px 0;
        width: 100%;
        overflow: hidden;
        border-radius: 8px;
    }
    
    .post-image {
        width: 100%;
        max-width: 100%;
        height: auto;
        display: block;
        object-fit: contain;
        max-height: 600px;
    }
    
    .post-stats {
        padding-top: 12px;
        border-top: 1px solid var(--facebook-border);
        color: var(--facebook-text-secondary);
        font-size: 14px;
    }
    
    .post-stats i {
        color: var(--facebook-blue);
        margin-right: 4px;
    }
    
    /* Responsive Design */
    @media (max-width: 768px) {
        .profile-header-card {
            flex-direction: column;
            text-align: center;
            padding: 20px;
        }
        
        .profile-display-username {
            font-size: 24px;
        }
        
        .profile-photo-large,
        .profile-photo-placeholder-large {
            width: 100px;
            height: 100px;
            font-size: 40px;
        }
    }
</style>

<div class="container" style="max-width: 800px; margin: 0 auto; padding: 20px;">
    <!-- Back Button -->
    <button class="back-button" onclick="history.back()">
        <i class="fas fa-arrow-left"></i>
        Back
    </button>
    
    <!-- Profile Header -->
    <div class="profile-header-card">
        <div class="profile-photo-wrapper">
            <c:choose>
                <c:when test="${not empty profileUser.profilePhotoPath}">
                    <img src="${pageContext.request.contextPath}${profileUser.profilePhotoPath}" 
                         alt="${profileUser.username}" 
                         class="profile-photo-large">
                </c:when>
                <c:otherwise>
                    <div class="profile-photo-placeholder-large">
                        ${profileUser.username.charAt(0).toString().toUpperCase()}
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="profile-info-section">
            <div class="profile-display-username">${profileUser.username}</div>
            <c:if test="${not empty profileUser.email}">
                <div class="profile-display-email">
                    <i class="fas fa-envelope"></i> ${profileUser.email}
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- Posts Section Title -->
    <div class="posts-section-title">
        <i class="fas fa-newspaper"></i> Posts by ${profileUser.username}
    </div>
    
    <!-- Posts List -->
    <c:choose>
        <c:when test="${empty posts}">
            <div class="post-card" style="text-align: center; padding: 40px; color: var(--facebook-text-secondary);">
                <i class="fas fa-inbox" style="font-size: 48px; margin-bottom: 16px; opacity: 0.5;"></i>
                <p style="font-size: 18px; margin: 0;">No posts yet</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="post" items="${posts}">
                <div class="post-card">
                    <div class="post-header">
                        <div class="post-user-info">
                            <c:choose>
                                <c:when test="${not empty profileUser.profilePhotoPath}">
                                    <img src="${pageContext.request.contextPath}${profileUser.profilePhotoPath}" 
                                         alt="${profileUser.username}" 
                                         class="post-avatar">
                                </c:when>
                                <c:otherwise>
                                    <div class="post-avatar" style="background: var(--facebook-blue); color: white; display: flex; align-items: center; justify-content: center; font-weight: 600;">
                                        ${profileUser.username.charAt(0).toString().toUpperCase()}
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div>
                                <div class="post-author">${profileUser.username}</div>
                                <div class="post-date">
                                    <fmt:formatDate value="${post.createdAt}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="post-content">
                        ${post.content}
                    </div>
                    
                    <c:if test="${not empty post.imagePath}">
                        <div class="post-image-container">
                            <img src="${pageContext.request.contextPath}${post.imagePath}" 
                                 alt="Post image" 
                                 class="post-image">
                        </div>
                    </c:if>
                    
                    <div class="post-stats">
                        <span>
                            <i class="fas fa-thumbs-up"></i>
                            <span id="like-count-${post.id}">
                                ${likeCounts[post.id] != null ? likeCounts[post.id] : 0}
                            </span>
                        </span>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

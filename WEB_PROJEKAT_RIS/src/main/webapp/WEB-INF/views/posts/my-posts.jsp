<%@ include file="../layout.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="My Posts" />
<link href="${pageContext.request.contextPath}/css/my-posts.css" rel="stylesheet" type="text/css">
<style>
    :root {
        --facebook-blue: #1877f2;
        --facebook-dark-blue: #166fe5;
        --facebook-green: #42b72a;
        --facebook-dark-green: #36a420;
        --facebook-bg: #f0f2f5;
        --facebook-card: #ffffff;
        --facebook-text: #1c1e21;
        --facebook-text-secondary: #65676b;
        --facebook-border: #dddfe2;
        --facebook-hover: #f2f2f2;
    }
    
    .profile-header {
        background: var(--facebook-card);
        border-bottom: 1px solid var(--facebook-border);
        padding: 20px 0;
        margin-bottom: 16px;
    }
    
    .header-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 16px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .header-titles {
        flex: 1;
    }
    
    .profile-title {
        color: var(--facebook-text);
        font-weight: 700;
        font-size: 1.5rem;
        margin-bottom: 4px;
    }
    
    .profile-subtitle {
        color: var(--facebook-text-secondary);
        font-size: 0.9375rem;
        margin: 0;
    }
    
    .create-post-btn {
        background-color: var(--facebook-blue);
        border: none;
        border-radius: 6px;
        padding: 10px 20px;
        font-weight: 600;
        color: white;
        text-decoration: none;
        transition: background-color 0.2s;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 0.9375rem;
        white-space: nowrap;
    }
    
    .create-post-btn:hover {
        background-color: var(--facebook-dark-blue);
        color: white;
    }
    
    .profile-main {
        max-width: 680px;
        margin: 0 auto;
        padding: 0 16px;
    }
    
    .profile-stats {
        background: var(--facebook-card);
        border: 1px solid var(--facebook-border);
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 16px;
    }
    
    .stat-item {
        text-align: center;
        padding: 10px;
    }
    
    .stat-number {
        font-size: 1.5rem;
        font-weight: 700;
        margin-bottom: 4px;
        color: var(--facebook-blue);
    }
    
    .stat-label {
        font-size: 0.875rem;
        color: var(--facebook-text-secondary);
    }
    
    .post-actions {
        display: flex;
        gap: 8px;
        margin-top: 16px;
        padding-top: 16px;
        border-top: 1px solid var(--facebook-border);
    }
    
    .btn-edit {
        background-color: var(--facebook-blue);
        border: none;
        border-radius: 6px;
        padding: 8px 16px;
        color: white;
        font-weight: 600;
        text-decoration: none;
        transition: background-color 0.2s;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 0.875rem;
        flex: 1;
        justify-content: center;
    }
    
    .btn-edit:hover {
        background-color: var(--facebook-dark-blue);
        color: white;
    }
    
    .btn-delete {
        background-color: #e4e6eb;
        border: none;
        border-radius: 6px;
        padding: 8px 16px;
        color: var(--facebook-text);
        font-weight: 600;
        transition: background-color 0.2s;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 0.875rem;
        flex: 1;
        justify-content: center;
        cursor: pointer;
    }
    
    .btn-delete:hover {
        background-color: #d8dadf;
    }
    
    .user-meta {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 12px;
        flex-wrap: wrap;
    }
    
    .user-badge {
        background: #f0f2f5;
        color: var(--facebook-text-secondary);
        padding: 4px 8px;
        border-radius: 6px;
        font-size: 0.8125rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 4px;
    }
    
    .time-badge {
        color: var(--facebook-text-secondary);
        font-size: 0.8125rem;
        display: inline-flex;
        align-items: center;
        gap: 4px;
    }
    
    .post-stats {
        display: flex;
        gap: 16px;
        margin-top: 12px;
        padding-top: 12px;
        border-top: 1px solid var(--facebook-border);
    }
    
    .stat {
        display: flex;
        align-items: center;
        gap: 4px;
        color: var(--facebook-text-secondary);
        font-size: 0.8125rem;
    }
    
    .post-image {
        width: 100%;
        max-height: 500px;
        object-fit: cover;
        border-radius: 8px;
        margin-top: 12px;
        cursor: pointer;
        transition: opacity 0.2s;
        border: 1px solid var(--facebook-border);
    }
    
    .post-image:hover {
        opacity: 0.97;
    }
</style>
</head>
<body>

    <br><br>

    <!-- Profile Content -->
    <div class="profile-main">
        
        <!-- Posts Content -->
        <div class="my-posts-container">
            <c:if test="${empty posts}">
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="fas fa-edit"></i>
                    </div>
                    <h3 class="empty-title">No posts yet</h3>
                    <p class="empty-subtitle">Share your thoughts and experiences with the community.</p>
                    <a href="<c:url value='/posts/new' />" class="create-post-btn">
                        <i class="fas fa-edit"></i>
                        Create Your First Post
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty posts}">
                <div class="posts-grid">
                    <c:forEach items="${posts}" var="post" varStatus="status">
                        <div class="post-card">
                            <div class="card-body">
                                <!-- Post Meta -->
                                <div class="user-meta">
                                    <span class="user-badge">
                                        <i class="fas fa-user-circle"></i>
                                        ${user.username}
                                    </span>
                                    <span class="time-badge">
                                        • ${post.createdAt}
                                    </span>
                                </div>
                                
                                <!-- Post Content -->
                                <div class="post-content">
                                    ${post.content}
                                </div>
                                
                                <c:if test="${not empty post.imagePath}">
                                    <img src="${pageContext.request.contextPath}${post.imagePath}" 
                                         alt="Post image" 
                                         class="post-image"
                                         loading="lazy">
                                </c:if>
                                
                                <!-- Post Stats -->
                                <div class="post-stats">
                                    <div class="stat">
                                        <i class="fas fa-thumbs-up"></i>
                                        <span>156</span>
                                    </div>
                                    <div class="stat">
                                        <span>24 comments</span>
                                    </div>
                                    <div class="stat">
                                        <span>1.2K shares</span>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="post-actions">
                                    <a href="<c:url value='/posts/edit/${post.id}' />" class="btn-edit">
                                        <i class="fas fa-edit"></i>
                                        Edit
                                    </a>
                                    <button onclick="confirmDelete(${post.id})" class="btn-delete">
                                        <i class="fas fa-trash"></i>
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        function confirmDelete(postId) {
            if (confirm("Delete this post?")) {
                window.location.href = '<c:url value="/posts/delete/"/>' + postId;
            }
        }
        
        // Read More functionality for long posts
        document.addEventListener('DOMContentLoaded', function() {
            const postContents = document.querySelectorAll('.post-content');
            postContents.forEach(content => {
                const contentText = content.textContent || content.innerText;
                
                if (contentText.length > 250) {
                    // Store original content
                    const originalContent = content.innerHTML;
                    
                    // Create truncated version
                    const truncatedContent = contentText.substring(0, 250) + '...';
                    content.innerHTML = truncatedContent;
                    
                    // Create read more button
                    const readMoreBtn = document.createElement('button');
                    readMoreBtn.className = 'read-more-btn';
                    readMoreBtn.innerHTML = 'See More';
                    readMoreBtn.style.cssText = `
                        background: none;
                        border: none;
                        color: var(--facebook-text-secondary);
                        font-weight: 600;
                        cursor: pointer;
                        padding: 4px 0;
                        font-size: 0.875rem;
                        margin-top: 8px;
                    `;
                    
                    readMoreBtn.addEventListener('click', function() {
                        if (content.classList.contains('expanded')) {
                            content.innerHTML = truncatedContent;
                            content.appendChild(readMoreBtn);
                            readMoreBtn.innerHTML = 'See More';
                            content.classList.remove('expanded');
                        } else {
                            content.innerHTML = originalContent;
                            content.appendChild(readMoreBtn);
                            readMoreBtn.innerHTML = 'See Less';
                            content.classList.add('expanded');
                        }
                    });
                    
                    content.appendChild(readMoreBtn);
                }
            });
        });
        
        // Add hover effects to cards
        const postCards = document.querySelectorAll('.post-card');
        postCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
        
        // Add loading animation to create post button
        const createPostBtn = document.querySelector('.create-post-btn');
        if (createPostBtn) {
            createPostBtn.addEventListener('click', function(e) {
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating...';
                this.style.pointerEvents = 'none';
            });
        }
    </script>
</body>
</html>
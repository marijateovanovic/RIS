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
                                    <c:if test="${likeCounts[post.id] > 0}">
                                        <div class="stat likes-stat" data-post-id="${post.id}" style="cursor: pointer;" title="Click to see who liked this">
                                            <i class="fas fa-thumbs-up"></i>
                                            <span id="like-count-${post.id}">${likeCounts[post.id]}</span>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Action Buttons -->
                                <div class="post-actions">
                                    <button class="post-action like-btn" data-post-id="${post.id}" data-liked="${userLikes[post.id]}" style="color: ${userLikes[post.id] ? 'var(--facebook-blue)' : 'var(--facebook-text-secondary)'}; border: none; background: none; padding: 8px 16px; cursor: pointer; font-size: 0.9375rem; transition: background-color 0.2s;">
                                        <i class="${userLikes[post.id] ? 'fas' : 'far'} fa-thumbs-up"></i>
                                        Like
                                    </button>
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

    <!-- Likes Modal -->
    <div id="likesModal" style="display: none; position: fixed; z-index: 10000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5);">
        <div style="background-color: white; margin: 10% auto; padding: 0; border-radius: 8px; width: 400px; max-width: 90%; box-shadow: 0 4px 12px rgba(0,0,0,0.3);">
            <div style="padding: 16px 20px; border-bottom: 1px solid #dddfe2; display: flex; justify-content: space-between; align-items: center;">
                <h3 style="margin: 0; font-size: 1.25rem; color: #1c1e21;">People who liked this</h3>
                <button id="closeLikesModal" style="background: none; border: none; font-size: 1.5rem; cursor: pointer; color: #65676b; padding: 0; width: 32px; height: 32px; display: flex; align-items: center; justify-content: center; border-radius: 50%;">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div id="likesModalContent" style="padding: 16px 20px; max-height: 400px; overflow-y: auto;">
                <div style="text-align: center; padding: 20px;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: #1877f2;"></i>
                </div>
            </div>
        </div>
    </div>

    <script>
        function confirmDelete(postId) {
            if (confirm("Delete this post?")) {
                window.location.href = '<c:url value="/posts/delete/"/>' + postId;
            }
        }
        
        // Like button functionality
        document.addEventListener('DOMContentLoaded', function() {
            const likeButtons = document.querySelectorAll('.like-btn');
            
            likeButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const postId = this.getAttribute('data-post-id');
                    const icon = this.querySelector('i');
                    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
                    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
                    
                    // Send AJAX request
                    fetch('${pageContext.request.contextPath}/posts/like/' + postId, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            [csrfHeader]: csrfToken
                        },
                        credentials: 'same-origin'
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Update button style
                            if (data.liked) {
                                icon.className = 'fas fa-thumbs-up';
                                this.style.color = 'var(--facebook-blue)';
                                this.setAttribute('data-liked', 'true');
                            } else {
                                icon.className = 'far fa-thumbs-up';
                                this.style.color = 'var(--facebook-text-secondary)';
                                this.setAttribute('data-liked', 'false');
                            }
                            
                            // Update like count display
                            const countElement = document.getElementById('like-count-' + postId);
                            const statsContainer = countElement ? countElement.closest('.post-stats') : this.closest('.post-card').querySelector('.post-stats');
                            
                            if (data.likeCount > 0) {
                                if (countElement) {
                                    countElement.textContent = data.likeCount;
                                } else {
                                    
                                    statsContainer.innerHTML = '<div class="stat likes-stat" data-post-id="' + postId + '" style="cursor: pointer;" title="Click to see who liked this"><i class="fas fa-thumbs-up"></i><span id="like-count-' + postId + '">' + data.likeCount + '</span></div>';
                                }
                            } else {
                                
                                if (countElement) {
                                    countElement.closest('.stat').remove();
                                }
                            }
                        } else {
                            console.error('Error liking post:', data.message);
                            alert('Error: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An error occurred while liking the post');
                    });
                });
            });
        });
        
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
        
        // Likes Modal functionality
        const likesModal = document.getElementById('likesModal');
        const likesModalContent = document.getElementById('likesModalContent');
        const closeLikesModalBtn = document.getElementById('closeLikesModal');
        
        // Handle clicks on like count
        document.addEventListener('click', function(e) {
            const likesStat = e.target.closest('.likes-stat');
            if (likesStat) {
                const postId = likesStat.getAttribute('data-post-id');
                showLikesModal(postId);
            }
        });
        
        // Close modal
        closeLikesModalBtn.addEventListener('click', function() {
            likesModal.style.display = 'none';
        });
        
        // Close modal when clicking outside
        likesModal.addEventListener('click', function(e) {
            if (e.target === likesModal) {
                likesModal.style.display = 'none';
            }
        });
        
        // Show likes modal and fetch users
        function showLikesModal(postId) {
            likesModal.style.display = 'block';
            likesModalContent.innerHTML = '<div style="text-align: center; padding: 20px;"><i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: #1877f2;"></i></div>';
            
            fetch('${pageContext.request.contextPath}/posts/likes/' + postId, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'same-origin'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success && data.users && data.users.length > 0) {
                    let html = '<div style="display: flex; flex-direction: column; gap: 8px;">';
                    data.users.forEach(username => {
                        html += '<div style="display: flex; align-items: center; padding: 8px; border-radius: 6px; transition: background-color 0.2s;" onmouseover="this.style.backgroundColor=\'#f2f2f2\'" onmouseout="this.style.backgroundColor=\'transparent\'">';
                        html += '<div style="width: 40px; height: 40px; background: #1877f2; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; font-size: 0.875rem; margin-right: 12px;">';
                        html += username.charAt(0).toUpperCase();
                        html += '</div>';
                        html += '<span style="font-weight: 500; color: #1c1e21;">' + username + '</span>';
                        html += '</div>';
                    });
                    html += '</div>';
                    likesModalContent.innerHTML = html;
                } else {
                    likesModalContent.innerHTML = '<div style="text-align: center; padding: 20px; color: #65676b;">No likes yet</div>';
                }
            })
            .catch(error => {
                console.error('Error fetching likes:', error);
                likesModalContent.innerHTML = '<div style="text-align: center; padding: 20px; color: #e41e3f;">Error loading likes</div>';
            });
        }
    </script>
</body>
</html>
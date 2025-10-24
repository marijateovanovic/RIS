<%@ include file="../layout.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${post.id == null ? 'New Post' : 'Edit Post'}" />
<link href="${pageContext.request.contextPath}/css/post-form.css" rel="stylesheet" type="text/css">
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
    
    .create-post-container {
        max-width: 680px;
        margin: 20px auto;
        padding: 0 16px;
    }
    
    .create-post-header {
        background: var(--facebook-card);
        border-bottom: 1px solid var(--facebook-border);
        padding: 16px 0;
        margin-bottom: 16px;
    }
    
    .header-content {
        max-width: 680px;
        margin: 0 auto;
        padding: 0 16px;
    }
    
    .create-title {
        color: var(--facebook-text);
        font-weight: 700;
        font-size: 1.5rem;
        margin-bottom: 4px;
    }
    
    .create-subtitle {
        color: var(--facebook-text-secondary);
        font-size: 0.9375rem;
        margin: 0;
    }
    
    .post-composer {
        background: var(--facebook-card);
        border: 1px solid var(--facebook-border);
        border-radius: 8px;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        padding: 16px;
        margin-bottom: 20px;
    }
    
    .composer-header {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 16px;
        padding-bottom: 16px;
        border-bottom: 1px solid var(--facebook-border);
    }
    
    .user-avatar {
        width: 40px;
        height: 40px;
        background: var(--facebook-blue);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
    }
    
    .user-info {
        flex: 1;
    }
    
    .username {
        font-weight: 600;
        color: var(--facebook-text);
        font-size: 0.9375rem;
    }
    
    .post-privacy {
        color: var(--facebook-blue);
        font-size: 0.8125rem;
        font-weight: 600;
    }
    
    .composer-input {
        width: 100%;
        border: none;
        resize: none;
        font-size: 1.5rem;
        font-family: inherit;
        color: var(--facebook-text);
        background: transparent;
        min-height: 60px;
        line-height: 1.3333;
    }
    
    .composer-input::placeholder {
        color: var(--facebook-text-secondary);
        font-weight: 400;
    }
    
    .composer-input:focus {
        outline: none;
    }
    
    .composer-content {
        width: 100%;
        border: none;
        resize: none;
        font-size: 1.0625rem;
        font-family: inherit;
        color: var(--facebook-text);
        background: transparent;
        min-height: 120px;
        line-height: 1.3333;
        margin-top: 12px;
    }
    
    .composer-content::placeholder {
        color: var(--facebook-text-secondary);
    }
    
    .composer-content:focus {
        outline: none;
    }
    
    .composer-actions {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 16px;
        padding-top: 16px;
        border-top: 1px solid var(--facebook-border);
    }
    
    .action-buttons {
        display: flex;
        gap: 8px;
    }
    
    .action-btn {
        background: none;
        border: none;
        color: var(--facebook-text-secondary);
        font-size: 1.25rem;
        cursor: pointer;
        padding: 8px;
        border-radius: 4px;
        transition: background-color 0.2s;
    }
    
    .action-btn:hover {
        background-color: var(--facebook-hover);
    }
    
    .post-btn {
        background-color: var(--facebook-blue);
        border: none;
        border-radius: 6px;
        padding: 8px 16px;
        font-weight: 600;
        color: white;
        transition: background-color 0.2s;
        cursor: pointer;
        font-size: 0.9375rem;
    }
    
    .post-btn:hover {
        background-color: var(--facebook-dark-blue);
    }
    
    .post-btn:disabled {
        background-color: #e4e6eb;
        color: var(--facebook-text-secondary);
        cursor: not-allowed;
    }
    
    .cancel-btn {
        background: none;
        border: none;
        color: var(--facebook-text-secondary);
        font-weight: 600;
        text-decoration: none;
        padding: 8px 16px;
        border-radius: 6px;
        transition: background-color 0.2s;
        font-size: 0.9375rem;
    }
    
    .cancel-btn:hover {
        background-color: var(--facebook-hover);
        color: var(--facebook-text);
    }
    
    .character-count {
        text-align: right;
        font-size: 0.8125rem;
        color: var(--facebook-text-secondary);
        margin-top: 8px;
    }
    
    .character-count.warning {
        color: #e41e3f;
        font-weight: 600;
    }
</style>
</head>
<body>

    <br><br>

    <!-- Post Composer -->
    <div class="create-post-container">
        <div class="post-composer">
            <!-- Composer Header -->
            <div class="composer-header">
                <div class="user-avatar">
                    <c:set var="firstLetter" value="${user.username.charAt(0)}" />
                    ${firstLetter}
                </div>
                <div class="user-info">
                    <div class="username">${user.username}</div>
                    <div class="post-privacy">
                        <i class="fas fa-globe-americas"></i> Public
                    </div>
                </div>
            </div>

            <!-- Post Inputs -->
            <input type="hidden" id="postId" value="${post.id}">
            
            <input type="text" id="title" class="composer-input" 
                   placeholder="What's on your mind?" 
                   value="${post.title}"
                   maxlength="200">
            
            <textarea id="content" class="composer-content" 
                      placeholder="Share your thoughts..."
                      maxlength="5000">${post.content}</textarea>
            
            <div class="character-count" id="titleCount">
                ${post.title != null ? post.title.length() : 0}/200
            </div>
            <div class="character-count" id="contentCount">
                ${post.content != null ? post.content.length() : 0}/5000
            </div>

            <!-- Composer Actions -->
            <div class="composer-actions">
                <div class="action-buttons">
                    <button class="action-btn" title="Add Photo">
                        <i class="fas fa-image"></i>
                    </button>
                    <button class="action-btn" title="Tag Friends">
                        <i class="fas fa-user-tag"></i>
                    </button>
                    <button class="action-btn" title="Add Feeling">
                        <i class="fas fa-smile"></i>
                    </button>
                    <button class="action-btn" title="Add Location">
                        <i class="fas fa-map-marker-alt"></i>
                    </button>
                </div>
                
                <div style="display: flex; gap: 8px; align-items: center;">
                    <a href="<c:url value='/posts/my' />" class="cancel-btn">
                        Cancel
                    </a>
                    <button class="post-btn" id="postButton" onclick="savePost()">
                        <c:choose>
                            <c:when test="${post.id == null}">
                                Post
                            </c:when>
                            <c:otherwise>
                                Save
                            </c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Character count functionality
        const titleInput = document.getElementById('title');
        const contentInput = document.getElementById('content');
        const titleCount = document.getElementById('titleCount');
        const contentCount = document.getElementById('contentCount');
        const postButton = document.getElementById('postButton');

        function updateCharacterCounts() {
            const titleLength = titleInput.value.length;
            const contentLength = contentInput.value.length;
            
            titleCount.textContent = `${titleLength}/200`;
            contentCount.textContent = `${contentLength}/5000`;
            
            // Update styles for warnings
            titleCount.className = `character-count ${titleLength > 180 ? 'warning' : ''}`;
            contentCount.className = `character-count ${contentLength > 4800 ? 'warning' : ''}`;
            
            // Enable/disable post button
            const hasContent = titleInput.value.trim() && contentInput.value.trim();
            postButton.disabled = !hasContent;
        }

        titleInput.addEventListener('input', updateCharacterCounts);
        contentInput.addEventListener('input', updateCharacterCounts);

        // Initialize counts
        updateCharacterCounts();

        function savePost() {
            const title = titleInput.value.trim();
            const content = contentInput.value.trim();
            
            if (!title || !content) {
                alert('Please add both a title and content to your post.');
                return;
            }

            const formData = new FormData();
            formData.append('id', document.getElementById('postId').value);
            formData.append('title', title);
            formData.append('content', content);
            
            // Show loading state
            const originalText = postButton.innerHTML;
            postButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            postButton.disabled = true;
            
            fetch('<c:url value="/posts/save" />', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                } else {
                    return response.text();
                }
            })
            .then(data => {
                console.log('Response:', data);
                // Reset button if there was an error
                postButton.innerHTML = originalText;
                postButton.disabled = false;
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error saving post');
                postButton.innerHTML = originalText;
                postButton.disabled = false;
            });
        }

        // Add auto-resize for content textarea
        contentInput.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });

        // Add focus effects
        titleInput.addEventListener('focus', function() {
            this.parentElement.style.backgroundColor = 'var(--facebook-hover)';
        });
        
        titleInput.addEventListener('blur', function() {
            this.parentElement.style.backgroundColor = 'transparent';
        });
        
        contentInput.addEventListener('focus', function() {
            this.style.backgroundColor = 'var(--facebook-hover)';
        });
        
        contentInput.addEventListener('blur', function() {
            this.style.backgroundColor = 'transparent';
        });
    </script>
</body>
</html>
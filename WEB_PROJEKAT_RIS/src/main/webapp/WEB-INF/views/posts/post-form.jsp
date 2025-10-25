<%@ include file="../layout.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${post.id == null ? 'New Post' : 'Edit Post'}" />
<link href="${pageContext.request.contextPath}/css/post-form.css" rel="stylesheet" type="text/css">
<script type="module" src="https://cdn.jsdelivr.net/npm/emoji-picker-element@^1/index.js"></script>
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
    
    .composer-content {
        width: 100%;
        border: none;
        resize: none;
        font-size: 1.5rem;
        font-family: inherit;
        color: var(--facebook-text);
        background: transparent;
        min-height: 150px;
        line-height: 1.3333;
        padding: 0;
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
    
    .emoji-picker-wrapper {
        position: absolute;
        bottom: 100%;
        left: 0;
        margin-bottom: 8px;
        z-index: 1000;
        display: none;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        border-radius: 8px;
        overflow: hidden;
    }
    
    .emoji-picker-wrapper.active {
        display: block;
        animation: slideUp 0.2s ease-out;
    }
    
    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    emoji-picker {
        --border-radius: 8px;
        --background: #ffffff;
        --border-color: #dddfe2;
        --category-emoji-size: 1.25rem;
        --emoji-size: 1.375rem;
        --indicator-color: #1877f2;
        --input-border-color: #dddfe2;
        --input-border-radius: 6px;
        --outline-color: #1877f2;
        width: 350px;
        height: 400px;
    }
    
    .action-btn.active {
        background-color: var(--facebook-blue);
        color: white;
    }
    
    .action-buttons {
        position: relative;
    }
    
    /* Step 7a: Image Upload Styles */
    .image-preview-container {
        margin-top: 16px;
        border-top: 1px solid var(--facebook-border);
        padding-top: 16px;
        display: none;
    }
    
    .image-preview-container.active {
        display: block;
    }
    
    .image-preview-wrapper {
        position: relative;
        width: 100%;
        border-radius: 8px;
        overflow: hidden;
        border: 1px solid var(--facebook-border);
    }
    
    .image-preview {
        width: 100%;
        max-height: 400px;
        object-fit: contain;
        background-color: #f0f2f5;
        display: block;
    }
    
    .image-remove-btn {
        position: absolute;
        top: 12px;
        right: 12px;
        background: rgba(0, 0, 0, 0.75);
        border: none;
        border-radius: 50%;
        width: 36px;
        height: 36px;
        color: white;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.2s, transform 0.1s;
        font-size: 1.125rem;
    }
    
    .image-remove-btn:hover {
        background: rgba(0, 0, 0, 0.9);
        transform: scale(1.1);
    }
    
    .image-file-input {
        display: none;
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
            <input type="hidden" id="existingImagePath" value="${post.imagePath}">
            <input type="hidden" id="removeImage" value="false">
            
            <textarea id="content" class="composer-content" 
                      placeholder="What's on your mind, ${user.username}?"
                      maxlength="5000">${post.content}</textarea>
            
            <div class="character-count" id="contentCount">
                ${post.content != null ? post.content.length() : 0}/5000
            </div>
            
            <!-- Step 7b: Image Preview Container -->
            <div class="image-preview-container" id="imagePreviewContainer">
                <div class="image-preview-wrapper">
                    <img id="imagePreview" class="image-preview" src="" alt="Image preview">
                    <button type="button" class="image-remove-btn" id="imageRemoveBtn" title="Remove image">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            </div>
            
            <!-- Step 7c: Hidden File Input -->
            <input type="file" id="imageInput" class="image-file-input" accept="image/*">

            <!-- Composer Actions -->
            <div class="composer-actions">
                <div class="action-buttons">
                    <button type="button" class="action-btn" id="imageBtn" title="Add Photo">
                        <i class="fas fa-image"></i>
                    </button>
                    <button type="button" class="action-btn" title="Tag Friends">
                        <i class="fas fa-user-tag"></i>
                    </button>
                    <button type="button" class="action-btn" id="emojiBtn" title="Add Emoji">
                        <i class="fas fa-smile"></i>
                    </button>
                    <button type="button" class="action-btn" title="Add Location">
                        <i class="fas fa-map-marker-alt"></i>
                    </button>
                    
                    <!-- Emoji Picker from Library -->
                    <div class="emoji-picker-wrapper" id="emojiPickerWrapper">
                        <emoji-picker id="emojiPicker"></emoji-picker>
                    </div>
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
        const contentInput = document.getElementById('content');
        const contentCount = document.getElementById('contentCount');
        const postButton = document.getElementById('postButton');
        
        const emojiBtn = document.getElementById('emojiBtn');
        const emojiPickerWrapper = document.getElementById('emojiPickerWrapper');
        const emojiPicker = document.getElementById('emojiPicker');
        let currentFocusedInput = contentInput; // Default to content input
        
        const imageBtn = document.getElementById('imageBtn');
        const imageInput = document.getElementById('imageInput');
        const imagePreviewContainer = document.getElementById('imagePreviewContainer');
        const imagePreview = document.getElementById('imagePreview');
        const imageRemoveBtn = document.getElementById('imageRemoveBtn');
        let selectedImageFile = null;
        
        emojiBtn.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            emojiPickerWrapper.classList.toggle('active');
            emojiBtn.classList.toggle('active');
        });
        
        emojiPicker.addEventListener('emoji-click', (event) => {
            const emoji = event.detail.unicode;
            const input = currentFocusedInput;
            const start = input.selectionStart;
            const end = input.selectionEnd;
            const text = input.value;
            
            input.value = text.substring(0, start) + emoji + text.substring(end);
        
            const newPosition = start + emoji.length;
            input.setSelectionRange(newPosition, newPosition);
            input.focus();
            
            updateCharacterCounts();
            
        });
        
        contentInput.addEventListener('focus', () => {
            currentFocusedInput = contentInput;
        });
        
        document.addEventListener('click', (e) => {
            if (!emojiPickerWrapper.contains(e.target) && e.target !== emojiBtn && !emojiBtn.contains(e.target)) {
                emojiPickerWrapper.classList.remove('active');
                emojiBtn.classList.remove('active');
            }
        });
        
        imageBtn.addEventListener('click', (e) => {
            e.preventDefault();
            imageInput.click();
        });
        
        imageInput.addEventListener('change', (e) => {
            const file = e.target.files[0];
            if (file) {
                if (!file.type.startsWith('image/')) {
                    alert('Please select an image file');
                    imageInput.value = '';
                    return;
                }
                
                if (file.size > 10 * 1024 * 1024) {
                    alert('Image size must be less than 10MB');
                    imageInput.value = '';
                    return;
                }
                
                selectedImageFile = file;
                document.getElementById('removeImage').value = 'false';
            
                const reader = new FileReader();
                reader.onload = (e) => {
                    imagePreview.src = e.target.result;
                    imagePreviewContainer.classList.add('active');
                    imageBtn.classList.add('active');
                };
                reader.readAsDataURL(file);
            }
        });
        
        imageRemoveBtn.addEventListener('click', (e) => {
            e.preventDefault();
            selectedImageFile = null;
            imageInput.value = '';
            imagePreview.src = '';
            imagePreviewContainer.classList.remove('active');
            imageBtn.classList.remove('active');

            document.getElementById('removeImage').value = 'true';
        });
        
        const existingImagePath = document.getElementById('existingImagePath').value;
        if (existingImagePath && existingImagePath !== 'null' && existingImagePath !== '') {
            imagePreview.src = '${pageContext.request.contextPath}' + existingImagePath;
            imagePreviewContainer.classList.add('active');
            imageBtn.classList.add('active');
        }

        function updateCharacterCounts() {
            const contentLength = contentInput.value.length;
            
            contentCount.textContent = `${contentLength}/5000`;
            
            contentCount.className = `character-count ${contentLength > 4800 ? 'warning' : ''}`;
            
            
            const hasContent = contentInput.value.trim();
            postButton.disabled = !hasContent;
        }

        contentInput.addEventListener('input', updateCharacterCounts);

        // Initialize counts
        updateCharacterCounts();

        function savePost() {
            const content = contentInput.value.trim();
            
            if (!content) {
                alert('Please add content to your post.');
                return;
            }

            // Get CSRF token
            const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

            const formData = new FormData();
            formData.append('id', document.getElementById('postId').value);
            formData.append('title', 'Post');  
            formData.append('content', content);
            
            formData.append('removeImage', document.getElementById('removeImage').value);

            if (selectedImageFile) {
                formData.append('image', selectedImageFile);
                console.log('Including image in upload:', selectedImageFile.name);
            }
            
            // Show loading state
            const originalText = postButton.innerHTML;
            postButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            postButton.disabled = true;
            
            fetch('<c:url value="/posts/save" />', {
                method: 'POST',
                headers: {
                    [csrfHeader]: csrfToken
                },
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
        contentInput.addEventListener('focus', function() {
            this.style.backgroundColor = 'var(--facebook-hover)';
        });
        
        contentInput.addEventListener('blur', function() {
            this.style.backgroundColor = 'transparent';
        });
    </script>
</body>
</html>
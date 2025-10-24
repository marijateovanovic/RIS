<%@ include file="../layout.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="Messages" />
<link href="<c:url value='/css/messages.css' />" rel="stylesheet">
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
    
    body {
        background-color: var(--facebook-bg);
    }
    
    .messages-header {
        background: var(--facebook-card);
        border-bottom: 1px solid var(--facebook-border);
        padding: 16px 0;
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
    
    .main-title {
        color: var(--facebook-text);
        font-weight: 700;
        font-size: 1.5rem;
        margin-bottom: 4px;
    }
    
    .subtitle {
        color: var(--facebook-text-secondary);
        font-size: 0.9375rem;
        margin: 0;
    }
    
    .messages-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 16px;
    }
    
    .messages-layout {
        display: grid;
        grid-template-columns: 360px 1fr;
        gap: 16px;
        align-items: start;
    }
    
    .message-card {
        background: var(--facebook-card);
        border-radius: 8px;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }
    
    .card-header {
        padding: 16px;
        border-bottom: 1px solid var(--facebook-border);
        background: var(--facebook-card);
    }
    
    .card-header h5 {
        font-weight: 600;
        color: var(--facebook-text);
        font-size: 1.0625rem;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .card-header h5 i {
        color: var(--facebook-blue);
    }
    
    .card-body {
        padding: 16px;
    }
    
    .friends-list {
        display: flex;
        flex-direction: column;
        gap: 0;
    }
    
    .friend-item {
        transition: background-color 0.2s;
    }
    
    .friend-link {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px;
        text-decoration: none;
        color: var(--facebook-text);
        transition: background-color 0.2s;
        border-radius: 6px;
        margin: 2px 0;
    }
    
    .friend-link:hover {
        background-color: var(--facebook-hover);
        text-decoration: none;
        color: var(--facebook-text);
    }
    
    .friend-avatar {
        width: 36px;
        height: 36px;
        background: var(--facebook-blue);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 0.875rem;
        flex-shrink: 0;
    }
    
    .friend-info {
        flex: 1;
        min-width: 0;
    }
    
    .friend-name {
        font-weight: 600;
        color: var(--facebook-text);
        font-size: 0.9375rem;
        margin-bottom: 2px;
    }
    
    .last-message {
        color: var(--facebook-text-secondary);
        font-size: 0.8125rem;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .online-indicator {
        width: 8px;
        height: 8px;
        background: var(--facebook-green);
        border-radius: 50%;
        flex-shrink: 0;
    }
    
    .empty-state {
        text-align: center;
        padding: 40px 20px;
    }
    
    .empty-icon {
        font-size: 3rem;
        color: #bec3c9;
        margin-bottom: 16px;
    }
    
    .empty-title {
        font-weight: 600;
        color: var(--facebook-text);
        font-size: 1.125rem;
        margin-bottom: 8px;
    }
    
    .empty-subtitle {
        color: var(--facebook-text-secondary);
        font-size: 0.9375rem;
        margin-bottom: 20px;
    }
    
    .btn-primary {
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
    }
    
    .btn-primary:hover {
        background-color: var(--facebook-dark-blue);
        color: white;
        text-decoration: none;
    }
    
    .welcome-state {
        text-align: center;
        padding: 60px 40px;
    }
    
    .welcome-icon {
        font-size: 4rem;
        color: #bec3c9;
        margin-bottom: 20px;
    }
    
    .welcome-title {
        font-weight: 700;
        color: var(--facebook-text);
        font-size: 1.5rem;
        margin-bottom: 12px;
    }
    
    .welcome-subtitle {
        color: var(--facebook-text-secondary);
        font-size: 0.9375rem;
        line-height: 1.5;
        margin-bottom: 30px;
    }
    
    .features-list {
        display: flex;
        justify-content: center;
        gap: 30px;
        margin-top: 30px;
        flex-wrap: wrap;
    }
    
    .feature-item {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 600;
        color: var(--facebook-text);
        font-size: 0.875rem;
    }
    
    .feature-item i {
        font-size: 1rem;
    }
    
    .text-primary { color: var(--facebook-blue) !important; }
    .text-warning { color: #f0c020 !important; }
    .text-success { color: var(--facebook-green) !important; }
    
    /* Responsive design */
    @media (max-width: 768px) {
        .messages-layout {
            grid-template-columns: 1fr;
            gap: 12px;
        }
        
        .header-content {
            flex-direction: column;
            gap: 12px;
            text-align: center;
        }
        
        .welcome-state {
            padding: 40px 20px;
        }
        
        .welcome-icon {
            font-size: 3rem;
        }
        
        .features-list {
            gap: 20px;
            flex-direction: column;
        }
    }
</style>
</head>
<body>

    <br><br>

    <!-- Messages Content -->
    <div class="messages-container">
        <div class="messages-layout">
            <!-- Friends List Card -->
            <div class="message-card">
                <div class="card-header">
                    <h5><i class="fas fa-users"></i> Your Friends</h5>
                </div>
                <div class="card-body">
                    <div class="friends-list">
                        <c:forEach items="${friends}" var="friend">
                            <div class="friend-item">
                                <a href="<c:url value='/messages/conversation/${friend.id}' />" 
                                   class="friend-link">
                                    <div class="friend-avatar">
                                        ${friend.username.charAt(0)}
                                    </div>
                                    <div class="friend-info">
                                        <div class="friend-name">${friend.username}</div>
                                        <div class="last-message">Click to start chatting</div>
                                    </div>
                                    <div class="online-indicator"></div>
                                </a>
                            </div>
                        </c:forEach>
                        <c:if test="${empty friends}">
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <i class="fas fa-user-friends"></i>
                                </div>
                                <h5 class="empty-title">No Friends Yet</h5>
                                <p class="empty-subtitle">Add friends to start messaging</p>
                                <a href="<c:url value='/friends' />" class="btn-primary">
                                    <i class="fas fa-user-plus"></i> Find Friends
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Welcome/Empty State Card -->
            <div class="message-card">
                <div class="card-body">
                    <div class="welcome-state">
                        <div class="welcome-icon">
                            <i class="fas fa-comments"></i>
                        </div>
                        <h3 class="welcome-title">Welcome to Messages</h3>
                        <p class="welcome-subtitle">
                            Select a friend from the list to start a conversation.<br>
                            Share your thoughts, ideas, and stay connected with your friends.
                        </p>
                        <div class="features-list">
                            <div class="feature-item">
                                <i class="fas fa-shield-alt text-primary"></i>
                                <span>Secure & Private</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-bolt text-warning"></i>
                                <span>Instant Delivery</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-users text-success"></i>
                                <span>Friends Only</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Add hover effects to friend items
        document.addEventListener('DOMContentLoaded', function() {
            const friendLinks = document.querySelectorAll('.friend-link');
            
            friendLinks.forEach(link => {
                link.addEventListener('mouseenter', function() {
                    this.style.backgroundColor = 'var(--facebook-hover)';
                });
                
                link.addEventListener('mouseleave', function() {
                    this.style.backgroundColor = '';
                });
            });
            
            // Add loading state to buttons
            const primaryButtons = document.querySelectorAll('.btn-primary');
            primaryButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    if (this.getAttribute('href') === '<c:url value='/friends' />') {
                        this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
                        this.style.pointerEvents = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>
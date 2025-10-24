<%@ include file="../layout.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="Chat with ${friend.username}" />
<link href="<c:url value='/css/chat.css' />" rel="stylesheet">
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
        --message-sent-bg: #0084ff;
        --message-received-bg: #e4e6eb;
    }
    
    body {
        background-color: var(--facebook-bg);
        margin: 0;
        padding: 0;
    }
    
    .chat-header {
        background: var(--facebook-card);
        border-bottom: 1px solid var(--facebook-border);
        padding: 12px 0;
        position: sticky;
        top: 0;
        z-index: 100;
    }
    
    .header-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 16px;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .friend-avatar-large {
        width: 40px;
        height: 40px;
        background: var(--facebook-blue);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 1rem;
        flex-shrink: 0;
    }
    
    .friend-info-large {
        flex: 1;
    }
    
    .friend-name-large {
        font-weight: 600;
        color: var(--facebook-text);
        font-size: 1.0625rem;
        margin-bottom: 2px;
    }
    
    .friend-status {
        color: var(--facebook-text-secondary);
        font-size: 0.8125rem;
    }
    
    .online-indicator-large {
        width: 8px;
        height: 8px;
        background: var(--facebook-green);
        border-radius: 50%;
        margin-left: 8px;
    }
    
    .chat-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 16px;
        height: calc(100vh - 80px);
    }
    
    .chat-layout {
        display: grid;
        grid-template-columns: 320px 1fr;
        gap: 16px;
        height: 100%;
    }
    
    .chat-card {
        background: var(--facebook-card);
        border-radius: 8px;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        height: 100%;
        display: flex;
        flex-direction: column;
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
        padding: 0;
        flex: 1;
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }
    
    .friends-list {
        flex: 1;
        overflow-y: auto;
    }
    
    .friend-item {
        transition: background-color 0.2s;
    }
    
    .friend-link {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 16px;
        text-decoration: none;
        color: var(--facebook-text);
        transition: background-color 0.2s;
        border-left: 3px solid transparent;
    }
    
    .friend-link:hover {
        background-color: var(--facebook-hover);
        text-decoration: none;
        color: var(--facebook-text);
    }
    
    .friend-link.active {
        background-color: var(--facebook-hover);
        border-left-color: var(--facebook-blue);
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
    
    /* Chat Area Styles */
    .chat-area {
        display: flex;
        flex-direction: column;
        height: 100%;
    }
    
    .messages-container {
        flex: 1;
        overflow-y: auto;
        padding: 16px;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
    
    .message-bubble {
        max-width: 70%;
        padding: 8px 12px;
        border-radius: 18px;
        position: relative;
        word-wrap: break-word;
    }
    
    .message-sent {
        align-self: flex-end;
        background-color: var(--message-sent-bg);
        color: white;
        border-bottom-right-radius: 4px;
    }
    
    .message-received {
        align-self: flex-start;
        background-color: var(--message-received-bg);
        color: var(--facebook-text);
        border-bottom-left-radius: 4px;
    }
    
    .message-sender {
        font-size: 0.75rem;
        font-weight: 600;
        margin-bottom: 2px;
        opacity: 0.9;
    }
    
    .message-content {
        font-size: 0.9375rem;
        line-height: 1.4;
        margin-bottom: 2px;
    }
    
    .message-time {
        font-size: 0.75rem;
        opacity: 0.7;
        text-align: right;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        gap: 4px;
    }
    
    .message-status {
        font-size: 0.625rem;
    }
    
    .empty-chat {
        text-align: center;
        padding: 60px 20px;
        color: var(--facebook-text-secondary);
    }
    
    .empty-chat-icon {
        font-size: 3rem;
        color: #bec3c9;
        margin-bottom: 16px;
    }
    
    .empty-chat-title {
        font-weight: 600;
        color: var(--facebook-text);
        font-size: 1.125rem;
        margin-bottom: 8px;
    }
    
    .empty-chat-subtitle {
        font-size: 0.9375rem;
        opacity: 0.8;
    }
    
    .message-input-area {
        padding: 16px;
        border-top: 1px solid var(--facebook-border);
        background: var(--facebook-card);
    }
    
    .input-group {
        display: flex;
        gap: 8px;
        align-items: flex-end;
    }
    
    .message-input {
        flex: 1;
        border: 1px solid var(--facebook-border);
        border-radius: 20px;
        padding: 12px 16px;
        font-size: 0.9375rem;
        background: var(--facebook-bg);
        resize: none;
        min-height: 44px;
        max-height: 120px;
    }
    
    .message-input:focus {
        outline: none;
        border-color: var(--facebook-blue);
        background: white;
    }
    
    .send-button {
        background-color: var(--facebook-blue);
        border: none;
        border-radius: 20px;
        padding: 12px 20px;
        color: white;
        font-weight: 600;
        font-size: 0.9375rem;
        cursor: pointer;
        transition: background-color 0.2s;
        display: flex;
        align-items: center;
        gap: 6px;
        white-space: nowrap;
    }
    
    .send-button:hover {
        background-color: var(--facebook-dark-blue);
    }
    
    .send-button:disabled {
        background-color: var(--facebook-text-secondary);
        cursor: not-allowed;
    }
    
    /* Responsive Design */
    @media (max-width: 768px) {
        .chat-layout {
            grid-template-columns: 1fr;
        }
        
        .chat-card:first-child {
            display: none;
        }
        
        .message-bubble {
            max-width: 85%;
        }
        
        .chat-container {
            padding: 8px;
            height: calc(100vh - 60px);
        }
    }
</style>
</head>
<body>

    <br><br>

    <!-- Chat Content -->
    <div class="chat-container">
        <div class="chat-layout">
            <!-- Friends List Card -->
            <div class="chat-card">
                <div class="card-header">
                    <h5><i class="fas fa-users"></i> Your Friends</h5>
                </div>
                <div class="card-body">
                    <div class="friends-list">
                        <c:forEach items="${friends}" var="f">
                            <div class="friend-item">
                                <a href="<c:url value='/messages/conversation/${f.id}' />" 
                                   class="friend-link ${f.id == friend.id ? 'active' : ''}">
                                    <div class="friend-avatar">
                                        ${f.username.charAt(0)}
                                    </div>
                                    <div class="friend-info">
                                        <div class="friend-name">${f.username}</div>
                                        <c:if test="${f.id == friend.id}">
                                            <div class="last-message">Active now</div>
                                        </c:if>
                                    </div>
                                    <c:if test="${f.id == friend.id}">
                                        <div class="online-indicator"></div>
                                    </c:if>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Chat Area Card -->
            <div class="chat-card">
                <div class="card-body">
                    <div class="chat-area">
                        <!-- Messages Container -->
                        <div id="messageContainer" class="messages-container">
                            <c:forEach items="${conversation}" var="message">
                                <div class="message-bubble ${message.idUser1.id == user.id ? 'message-sent' : 'message-received'}">
                                    <c:if test="${message.idUser1.id != user.id}">
                                        <div class="message-sender">
                                            ${message.idUser1.username}
                                        </div>
                                    </c:if>
                                    <div class="message-content">
                                        ${message.content}
                                    </div>
                                    <div class="message-time">
                                        ${message.sentAt}
                                        <c:if test="${message.idUser1.id == user.id}">
                                            <span class="message-status">✓✓</span>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty conversation}">
                                <div class="empty-chat">
                                    <div class="empty-chat-icon">
                                        <i class="fas fa-comment-dots"></i>
                                    </div>
                                    <h3 class="empty-chat-title">No messages yet</h3>
                                    <p class="empty-chat-subtitle">Start the conversation by sending a message!</p>
                                </div>
                            </c:if>
                        </div>

                        <!-- Message Input Area -->
                        <div class="message-input-area">
                            <div class="input-group">
                                <input type="text" id="messageInput" class="message-input" 
                                       placeholder="Type your message..." required>
                                <button type="button" id="sendButton" class="send-button">
                                    <i class="fas fa-paper-plane"></i>
                                    Send
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script>
// Function to send message
function sendMessage() {
    const messageInput = document.getElementById('messageInput');
    const sendButton = document.getElementById('sendButton');
    const messageContent = messageInput.value.trim();
    
    if (!messageContent) {
        messageInput.focus();
        return;
    }
    
    // Store original values
    const originalButtonHTML = sendButton.innerHTML;
    
    // Show loading state
    messageInput.disabled = true;
    sendButton.disabled = true;
    sendButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
    
    const formData = new FormData();
    formData.append('receiverId', ${friend.id});
    formData.append('content', messageContent);
    
    // Add CSRF token
    const csrfMeta = document.querySelector('meta[name="_csrf"]');
    if (csrfMeta) {
        formData.append('_csrf', csrfMeta.getAttribute('content'));
    }
    
    fetch("<c:url value='/messages/send' />", {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (response.redirected) {
            window.location.href = response.url;
            return;
        }
        
        if (response.ok) {
            window.location.reload();
            return;
        }
        
        throw new Error('Failed to send message');
    })
    .catch(error => {
        // Show error message
        const errorDiv = document.createElement('div');
        errorDiv.style.cssText = `
            background: #f8d7da;
            color: #721c24;
            padding: 12px 16px;
            border-radius: 8px;
            margin: 8px 16px;
            border: 1px solid #f5c6cb;
            font-size: 0.875rem;
        `;
        errorDiv.innerHTML = `
            <strong>Failed to send message</strong><br>
            Please try again.
        `;
        
        const messageContainer = document.getElementById('messageContainer');
        messageContainer.parentNode.insertBefore(errorDiv, messageContainer.nextSibling);
        
        // Auto-remove error after 5 seconds
        setTimeout(() => {
            if (errorDiv.parentNode) {
                errorDiv.parentNode.removeChild(errorDiv);
            }
        }, 5000);
    })
    .finally(() => {
        // Reset UI state
        messageInput.disabled = false;
        sendButton.disabled = false;
        sendButton.innerHTML = originalButtonHTML;
        messageInput.value = '';
        messageInput.focus();
    });
}

// Function to send message on Enter key
function handleKeyPress(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
}

// Function to auto-scroll to bottom of messages
function scrollToBottom() {
    const messageContainer = document.getElementById('messageContainer');
    if (messageContainer) {
        messageContainer.scrollTop = messageContainer.scrollHeight;
    }
}

// Setup event listeners when page loads
document.addEventListener('DOMContentLoaded', function() {
    // Auto-scroll to bottom of messages
    scrollToBottom();
    
    // Setup send button click
    const sendButton = document.getElementById('sendButton');
    if (sendButton) {
        sendButton.addEventListener('click', sendMessage);
    }
    
    // Setup Enter key press
    const messageInput = document.getElementById('messageInput');
    if (messageInput) {
        messageInput.addEventListener('keypress', handleKeyPress);
        messageInput.focus(); // Focus on input when page loads
    }
});

// Function to refresh messages without reloading the page
function refreshMessages() {
    fetch(window.location.href, {
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        }
    })
    .then(response => response.text())
    .then(html => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');
        const newMessageContainer = doc.getElementById('messageContainer');
        
        if (newMessageContainer) {
            const currentContainer = document.getElementById('messageContainer');
            currentContainer.innerHTML = newMessageContainer.innerHTML;
            scrollToBottom();
        }
    })
    .catch(error => {
        console.log('Auto-refresh failed');
    });
}
</script>
</body>
</html>
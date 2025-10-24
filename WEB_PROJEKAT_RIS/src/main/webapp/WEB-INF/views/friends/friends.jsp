<%@ include file="../layout.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="Friends" />

<!-- CSRF Protection -->
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link href="${pageContext.request.contextPath}/css/friends.css" rel="stylesheet" type="text/css">
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
    
    .friends-header {
        background: var(--facebook-card);
        border-bottom: 1px solid var(--facebook-border);
        padding: 20px 0;
        margin-bottom: 16px;
    }
    
    .header-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 16px;
        text-align: center;
    }
    
    .friends-title {
        color: var(--facebook-text);
        font-weight: 700;
        font-size: 1.5rem;
        margin-bottom: 4px;
    }
    
    .friends-subtitle {
        color: var(--facebook-text-secondary);
        font-size: 0.9375rem;
        margin: 0;
    }
    
    .friends-main {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 16px;
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
        display: flex;
        align-items: center;
        gap: 12px;
        flex: 1;
    }
    
    .friend-name {
        font-weight: 600;
        color: var(--facebook-text);
        font-size: 0.9375rem;
    }
    
    .friend-status {
        color: var(--facebook-text-secondary);
        font-size: 0.8125rem;
        margin-top: 2px;
    }
    
    .friend-actions {
        display: flex;
        gap: 8px;
    }
    
    .btn-confirm {
        background-color: var(--facebook-blue);
        border: none;
        border-radius: 6px;
        padding: 6px 12px;
        color: white;
        font-weight: 600;
        font-size: 0.8125rem;
        cursor: pointer;
        transition: background-color 0.2s;
        display: flex;
        align-items: center;
        gap: 4px;
    }
    
    .btn-confirm:hover {
        background-color: var(--facebook-dark-blue);
    }
    
    .btn-delete {
        background-color: #e4e6eb;
        border: none;
        border-radius: 6px;
        padding: 6px 12px;
        color: var(--facebook-text);
        font-weight: 600;
        font-size: 0.8125rem;
        cursor: pointer;
        transition: background-color 0.2s;
        display: flex;
        align-items: center;
        gap: 4px;
    }
    
    .btn-delete:hover {
        background-color: #d8dadf;
    }
    
    .btn-add {
        background-color: var(--facebook-blue);
        border: none;
        border-radius: 6px;
        padding: 6px 12px;
        color: white;
        font-weight: 600;
        font-size: 0.8125rem;
        cursor: pointer;
        transition: background-color 0.2s;
        display: flex;
        align-items: center;
        gap: 4px;
    }
    
    .btn-add:hover {
        background-color: var(--facebook-dark-blue);
    }
    
    .btn-message {
        background-color: #e4e6eb;
        border: none;
        border-radius: 6px;
        padding: 6px 12px;
        color: var(--facebook-text);
        font-weight: 600;
        font-size: 0.8125rem;
        text-decoration: none;
        transition: background-color 0.2s;
        display: flex;
        align-items: center;
        gap: 4px;
    }
    
    .btn-message:hover {
        background-color: #d8dadf;
        color: var(--facebook-text);
    }
    
    .pending-badge {
        background: #f0c020;
        color: white;
        padding: 2px 6px;
        border-radius: 10px;
        font-size: 0.75rem;
        font-weight: 600;
        margin-left: 8px;
    }
</style>
</head>
<body>

    <br><br>

    <!-- Friends Content -->
    <div class="friends-main">
        <div class="friends-grid">
            <!-- Friend Requests Card -->
            <div class="friend-card">
                <div class="card-header">
                    <h5><i class="fas fa-user-clock"></i> Accept Friend Requests</h5>
                </div>
                <div class="card-body">
                    <c:forEach items="${pendingRequests}" var="request">
                        <div class="friend-item">
                            <div class="friend-info">
                                <div class="friend-avatar">
                                    <c:set var="firstLetter" value="${request.idUser1.username.charAt(0)}" />
                                    ${firstLetter}
                                </div>
                                <div>
                                    <div class="friend-name">${request.idUser1.username}</div>
                                    <div class="friend-status">
                                        <span class="pending-badge">Request Sent</span>
                                    </div>
                                </div>
                            </div>
                            <div class="friend-actions">
                                <button type="button" class="btn-confirm"
                                    onclick="handleFriendRequestNoCSRF(${request.id}, 'accept')">
                                    <i class="fas fa-check"></i> Confirm
                                </button>
                                <button type="button" class="btn-delete"
                                    onclick="handleFriendRequestNoCSRF(${request.id}, 'reject')">
                                    <i class="fas fa-times"></i> Delete
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty pendingRequests}">
                        <div class="empty-state">
                            <div class="empty-icon">
                                <i class="fas fa-user-clock"></i>
                            </div>
                            <h5 class="empty-title">No Friend Requests</h5>
                            <p class="empty-subtitle">When someone sends you a friend request, it will appear here</p>
                        </div>
                    </c:if>
                </div>
            </div>

            

            <!-- People You May Know Card -->
            <div class="friend-card">
                <div class="card-header">
                    <h5><i class="fas fa-user-plus"></i> Send Friend Request</h5>
                </div>
                <div class="card-body">
                    <c:forEach items="${allUsers}" var="otherUser">
                        <div class="friend-item">
                            <div class="friend-info">
                                <div class="friend-avatar">
                                    <c:set var="firstLetter" value="${otherUser.username.charAt(0)}" />
                                    ${firstLetter}
                                </div>
                                <div>
                                    <div class="friend-name">${otherUser.username}</div>
                                    <div class="friend-status">Add as friend</div>
                                </div>
                            </div>
                            <div class="friend-actions">
                                <button type="button" class="btn-add"
                                    data-user-id="${otherUser.id}"
                                    onclick="sendFriendRequestData(this)">
                                    <i class="fas fa-user-plus"></i> Add Friend
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

	<script>
console.log('=== SCRIPT START ===');

// Function to handle accepting/rejecting friend requests - NO CSRF IN HEADERS
function handleFriendRequestNoCSRF(requestId, action) {
    console.log('No-CSRF - Handling friend request:', requestId, action);
    
    const button = event.target;
    const originalText = button.textContent;
    button.textContent = 'Processing...';
    button.disabled = true;
    
    let url;
    if (action === 'accept') {
        url = '/FacebookCopy/friends/request/accept/' + requestId;
    } else {
        url = '/FacebookCopy/friends/request/reject/' + requestId;
    }
    
    console.log('Making request to:', url);
    
    // Create form data and try to add CSRF token if available
    const formData = new FormData();
    
    // Check if we have a CSRF token from meta tags
    const csrfMeta = document.querySelector('meta[name="_csrf"]');
    if (csrfMeta && csrfMeta.getAttribute('content')) {
        formData.append('_csrf', csrfMeta.getAttribute('content'));
        console.log('Added CSRF token to form data');
    }
    
    fetch(url, {
        method: 'POST',
        body: formData
    })
    .then(response => {
        console.log('Response status:', response.status);
        console.log('Response URL:', response.url);
        
        if (response.redirected) {
            console.log('Success - following redirect');
            window.location.href = response.url;
        } else if (response.ok) {
            console.log('Success - reloading page');
            window.location.reload();
        } else {
            throw new Error(`Server returned ${response.status}`);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        button.disabled = false;
        button.textContent = originalText;
        alert('Error: ' + error.message);
    });
}

// Fixed sendFriendRequestData function - NO CSRF HEADERS
function sendFriendRequestData(buttonElement) {
    const receiverId = buttonElement.getAttribute('data-user-id');
    const originalText = buttonElement.textContent;
    
    console.log('Sending friend request to user ID:', receiverId);
    
    buttonElement.textContent = 'Sending...';
    buttonElement.disabled = true;
    
    // Use FormData instead of URLSearchParams (simpler)
    const formData = new FormData();
    formData.append('receiverId', receiverId);
    
    // Try to add CSRF token if available
    const csrfMeta = document.querySelector('meta[name="_csrf"]');
    if (csrfMeta && csrfMeta.getAttribute('content')) {
        formData.append('_csrf', csrfMeta.getAttribute('content'));
        console.log('Added CSRF token to request');
    }
    
    const url = "/FacebookCopy/friends/request/send";
    console.log('Making request to:', url);
    
    // NO HEADERS - let the browser set content-type automatically for FormData
    fetch(url, {
        method: 'POST',
        body: formData
    })
    .then(response => {
        console.log('Response status:', response.status);
        console.log('Response redirected:', response.redirected);
        
        if (response.redirected) {
            buttonElement.textContent = 'Request Sent!';
            buttonElement.style.backgroundColor = '#e4e6eb';
            buttonElement.style.color = 'var(--facebook-text)';
            console.log('Success - following redirect');
            window.location.href = response.url;
        } else if (response.ok) {
            buttonElement.textContent = 'Request Sent!';
            buttonElement.style.backgroundColor = '#e4e6eb';
            buttonElement.style.color = 'var(--facebook-text)';
            console.log('Success - reloading page');
            window.location.reload();
        } else {
            throw new Error(`Server returned ${response.status}`);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        buttonElement.disabled = false;
        buttonElement.textContent = originalText;
        alert('Failed to send friend request: ' + error.message);
    });
}

// Simple test function to check if endpoints are reachable
function testEndpoints() {
    console.log('=== TESTING ENDPOINTS ===');
    
    // Test if we can reach the endpoints with a simple GET request
    const endpoints = [
        '/FacebookCopy/friends/request/send',
        '/FacebookCopy/friends/request/accept/1',
        '/FacebookCopy/friends/request/reject/1'
    ];
    
    endpoints.forEach(endpoint => {
        fetch(endpoint, { method: 'GET' })
        .then(response => {
            console.log(`GET ${endpoint}: ${response.status}`);
        })
        .catch(error => {
            console.log(`GET ${endpoint}: Error - ${error.message}`);
        });
    });
}

// Check Spring Security CSRF configuration
function checkCSRFConfig() {
    console.log('=== CSRF CONFIG CHECK ===');
    
    // Check if meta tags exist and have content
    const csrfMeta = document.querySelector('meta[name="_csrf"]');
    const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
    
    console.log('CSRF Meta exists:', !!csrfMeta);
    console.log('CSRF Header Meta exists:', !!csrfHeaderMeta);
    
    if (csrfMeta) {
        console.log('CSRF Meta content length:', csrfMeta.getAttribute('content')?.length || 0);
        console.log('CSRF Meta content:', csrfMeta.getAttribute('content'));
    }
    
    if (csrfHeaderMeta) {
        console.log('CSRF Header Meta content:', csrfHeaderMeta.getAttribute('content'));
    }
}

// Debug on load
document.addEventListener('DOMContentLoaded', function() {
    console.log('=== PAGE LOADED ===');
    console.log('Current URL:', window.location.href);
    
    checkCSRFConfig();
    testEndpoints();
});

console.log('=== SCRIPT END ===');
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title><c:out value="${pageTitle}" /> - Blog</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/layout.css" rel="stylesheet" type="text/css">
<style>
.nav-create-btn {
    background-color: var(--facebook-blue);
    border: none;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    transition: background-color 0.2s;
}

.nav-create-btn:hover {
    background-color: var(--facebook-dark-blue);
    text-decoration: none;
}

.nav-create-btn i {
    color: white;
    font-size: 1rem;
}
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
    
    .facebook-navbar {
        background-color: #ffffff;
        border-bottom: 1px solid var(--facebook-border);
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        padding: 0 16px;
        height: 56px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
    }
    
    .nav-brand {
        color: var(--facebook-blue);
        font-weight: bold;
        font-size: 1.5rem;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .nav-menu {
        display: flex;
        align-items: center;
        gap: 4px;
        margin: 0;
        padding: 0;
        list-style: none;
    }
    
    .nav-item {
        margin: 0 2px;
    }
    
    .nav-link {
        color: var(--facebook-text-secondary);
        font-weight: 600;
        padding: 8px 12px;
        border-radius: 6px;
        transition: background-color 0.2s;
        text-decoration: none;
        font-size: 0.9375rem;
        display: flex;
        align-items: center;
        gap: 6px;
        white-space: nowrap;
    }
    
    .nav-link:hover {
        background-color: var(--facebook-hover);
        color: var(--facebook-text);
    }
    
    .nav-link.active {
        background-color: var(--facebook-blue);
        color: white;
    }
    
    .logout-btn {
        background: none;
        border: none;
        color: var(--facebook-text-secondary);
        cursor: pointer;
        font-weight: 600;
        padding: 8px 12px;
        border-radius: 6px;
        transition: background-color 0.2s;
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 0.9375rem;
    }
    
    .logout-btn:hover {
        background-color: var(--facebook-hover);
        color: var(--facebook-text);
    }
    
    .main-content {
        margin-top: 56px;
        min-height: calc(100vh - 56px);
    }
    
    .user-avatar {
        width: 28px;
        height: 28px;
        background: var(--facebook-blue);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 0.75rem;
        overflow: hidden;
    }
    
    .user-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    /* Notification Badge */
    .notification-badge {
        position: relative;
    }
    
    .badge-count {
        position: absolute;
        top: -6px;
        right: -6px;
        background: #e41e3f;
        color: white;
        font-size: 0.625rem;
        font-weight: 700;
        min-width: 18px;
        height: 18px;
        border-radius: 9px;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 0 4px;
        border: 2px solid white;
        display: none;
    }
    
    .badge-count.active {
        display: flex;
    }
    
    /* Search Bar Styles */
    .search-container {
        position: relative;
        flex: 1;
        max-width: 600px;
        margin: 0 16px;
    }
    
    .search-input {
        width: 100%;
        padding: 10px 16px 10px 40px;
        border: none;
        border-radius: 50px;
        background-color: var(--facebook-bg);
        color: var(--facebook-text);
        font-size: 15px;
        outline: none;
        transition: background-color 0.2s;
    }
    
    .search-input:focus {
        background-color: #ffffff;
        box-shadow: 0 0 0 2px var(--facebook-blue);
    }
    
    .search-icon {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--facebook-text-secondary);
        pointer-events: none;
    }
    
    .search-results {
        position: absolute;
        top: calc(100% + 8px);
        left: 0;
        right: 0;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        max-height: 400px;
        overflow-y: auto;
        display: none;
        z-index: 1001;
    }
    
    .search-results.show {
        display: block;
    }
    
    .search-result-item {
        padding: 12px 16px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        cursor: pointer;
        border-bottom: 1px solid var(--facebook-border);
        text-decoration: none;
        color: var(--facebook-text);
    }
    
    .search-result-item:hover {
        background-color: var(--facebook-hover);
    }
    
    .search-result-item:last-child {
        border-bottom: none;
    }
    
    .search-result-left {
        display: flex;
        align-items: center;
        gap: 12px;
        flex: 1;
    }
    
    .search-user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: var(--facebook-blue);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 16px;
        flex-shrink: 0;
        overflow: hidden;
    }
    
    .search-user-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .search-user-info {
        display: flex;
        flex-direction: column;
    }
    
    .search-username {
        font-weight: 600;
        font-size: 15px;
        color: var(--facebook-text);
    }
    
    .search-email {
        font-size: 13px;
        color: var(--facebook-text-secondary);
    }
    
    .search-action-btn {
        padding: 6px 16px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
    }
    
    .search-add-btn {
        background-color: var(--facebook-blue);
        color: white;
    }
    
    .search-add-btn:hover {
        background-color: var(--facebook-dark-blue);
    }
    
    .search-pending-btn {
        background-color: var(--facebook-bg);
        color: var(--facebook-text-secondary);
        cursor: default;
    }
    
    .search-friends-badge {
        background-color: var(--facebook-green);
        color: white;
        padding: 4px 12px;
        border-radius: 6px;
        font-size: 12px;
        font-weight: 600;
    }
    
    .search-no-results {
        padding: 20px;
        text-align: center;
        color: var(--facebook-text-secondary);
    }
</style>
</head>
<body>
	<!-- Facebook-style Navigation -->
	<nav class="facebook-navbar">
		<a class="nav-brand" href="<c:url value='/posts' />">
			<i class="fab fa-facebook"></i>
			<span>facebook</span>
		</a>
		
		<!-- Search Bar -->
		<c:if test="${not empty user}">
			<div class="search-container">
				<i class="fas fa-search search-icon"></i>
				<input type="text" id="userSearchInput" class="search-input" placeholder="Search for users..." autocomplete="off">
				<div id="searchResults" class="search-results"></div>
			</div>
		</c:if>
		
		<c:if test="${not empty user}">
			<ul class="nav-menu">
				<li class="nav-item">
					<a href="<c:url value='/posts/new' />" class="create-post-btn nav-create-btn">
                		<i class="fas fa-plus"></i>
            		</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value='/admin/users' />">
						<i class="fas fa-shield-alt"></i>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value='/posts' />">
						<i class="fas fa-home"></i>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value='/posts/my' />">
						<i class="fas fa-newspaper"></i>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value='/profile' />">
						<i class="fas fa-user-circle"></i>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link notification-badge" href="<c:url value='/friends' />" id="friendsLink">
						<i class="fas fa-users"></i>
						<span class="badge-count" id="friendBadge" style="display: none;"></span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link notification-badge" href="<c:url value='/messages' />" id="messagesLink">
						<i class="fas fa-envelope"></i>
						<span class="badge-count" id="messageBadge">0</span>
					</a>
				</li>
				<li class="nav-item">
					<form action="<c:url value='/logout' />" method="POST" style="display: inline; margin: 0;">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<button type="submit" class="logout-btn" onclick="return confirm('Are you sure you want to logout?');">
							<div class="user-avatar">
								<c:choose>
									<c:when test="${not empty user.profilePhotoPath}">
										<img src="${pageContext.request.contextPath}${user.profilePhotoPath}" alt="${user.username}">
									</c:when>
									<c:otherwise>
										<c:set var="firstLetter" value="${user.username.charAt(0)}" />
										${firstLetter}
									</c:otherwise>
								</c:choose>
							</div>
							<span>Logout</span>
						</button>
					</form>
				</li>
			</ul>
		</c:if>
	</nav>
	<br><br>
	<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add loading animation to buttons
        const buttons = document.querySelectorAll('button, .btn, .nav-link');
        buttons.forEach(button => {
            if (button.getAttribute('href')) {
                button.addEventListener('click', function(e) {
                    if (!this.classList.contains('logout-btn')) {
                        this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>' + this.textContent;
                        this.style.pointerEvents = 'none';
                    }
                });
            }
        });
        
        // Add active state to current page nav link
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            if (link.getAttribute('href') === currentPath) {
                link.classList.add('active');
            }
        });


        
        function getCsrfToken() {
            const meta = document.querySelector('meta[name="_csrf"]');
            return meta ? meta.getAttribute('content') : '';
        }
        
        function getCsrfHeader() {
            const meta = document.querySelector('meta[name="_csrf_header"]');
            const headerName = meta ? meta.getAttribute('content') : '';
            return headerName || 'X-CSRF-TOKEN';
        }
        
    
        const csrfToken = getCsrfToken();
        console.log('CSRF Token:', csrfToken || '(EMPTY!)');
        console.log('Token Length:', csrfToken ? csrfToken.length : 0);
        
        if (!csrfToken || csrfToken.trim() === '') {
            console.error('❌ CSRF Token is EMPTY! Forms will NOT work!');
            console.error('➡️ Make sure application has been restarted');
        } else {
            console.log('✅ CSRF Token is valid - forms will work!');
        }
        
        // Add hover effects to cards
        const cards = document.querySelectorAll('.card');
        cards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
            });
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
        
        function updateMessageNotification() {
            fetch('${pageContext.request.contextPath}/messages/unread-count', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'same-origin'
            })
            .then(response => {
                if (response.ok) {
                    return response.text();
                }
                throw new Error('Failed to fetch unread count');
            })
            .then(count => {
                const badge = document.getElementById('messageBadge');
                if (badge) {
                    const unreadCount = parseInt(count);
                    if (unreadCount > 0) {
                        badge.textContent = unreadCount > 99 ? '99+' : unreadCount;
                        badge.classList.add('active');
                    } else {
                        badge.classList.remove('active');
                    }
                }
            })
            .catch(error => {
                console.error('Error fetching unread message count:', error);
            });
        }
        
        // Friend request notification polling
        function updateFriendRequestNotification() {
            fetch('${pageContext.request.contextPath}/friends/has-pending-requests', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'same-origin'
            })
            .then(response => {
                if (response.ok) {
                    return response.text();
                }
                throw new Error('Failed to fetch friend request status');
            })
            .then(hasPending => {
                const badge = document.getElementById('friendBadge');
                if (badge) {
                    if (hasPending === 'true') {
                        badge.style.display = 'flex';
                        badge.classList.add('active');
                    } else {
                        badge.style.display = 'none';
                        badge.classList.remove('active');
                    }
                }
            })
            .catch(error => {
                console.error('Error fetching friend request status:', error);
            });
        }
        
        // Initial checks
        updateMessageNotification();
        updateFriendRequestNotification();
        
        // Poll every 10 seconds for notifications
        setInterval(updateMessageNotification, 10000);
        setInterval(updateFriendRequestNotification, 10000);
        
        // User search functionality
        const searchInput = document.getElementById('userSearchInput');
        const searchResults = document.getElementById('searchResults');
        let searchTimeout;
        
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                const query = this.value.trim();
                
                // Clear previous timeout
                clearTimeout(searchTimeout);
                
                if (query.length < 2) {
                    searchResults.classList.remove('show');
                    searchResults.innerHTML = '';
                    return;
                }
                
                // Debounce search
                searchTimeout = setTimeout(() => {
                    performSearch(query);
                }, 300);
            });
            
            // Close search results when clicking outside
            document.addEventListener('click', function(event) {
                if (!searchInput.contains(event.target) && !searchResults.contains(event.target)) {
                    searchResults.classList.remove('show');
                }
            });
            
            // Keep search open when clicking inside
            searchInput.addEventListener('click', function(event) {
                event.stopPropagation();
                if (searchResults.innerHTML) {
                    searchResults.classList.add('show');
                }
            });
        }
        
        function performSearch(query) {
            const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
            
            fetch('${pageContext.request.contextPath}/friends/search?query=' + encodeURIComponent(query), {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    [csrfHeader]: csrfToken
                },
                credentials: 'same-origin'
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error('Search failed');
            })
            .then(users => {
                displaySearchResults(users);
            })
            .catch(error => {
                console.error('Error searching users:', error);
                searchResults.innerHTML = '<div class="search-no-results">Error searching users</div>';
                searchResults.classList.add('show');
            });
        }
        
        function displaySearchResults(users) {
            if (users.length === 0) {
                searchResults.innerHTML = '<div class="search-no-results">No users found</div>';
                searchResults.classList.add('show');
                return;
            }
            
            let html = '';
            users.forEach(user => {
                html += '<div class="search-result-item" onclick="window.location.href=\'${pageContext.request.contextPath}/profile/view/' + user.id + '\'">';
                html += '    <div class="search-result-left">';
                html += '        <div class="search-user-avatar">';
                if (user.profilePhotoPath) {
                    html += '            <img src="${pageContext.request.contextPath}' + escapeHtml(user.profilePhotoPath) + '" alt="' + escapeHtml(user.username) + '">';
                } else {
                    html += escapeHtml(user.username.charAt(0).toUpperCase());
                }
                html += '        </div>';
                html += '        <div class="search-user-info">';
                html += '            <span class="search-username">' + escapeHtml(user.username) + '</span>';
                html += '            <span class="search-email">' + escapeHtml(user.email) + '</span>';
                html += '        </div>';
                html += '    </div>';
                
                if (user.isFriend) {
                    html += '    <span class="search-friends-badge">Friends</span>';
                } else if (user.hasSentRequest) {
                    html += '    <button class="search-action-btn search-pending-btn" disabled onclick="event.stopPropagation()">Request Sent</button>';
                } else if (user.hasPendingRequest) {
                    html += '    <button class="search-action-btn search-pending-btn" disabled onclick="event.stopPropagation()">Pending</button>';
                } else {
                    html += '    <button class="search-action-btn search-add-btn" onclick="event.stopPropagation(); sendFriendRequestFromSearch(' + user.id + ')">Add Friend</button>';
                }
                
                html += '</div>';
            });
            
            searchResults.innerHTML = html;
            searchResults.classList.add('show');
        }
        
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
        
        window.sendFriendRequestFromSearch = function(userId) {
            const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
            const csrfParam = document.querySelector('meta[name="_csrf"]').getAttribute('content');
            
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/friends/request/send';
            
            const receiverInput = document.createElement('input');
            receiverInput.type = 'hidden';
            receiverInput.name = 'receiverId';
            receiverInput.value = userId;
            
            const csrfInput = document.createElement('input');
            csrfInput.type = 'hidden';
            csrfInput.name = '_csrf';
            csrfInput.value = csrfToken;
            
            form.appendChild(receiverInput);
            form.appendChild(csrfInput);
            document.body.appendChild(form);
            form.submit();
        };
    });
</script>
</body>
</html>
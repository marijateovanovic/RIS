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
						<i class="fas fa-user"></i>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value='/friends' />">
						<i class="fas fa-users"></i>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value='/messages' />">
						<i class="fas fa-envelope"></i>
					</a>
				</li>
				<li class="nav-item">
					<form action="<c:url value='/logout' />" method="POST" style="display: inline; margin: 0;">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<button type="submit" class="logout-btn" onclick="return confirm('Are you sure you want to logout?');">
							<div class="user-avatar">
								<c:set var="firstLetter" value="${user.username.charAt(0)}" />
								${firstLetter}
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
    });
</script>
</body>
</html>
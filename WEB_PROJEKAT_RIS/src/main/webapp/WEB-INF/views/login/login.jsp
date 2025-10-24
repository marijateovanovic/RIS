<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Log in to Facebook</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css">
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
        
        .facebook-header {
            background: #ffffff;
            border-bottom: 1px solid var(--facebook-border);
            padding: 16px 0;
            text-align: center;
            margin-bottom: 40px;
        }
        
        .facebook-logo {
            color: var(--facebook-blue);
            font-size: 2.5rem;
            font-weight: bold;
        }
        
        .welcome-text {
            text-align: center;
            color: var(--facebook-text);
            font-size: 1.5rem;
            font-weight: normal;
            margin-bottom: 24px;
        }
        
        .divider {
            border-top: 1px solid var(--facebook-border);
            margin: 20px 0;
            position: relative;
        }
        
        .divider-text {
            background: var(--facebook-card);
            padding: 0 16px;
            position: absolute;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            color: var(--facebook-text-secondary);
            font-size: 0.875rem;
        }
    </style>
</head>
<body>
    <!-- Facebook Header -->
    <div class="facebook-header">
        <div class="facebook-logo">
            <i class="fab fa-facebook"></i> FacebookCopy
        </div>
    </div>

    <div class="login-container">
        <div class="login-card">
            <div class="card-body">
                <h2 class="welcome-text">Log in</h2>
                
                <!-- Error message display -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>

                <!-- Success message display -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>${success}
                    </div>
                </c:if>

                <form method="post" id="loginForm">
                    <!-- Add CSRF Token -->
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    
                    <div class="form-group">
                        <input type="text" name="username" class="form-control" required 
                               placeholder="Email address or phone number">
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="password" class="form-control" required 
                               placeholder="Password">
                    </div>
                    
                    <button type="submit" class="btn-login" id="loginBtn">
                        Log In
                    </button>
                </form>
                
                <div class="register-link">
                    <a href="<c:url value='/register' />">
                        <i class="fas fa-user-plus me-1"></i>Don't have an account? Register
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Add loading animation to login button
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const btn = document.getElementById('loginBtn');
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Logging in...';
            btn.disabled = true;
        });

        // Add focus effects to form inputs
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.style.borderColor = 'var(--facebook-blue)';
                this.style.boxShadow = '0 0 0 2px rgba(24, 119, 242, 0.2)';
            });
            
            input.addEventListener('blur', function() {
                this.style.borderColor = 'var(--facebook-border)';
                this.style.boxShadow = 'none';
            });
        });
    </script>
</body>
</html>
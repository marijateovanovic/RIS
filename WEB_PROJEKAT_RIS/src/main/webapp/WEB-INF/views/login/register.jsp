<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up - Facebook</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/register.css" rel="stylesheet" type="text/css">
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
        
        .signup-text {
            text-align: center;
            color: var(--facebook-text);
            font-size: 1.5rem;
            font-weight: normal;
            margin-bottom: 24px;
        }
    </style>
</head>
<body>
    <!-- Facebook Header -->
    <div class="facebook-header">
        <div class="facebook-logo">
            <i class="fab fa-facebook"></i> SocialApp
        </div>
    </div>

    <div class="register-container">
        <div class="register-card">
            <div class="card-body">
                <h2 class="signup-text">Create a New Account</h2>
                
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

                <form method="post" id="registerForm">
                    <!-- Add CSRF Token -->
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    
                    <div class="form-group">
                        <input type="text" name="username" class="form-control" required 
                               placeholder="Username" id="username">
                        <div class="validation-feedback" id="usernameFeedback"></div>
                    </div>
                    
                    <div class="form-group">
                        <input type="email" name="email" class="form-control" required 
                               placeholder="Email address" id="email">
                        <div class="validation-feedback" id="emailFeedback"></div>
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="password" class="form-control" required 
                               placeholder="New password" id="password">
                        
                        <!-- Password strength meter -->
                        <div class="password-strength">
                            <div class="password-strength-bar" id="passwordStrengthBar"></div>
                        </div>
                        
                        <!-- Password requirements -->
                        <div class="password-requirements">
                            <div class="requirement" id="lengthReq">
                                <i class="fas fa-circle"></i> At least 8 characters
                            </div>
                            <div class="requirement" id="numberReq">
                                <i class="fas fa-circle"></i> Contains a number
                            </div>
                            <div class="requirement" id="specialReq">
                                <i class="fas fa-circle"></i> Contains a special character
                            </div>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-register" id="registerBtn">
                        Sign Up
                    </button>
                </form>
                
                <div class="login-link">
                    <a href="<c:url value='/login' />">
                        Already have an account?
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Password strength checker
        const passwordInput = document.getElementById('password');
        const strengthBar = document.getElementById('passwordStrengthBar');
        const requirements = {
            length: document.getElementById('lengthReq'),
            number: document.getElementById('numberReq'),
            special: document.getElementById('specialReq')
        };

        passwordInput.addEventListener('input', function() {
            const password = this.value;
            let strength = 0;
            
            // Check length
            if (password.length >= 8) {
                strength += 1;
                requirements.length.classList.add('valid');
                requirements.length.classList.remove('invalid');
                requirements.length.innerHTML = '<i class="fas fa-check-circle"></i> At least 8 characters';
            } else {
                requirements.length.classList.add('invalid');
                requirements.length.classList.remove('valid');
                requirements.length.innerHTML = '<i class="fas fa-circle"></i> At least 8 characters';
            }
            
            // Check for numbers
            if (/\d/.test(password)) {
                strength += 1;
                requirements.number.classList.add('valid');
                requirements.number.classList.remove('invalid');
                requirements.number.innerHTML = '<i class="fas fa-check-circle"></i> Contains a number';
            } else {
                requirements.number.classList.add('invalid');
                requirements.number.classList.remove('valid');
                requirements.number.innerHTML = '<i class="fas fa-circle"></i> Contains a number';
            }
            
            // Check for special characters
            if (/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                strength += 1;
                requirements.special.classList.add('valid');
                requirements.special.classList.remove('invalid');
                requirements.special.innerHTML = '<i class="fas fa-check-circle"></i> Contains a special character';
            } else {
                requirements.special.classList.add('invalid');
                requirements.special.classList.remove('valid');
                requirements.special.innerHTML = '<i class="fas fa-circle"></i> Contains a special character';
            }
            
            // Update strength bar
            strengthBar.className = 'password-strength-bar';
            if (strength === 1) {
                strengthBar.classList.add('strength-weak');
            } else if (strength === 2) {
                strengthBar.classList.add('strength-medium');
            } else if (strength === 3) {
                strengthBar.classList.add('strength-strong');
            }
        });

        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const btn = document.getElementById('registerBtn');
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Signing Up...';
            btn.disabled = true;
        });

        // Real-time username validation
        document.getElementById('username').addEventListener('input', function() {
            const username = this.value;
            const feedback = document.getElementById('usernameFeedback');
            
            if (username.length < 3) {
                this.classList.add('invalid');
                this.classList.remove('valid');
                feedback.textContent = 'Username must be at least 3 characters';
                feedback.classList.add('invalid');
                feedback.classList.remove('valid');
            } else {
                this.classList.add('valid');
                this.classList.remove('invalid');
                feedback.textContent = 'Username available';
                feedback.classList.add('valid');
                feedback.classList.remove('invalid');
            }
        });

        // Email validation
        document.getElementById('email').addEventListener('input', function() {
            const email = this.value;
            const feedback = document.getElementById('emailFeedback');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (emailRegex.test(email)) {
                this.classList.add('valid');
                this.classList.remove('invalid');
                feedback.textContent = 'Valid email address';
                feedback.classList.add('valid');
                feedback.classList.remove('invalid');
            } else if (email.length > 0) {
                this.classList.add('invalid');
                this.classList.remove('valid');
                feedback.textContent = 'Please enter a valid email address';
                feedback.classList.add('invalid');
                feedback.classList.remove('valid');
            } else {
                this.classList.remove('valid', 'invalid');
                feedback.classList.remove('valid', 'invalid');
                feedback.textContent = '';
            }
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
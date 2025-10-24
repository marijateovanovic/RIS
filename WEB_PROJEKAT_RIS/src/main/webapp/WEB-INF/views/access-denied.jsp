<%@ include file="layout.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        --facebook-error: #fa383e;
    }
    
    body {
        background-color: var(--facebook-bg);
        margin: 0;
        padding: 0;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    }
    
    .access-denied-container {
        max-width: 500px;
        width: 100%;
        padding: 40px 20px;
    }
    
    .access-denied-icon {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, var(--facebook-error), #d9363e);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 24px;
        box-shadow: 0 4px 12px rgba(250, 56, 62, 0.2);
    }
    
    .access-denied-icon i {
        font-size: 2.5rem;
        color: white;
    }
    
    .access-denied-title {
        color: var(--facebook-text);
        font-weight: 700;
        font-size: 1.75rem;
        margin-bottom: 16px;
        line-height: 1.3;
        text-align: center;
    }
    
    .access-denied-message {
        color: var(--facebook-text-secondary);
        font-size: 1.0625rem;
        line-height: 1.5;
        margin-bottom: 32px;
        text-align: center;
    }
    
    .mt-5 {
        margin-top: 3rem !important;
    }
    
    .pt-4 {
        padding-top: 1.5rem !important;
    }
    
    .border-top {
        border-top: 1px solid var(--facebook-border) !important;
    }
    
    .text-muted {
        color: var(--facebook-text-secondary) !important;
    }
    
    .small {
        font-size: 0.875rem;
    }
    
    .text-muted.small {
        text-align: center;
        line-height: 1.5;
        margin-bottom: 8px;
    }
    
    strong {
        color: var(--facebook-text);
        font-weight: 600;
    }
    
    /* Animation for the icon */
    @keyframes shake {
        0%, 100% { transform: rotate(0deg); }
        25% { transform: rotate(-5deg); }
        75% { transform: rotate(5deg); }
    }
    
    .access-denied-icon {
        animation: shake 0.5s ease-in-out;
    }
    
    /* Responsive Design */
    @media (max-width: 768px) {
        .access-denied-container {
            padding: 20px;
        }
        
        .access-denied-title {
            font-size: 1.5rem;
        }
        
        .access-denied-message {
            font-size: 1rem;
        }
    }
</style>
</head>
<body>

    <!-- Access Denied Content -->
    <div class="access-denied-container">
        <div class="access-denied-icon">
            <i class="fas fa-ban"></i>
        </div>
        <h1 class="access-denied-title">Access Denied</h1>
        <p class="access-denied-message">
            You don't have permission to access the admin panel. 
            This area is restricted to administrators only.
        </p>
        
        <!-- Additional Help Information -->
        <div class="mt-5 pt-4 border-top">
            <p class="text-muted small">
                If you believe this is an error, please contact the system administrator 
                or your IT support team for assistance.
            </p>
            <c:if test="${not empty pageContext.request.userPrincipal}">
                <p class="text-muted small">
                    Logged in as: <strong>${pageContext.request.userPrincipal.name}</strong>
                </p>
            </c:if>
        </div>
    </div>

</body>
</html>
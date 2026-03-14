<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - AgroWasteX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background-color: #f4f6f8; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
    .login-card { background: white; padding: 40px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); width: 100%; max-width: 400px; text-align: center; border-top: 8px solid #2e7d32; }
    header h1 { color: #2e7d32; font-weight: bold; }
    .btn-success { background-color: #2e7d32; border: none; padding: 12px; width: 100%; font-weight: bold; }
    .form-label { display: block; text-align: left; font-weight: bold; }
  </style>
</head>
<body>
<div class="login-card">
  <header><h1>AgroWasteX</h1><p>Management Portal Login</p></header>
  <form action="${pageContext.request.contextPath}/dashboard.jsp" method="POST">
    <div class="mb-3 text-start"><label class="form-label">Username</label><input type="text" name="username" class="form-control" required></div>
    <div class="mb-4 text-start"><label class="form-label">Password</label><input type="password" name="password" class="form-control" required></div>
    <button type="submit" class="btn btn-success">Login</button>
  </form>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    // Only run this when the user clicks 'Add Reading'
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String temp = request.getParameter("temperature");
        String humidity = request.getParameter("humidity");
        String ph = request.getParameter("ph");
        String date = request.getParameter("date");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = com.agrowastex.DBConnection.getConnection();
            if (con != null) {
                // Adjusting the query to match your sensor_data table
                String query = "INSERT INTO sensor_data (temperature, humidity, ph_level, reading_date) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setDouble(1, Double.parseDouble(temp));
                ps.setDouble(2, Double.parseDouble(humidity));
                ps.setDouble(3, Double.parseDouble(ph));
                ps.setString(4, date);
                
                int result = ps.executeUpdate();
                if(result > 0) {
                    message = "<div class='alert alert-success'>🌡️ Sensor reading recorded!</div>";
                }
                con.close();
            }
        } catch (Exception e) {
            message = "<div class='alert alert-danger'>❌ Error: " + e.getMessage() + "</div>";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Sensor Data - AgroWasteX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background-color: #f4f6f8; }
    header { background-color: #2e7d32; color: white; padding: 20px; text-align: center; }
    nav { background-color: #1b5e20; padding: 10px; text-align: center; }
    nav a { color: white; margin: 0 15px; text-decoration: none; font-weight: bold; }
    .form-container { 
      background: white; padding: 30px; border-radius: 12px; 
      box-shadow: 0 4px 15px rgba(0,0,0,0.1); margin-top: 30px;
    }
    .btn-success { background-color: #2e7d32; border: none; }
  </style>
</head>
<body>

  <header>
    <h1>Sensor Data Entry</h1>
    <p>Monitor Compost Conditions</p>
  </header>

  <nav>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="waste-entry.jsp">Waste Entry</a>
    <a href="sensor.jsp">Sensor Data</a>
  </nav>

  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-5">
        <div class="form-container">
          <%= message %>
          <form action="" method="POST">
            <div class="mb-3">
              <label class="form-label">Temperature (°C)</label>
              <input type="number" name="temperature" step="0.1" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Humidity (%)</label>
              <input type="number" name="humidity" step="0.1" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">pH Level</label>
              <input type="number" name="ph" step="0.1" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Reading Date</label>
              <input type="date" name="date" class="form-control" required>
            </div>
            <div class="d-grid">
              <button type="submit" class="btn btn-success">Add Reading</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
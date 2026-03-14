<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    // LOGIC START: This runs only when the button is clicked
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String farmerId = request.getParameter("farmerId");
        String wasteType = request.getParameter("wasteType");
        String quantity = request.getParameter("quantity");
        String date = request.getParameter("date");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = com.agrowastex.DBConnection.getConnection();
            if (con != null) {
                String query = "INSERT INTO waste_records (farmer_id, waste_type, quantity, collection_date) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(farmerId));
                ps.setString(2, wasteType);
                ps.setDouble(3, Double.parseDouble(quantity));
                ps.setString(4, date);
                
                int result = ps.executeUpdate();
                if(result > 0) {
                    message = "<div class='alert alert-success'>✅ Waste Record Saved Successfully!</div>";
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
  <title>AgroWasteX – Waste Entry</title>
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
    <h1>AgroWasteX</h1>
    <p>Waste Entry Management</p>
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
              <label class="form-label">Farmer ID</label>
              <input type="number" name="farmerId" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Waste Type</label>
              <select name="wasteType" class="form-select" required>
                <option value="">Select Waste Type</option>
                <option value="Crop Residue">Crop Residue</option>
                <option value="Plant Waste">Plant Waste</option>
                <option value="Food Waste">Food Waste</option>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label">Quantity (kg)</label>
              <input type="number" name="quantity" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Collection Date</label>
              <input type="date" name="date" class="form-control" required>
            </div>
            <div class="d-grid">
              <button type="submit" class="btn btn-success">Submit Waste Details</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
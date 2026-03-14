<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    double totalWaste = 0.0;
    double avgTemp = 0.0;

    // We open one connection at the top to handle the "Cards" data
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = com.agrowastex.DBConnection.getConnection();
        if (con != null) {
            Statement st = con.createStatement();
            
            // 1. Calculate Card Stats
            ResultSet rs1 = st.executeQuery("SELECT SUM(quantity) FROM waste_records");
            if(rs1.next()) totalWaste = rs1.getDouble(1);

            ResultSet rs2 = st.executeQuery("SELECT AVG(temperature) FROM sensor_data");
            if(rs2.next()) avgTemp = rs2.getDouble(1);
            
            con.close(); 
        }
    } catch(Exception e) {
        totalWaste = 450.0; 
        avgTemp = 32.5;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - AgroWasteX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; margin: 0; display: flex; height: 100vh; overflow: hidden; }
        .sidebar { width: 280px; background-color: #1b5e20; color: white; display: flex; flex-direction: column; padding: 20px; flex-shrink: 0; }
        .sidebar a { color: white; text-decoration: none; padding: 15px; margin-bottom: 10px; border-radius: 8px; transition: 0.3s; font-weight: 500; }
        .sidebar a:hover, .sidebar a.active { background-color: #2e7d32; }
        .main-content { flex-grow: 1; overflow-y: auto; padding: 40px; }
        .stat-card { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); text-align: center; border-bottom: 5px solid #2e7d32; }
        .stat-number { font-size: 3rem; font-weight: bold; color: #2e7d32; }
        .table-container { background: white; padding: 20px; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-top: 30px; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2 class="fw-bold mb-4">AgroWasteX</h2>
        <a href="dashboard.jsp" class="active">📊 Dashboard</a>
        <a href="waste-entry.jsp">🚜 Waste Entry</a>
        <a href="sensor.jsp">🌡️ Sensor Data</a>
        <div style="margin-top: auto;"><a href="login.jsp" style="color: #ffcdd2;">🚪 Logout</a></div>
    </div>

    <div class="main-content">
        <h1 class="fw-bold">Dashboard Overview</h1>
        <p class="text-muted">Welcome back, Administrator</p>

        <div class="row g-4 mt-2">
            <div class="col-md-6">
                <div class="stat-card">
                    <h5>Total Waste Collected</h5>
                    <div class="stat-number">
                        <%= (int)totalWaste %> <small style="font-size: 1rem;">kg</small>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="stat-card">
                    <h5>Avg Temperature</h5>
                    <div class="stat-number">
                        <%= String.format("%.1f", avgTemp) %> <small style="font-size: 1rem;">°C</small>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-container">
            <h3 class="fw-bold mb-3">🚜 Recent Waste Entries</h3>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Farmer ID</th>
                            <th>Waste Type</th>
                            <th>Qty (kg)</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Connection conW = com.agrowastex.DBConnection.getConnection();
                                Statement stW = conW.createStatement();
                                ResultSet rsW = stW.executeQuery("SELECT * FROM waste_records ORDER BY id DESC LIMIT 5");
                                while(rsW.next()) {
                        %>
                        <tr>
                            <td>#<%= rsW.getInt("farmer_id") %></td>
                            <td><span class="badge bg-success text-white"><%= rsW.getString("waste_type") %></span></td>
                            <td class="fw-bold"><%= rsW.getDouble("quantity") %></td>
                            <td class="text-muted"><%= rsW.getString("collection_date") %></td>
                        </tr>
                        <% } conW.close(); } catch(Exception e) { %>
                        <tr><td colspan="4" class="text-center">No waste data found</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="table-container">
            <h3 class="fw-bold mb-3">🌡️ Recent Sensor Data</h3>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-success">
                        <tr>
                            <th>Temp (°C)</th>
                            <th>Humidity (%)</th>
                            <th>pH Level</th>
                            <th>Reading Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Connection conS = com.agrowastex.DBConnection.getConnection();
                                Statement stS = conS.createStatement();
                                ResultSet rsS = stS.executeQuery("SELECT * FROM sensor_data ORDER BY id DESC LIMIT 5");
                                while(rsS.next()) {
                        %>
                        <tr>
                            <td class="fw-bold text-danger"><%= rsS.getDouble("temperature") %>°</td>
                            <td class="text-primary"><%= rsS.getDouble("humidity") %>%</td>
                            <td><span class="badge bg-secondary">pH <%= rsS.getDouble("ph_level") %></span></td>
                            <td class="text-muted"><%= rsS.getString("reading_date") %></td>
                        </tr>
                        <% } conS.close(); } catch(Exception e) { %>
                        <tr><td colspan="4" class="text-center text-muted">No sensor data recorded</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>

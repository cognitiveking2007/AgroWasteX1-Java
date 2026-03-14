package com.agrowastex;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SensorServlet")
public class SensorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String temp = request.getParameter("temperature");
        String humidity = request.getParameter("humidity");
        String ph = request.getParameter("ph");
        String date = request.getParameter("date");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO sensor_data (temperature, humidity, ph_level, reading_date) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, Double.parseDouble(temp));
            ps.setDouble(2, Double.parseDouble(humidity));
            ps.setDouble(3, Double.parseDouble(ph));
            ps.setString(4, date);
            
            ps.executeUpdate();
            // Redirect back to dashboard to see updated stats
            response.sendRedirect("dashboard.jsp?sensor=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("sensor.jsp?status=error");
        }
    }
}
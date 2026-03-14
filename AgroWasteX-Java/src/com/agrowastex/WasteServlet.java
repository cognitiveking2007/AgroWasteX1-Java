package com.agrowastex;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/WasteServlet")
public class WasteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String farmerId = request.getParameter("farmerId");
        String wasteType = request.getParameter("wasteType");
        String quantity = request.getParameter("quantity");
        String date = request.getParameter("date");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO waste_records (farmer_id, waste_type, quantity, collection_date) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, farmerId);
            ps.setString(2, wasteType);
            ps.setString(3, quantity);
            ps.setString(4, date);
            
            ps.executeUpdate();
            response.sendRedirect("dashboard.jsp?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("waste-entry.jsp?status=error");
        }
    }
}
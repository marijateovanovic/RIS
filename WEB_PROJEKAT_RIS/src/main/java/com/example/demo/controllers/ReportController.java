package com.example.demo.controllers;

import com.example.demo.services.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/reports")
public class ReportController {
    
    @Autowired
    private ReportService reportService;

    @GetMapping("/users.pdf")
    public void generateUsersReport(HttpServletResponse response,
                                   @RequestParam(defaultValue = "ALL") String role) {
        try {
            reportService.generateUsersReport(response, role);
        } catch (Exception e) {
            try {
                response.setContentType("text/html");
                response.getWriter().write("<h1>Error generating report</h1><pre>" + e.getMessage() + "</pre>");
            } catch (Exception ex) {
                // Error writing error message
            }
        }
    }
}


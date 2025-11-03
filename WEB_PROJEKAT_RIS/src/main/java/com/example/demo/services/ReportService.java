package com.example.demo.services;

import com.example.demo.repositories.UserRepository;
import model.User;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReportService {

    @Autowired
    private UserRepository userRepository;

    public void generateUsersReport(HttpServletResponse response, String role) throws Exception {
        InputStream is = null;
        OutputStream out = null;
        
        try {
            // Get users based on role filter
            List<User> users = userRepository.findAll();
            System.out.println("Found " + users.size() + " users for report generation");
            
            if (users.isEmpty()) {
                throw new Exception("No users found to generate report");
            }
            
            // Create data source
            JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(users);
            
            // Load and compile report template
            is = this.getClass().getResourceAsStream("/jasperreports/report.jrxml");
            if (is == null) {
                throw new Exception("Report template not found at /jasperreports/report.jrxml");
            }
            
            System.out.println("Compiling report template...");
            JasperReport jr = JasperCompileManager.compileReport(is);
            is.close();
            is = null;
            
            // Set report parameters
            Map<String, Object> params = new HashMap<>();
            params.put("Role", role);
            
            System.out.println("Filling report with data...");
            JasperPrint jp = JasperFillManager.fillReport(jr, params, dataSource);
            
            // Set download headers BEFORE getting output stream
            response.setContentType("application/pdf");
            response.setHeader("Content-disposition", "attachment; filename=users_report_" + role + ".pdf");
            
            // Get output stream after headers are set
            out = response.getOutputStream();
            
            System.out.println("Exporting report to PDF...");
            JRPdfExporter exporter = new JRPdfExporter();
            exporter.setExporterInput(new SimpleExporterInput(jp));
            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(out));
            exporter.exportReport();
            
            System.out.println("Report generated successfully");
            // Don't close the output stream - Spring will manage it
            out.flush();
        } catch (Exception e) {
            System.err.println("Error generating report: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-throw to let controller handle it
        } finally {
            // Clean up input stream only
            if (is != null) {
                try {
                    is.close();
                } catch (Exception e) {
                    // Ignore
                }
            }
            // Don't close output stream - let Spring/container manage it
        }
    }
}


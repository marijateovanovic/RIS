package com.example.demo.services;

import com.example.demo.repositories.UserRepository;
import model.User;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
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

    public void generateUsersReport(HttpServletResponse response, String clearance) throws Exception {
        // Get users based on clearance filter
        List<User> users = userRepository.findAll();
        
        // Create data source
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(users);
        
        // Load and compile report template
        InputStream is = this.getClass().getResourceAsStream("/jasperreports/report.jrxml");
        if (is == null) {
            throw new Exception("Report template not found!");
        }
        
        JasperReport jr = JasperCompileManager.compileReport(is);
        
        // Set report parameters
        Map<String, Object> params = new HashMap<>();
        params.put("Clearance", clearance);
        
        JasperPrint jp = JasperFillManager.fillReport(jr, params, dataSource);
        is.close();
        
        // Set download headers
        response.setContentType("application/pdf");
        response.addHeader("Content-disposition", "attachment; filename=users_report_" + clearance + ".pdf");
        
        OutputStream out = response.getOutputStream();
        JasperExportManager.exportReportToPdfStream(jp, out);
        out.flush();
        out.close();
    }
}


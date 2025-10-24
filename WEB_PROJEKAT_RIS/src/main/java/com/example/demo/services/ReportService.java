package com.example.demo.services;

import com.example.demo.repositories.UserRepository;

import model.User;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;

@Service
public class ReportService {

    @Autowired
    private UserRepository userRepository;

    public JasperPrint generateInventoryReport() throws JRException {
        List<User> users = userRepository.findAll();
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(users);
        
        JasperReport report = JasperCompileManager.compileReport(
            getClass().getResourceAsStream("/jasperreports/report.jrxml")
        );
        
        return JasperFillManager.fillReport(report, new HashMap<>(), dataSource);
    }
}
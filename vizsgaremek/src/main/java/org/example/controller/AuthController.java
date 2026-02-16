package org.example.controller;

import org.example.model.Customer;
import org.example.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private CustomerRepository customerRepository;

    @PostMapping("/register")
    public Customer register(@RequestBody Customer customer) {
        return customerRepository.save(customer);
    }

    @PostMapping("/login")
    public Customer login(@RequestBody Map<String, String> loginData) {
        String email = loginData.get("email");
        String password = loginData.get("password");

        Customer customer = customerRepository.findByEmail(email);
        
        if (customer != null && customer.getPassword().equals(password)) {
            return customer;
        } else {
            throw new RuntimeException("Hibás email vagy jelszó");
        }
    }
}
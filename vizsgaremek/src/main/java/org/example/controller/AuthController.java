package org.example.controller;

import org.example.model.Customer;
import org.example.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private CustomerRepository customerRepository;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Customer customer) {
        Customer existing = customerRepository.findByEmail(customer.getEmail());
        if (existing != null) {
            return ResponseEntity.badRequest().body("Ez az email cím már foglalt!");
        }
        Customer saved = customerRepository.save(customer);
        return ResponseEntity.ok(saved);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> loginData) {
        String email = loginData.get("email");
        String password = loginData.get("password");

        Customer customer = customerRepository.findByEmail(email);

        if (customer != null && customer.getPassword().equals(password)) {
            return ResponseEntity.ok(customer);
        } else {
            return ResponseEntity.badRequest().body("Hibás email vagy jelszó");
        }
    }
}
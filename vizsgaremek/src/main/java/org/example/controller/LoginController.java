package org.example.controller;
import org.example.model.Customer;
import org.example.repository.CustomerRepository;
import org.example.security.JwtUtil;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
public class LoginController {
    private final CustomerRepository repo;
    private final JwtUtil jwtUtil;

    public LoginController(CustomerRepository repo, JwtUtil jwtUtil) {
        this.repo = repo;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Customer customer) {
        Customer user = repo.findByEmail(customer.getEmail()).orElseThrow(() -> new RuntimeException("Nincs ilyen user"));
        if (user.getPassword().equals(customer.getPassword())) {
            String token = jwtUtil.generateToken(user.getEmail());
            Map<String, Object> resp = new HashMap<>();
            resp.put("token", token);
            resp.put("user", user);
            return resp;
        }
        throw new RuntimeException("Hibás jelszó");
    }
    
    @PostMapping("/register")
    public Customer register(@RequestBody Customer customer) {
        return repo.save(customer);
    }
}
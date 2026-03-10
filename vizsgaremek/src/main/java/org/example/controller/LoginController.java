package org.example.controller;
import org.example.model.Customer;
import org.example.repository.CustomerRepository;
import org.example.security.JwtUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
public class LoginController {
    private final CustomerRepository repo;
    private final JwtUtil jwtUtil;

    public LoginController(CustomerRepository repo, JwtUtil jwtUtil) {
        this.repo = repo;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Customer customer) {
        Customer user = repo.findByEmail(customer.getEmail());

        if (user == null) {
            return ResponseEntity.status(401).body("Ez az email cím nincs regisztrálva!");
        }

        if (!user.getPassword().equals(customer.getPassword())) {
            return ResponseEntity.status(401).body("Hibás jelszó!");
        }

        String token = jwtUtil.generateToken(user.getEmail());
        Map<String, Object> resp = new HashMap<>();
        resp.put("token", token);
        resp.put("email", user.getEmail());
        resp.put("role", user.getRole());
        resp.put("name", user.getName());
        return ResponseEntity.ok(resp);
    }

    @PostMapping("/register")
    public Customer register(@RequestBody Customer customer) {
        if (customer.getRole() == null) {
            customer.setRole("USER");
        }
        return repo.save(customer);
    }
}
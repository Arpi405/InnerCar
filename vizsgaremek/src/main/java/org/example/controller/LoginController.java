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

    @PutMapping("/api/customer/update")
    public ResponseEntity<?> updateCustomer(@RequestBody Customer updatedCustomer) {
        Customer existing = repo.findByEmail(updatedCustomer.getEmail());
        if (existing == null) {
            return ResponseEntity.status(404).body("Felhasználó nem található!");
        }

        if (updatedCustomer.getName() != null) existing.setName(updatedCustomer.getName());
        if (updatedCustomer.getPhone() != null) existing.setPhone(updatedCustomer.getPhone());
        if (updatedCustomer.getAddress() != null) existing.setAddress(updatedCustomer.getAddress());
        if (updatedCustomer.getPassword() != null && !updatedCustomer.getPassword().isEmpty()) {
            existing.setPassword(updatedCustomer.getPassword());
        }

        repo.save(existing);
        return ResponseEntity.ok("Adatok sikeresen frissítve!");
    }
}
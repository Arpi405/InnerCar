package org.example.controller;

import org.example.model.*;
import org.example.repository.*;
import org.springframework.web.bind.annotation.*;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
public class OrderController {

    private final OrderRepository orderRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;

    public OrderController(OrderRepository orderRepository, CustomerRepository customerRepository, ProductRepository productRepository) {
        this.orderRepository = orderRepository;
        this.customerRepository = customerRepository;
        this.productRepository = productRepository;
    }

    public static class CartItemRequest {
        public Integer productId;
        public Integer quantity;
    }

    @PostMapping("/order")
    public String placeOrder(@RequestBody List<CartItemRequest> cartItems, Principal principal) {
        
        if (principal == null) {
            throw new RuntimeException("Nincs bejelentkezve!");
        }
        String email = principal.getName();

        Customer customer = customerRepository.findByEmail(email);

        if (customer == null) {
            throw new RuntimeException("Felhasználó nem található");
        }
        Orders newOrder = new Orders();
        newOrder.setCustomer(customer);
        newOrder.setOrderDate(LocalDateTime.now());
        newOrder.setStatus("Feldolgozás alatt");

        List<OrderItem> itemsToSave = new ArrayList<>();
        double vegosszeg = 0.0;

        for (CartItemRequest itemReq : cartItems) {
            Product product = productRepository.findById(itemReq.productId)
                    .orElseThrow(() -> new RuntimeException("Nincs ilyen termék ID: " + itemReq.productId));

            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(product);
            orderItem.setQuantity(itemReq.quantity);
            orderItem.setOrder(newOrder);
            
            itemsToSave.add(orderItem);
            
            vegosszeg += product.getPrice() * itemReq.quantity;
        }

        newOrder.setItems(itemsToSave);
        newOrder.setTotalPrice(vegosszeg);

        orderRepository.save(newOrder);

        return "Sikeres rendelés! Azonosító: " + newOrder.getId();
    }
}
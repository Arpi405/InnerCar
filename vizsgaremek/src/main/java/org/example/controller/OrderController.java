package org.example.controller;

import org.example.model.*;
import org.example.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
public class OrderController {

    private final OrderRepository orderRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;

    @Autowired
    private JavaMailSender mailSender;

    public OrderController(OrderRepository orderRepository, CustomerRepository customerRepository, ProductRepository productRepository) {
        this.orderRepository = orderRepository;
        this.customerRepository = customerRepository;
        this.productRepository = productRepository;
    }

    public static class OrderRequest {
        public String name;
        public String email;
        public String address;
        public String phone;
        public String paymentMethod;
        public List<CartItemRequest> cartItems;
    }

    public static class CartItemRequest {
        public Integer productId;
        public Integer quantity;
    }

    @PostMapping("/order")
    public String placeOrder(@RequestBody OrderRequest request) {

        Customer customer = customerRepository.findByEmail(request.email);

        if (customer == null) {
            String randomPassword = UUID.randomUUID().toString().substring(0, 8);

            customer = new Customer();
            customer.setName(request.name);
            customer.setEmail(request.email);
            customer.setAddress(request.address);
            customer.setPhone(request.phone);
            customer.setPassword(randomPassword);
            customerRepository.save(customer);

            // Email küldése
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(request.email);
            message.setSubject("Sikeres rendelés - Fiók adatok");
            message.setText(
                    "Kedves " + request.name + "!\n\n" +
                            "Köszönjük a rendelését!\n\n" +
                            "Fiók adatai:\n" +
                            "Email: " + request.email + "\n" +
                            "Jelszó: " + randomPassword + "\n\n" +
                            "Üdvözlettel,\nA csapat"
            );
            mailSender.send(message);
        } else {
            customer.setName(request.name);
            customer.setAddress(request.address);
            customer.setPhone(request.phone);
            customerRepository.save(customer);
        }

        Orders newOrder = new Orders();
        newOrder.setCustomer(customer);
        newOrder.setOrderDate(LocalDateTime.now());
        newOrder.setStatus("Feldolgozás alatt");

        List<OrderItem> itemsToSave = new ArrayList<>();
        double vegosszeg = 0.0;

        for (CartItemRequest itemReq : request.cartItems) {
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
package org.example.controller;

import org.example.model.CarModel;
import org.example.repository.CarModelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api")
public class CarModelController {

    @Autowired
    private CarModelRepository carModelRepository;

    @GetMapping("/models")
    public List<CarModel> getModels() {
        return carModelRepository.findAll();
    }
}

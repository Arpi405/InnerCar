package org.example.repository;

import org.example.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {

    List<Product> findByCategoryId(Integer categoryId);

    List<Product> findByNameContainingIgnoreCase(String name);

    @Query("SELECT p FROM Product p WHERE " +
            "(:categoryId IS NULL OR p.categoryId = :categoryId) AND " +
            "(:modelId IS NULL OR p.modelId = :modelId) AND " +
            "(:minPrice IS NULL OR p.price >= :minPrice) AND " +
            "(:maxPrice IS NULL OR p.price <= :maxPrice)")
    List<Product> filterProducts(
            @Param("categoryId") Integer categoryId,
            @Param("modelId") Integer modelId,
            @Param("minPrice") Double minPrice,
            @Param("maxPrice") Double maxPrice
    );
}
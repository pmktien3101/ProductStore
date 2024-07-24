package com.project.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;
import lombok.*;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDetailDTO {
    @JsonProperty("order_id")
    @Min(value = 1, message = "Order's ID must be > 0")
    private Long orderId;

    @Min(value = 1, message = "Product's ID must be > 0")
    @JsonProperty("product_id")
    private Long productId;

    @Min(value = 1, message = "Price must be > 0")
    private Long price;

    @Min(value = 1, message = "Number of products must be >= 1")
    @JsonProperty("number_of_products")
    private int numberOfProducts;

    @Min(value = 1, message = "Total money must be > 0")
    @JsonProperty("total_money")
    private int totalMoney;

    private String color;



}

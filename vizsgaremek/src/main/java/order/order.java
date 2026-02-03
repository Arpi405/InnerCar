import java.time.LocalDateTime;


public class order {

    private int id;
    private int customerId;
    private double total;
    private int paymentId;
    private LocalDateTime createdAt;
    private LocalDateTime modifiedAt;

    public order() {
        this.createdAt = LocalDateTime.now();
        this.modifiedAt = LocalDateTime.now();
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
        this.modifiedAt = LocalDateTime.now();
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
        this.modifiedAt = LocalDateTime.now();
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        if (total >= 0) {
            this.total = total;
            this.modifiedAt = LocalDateTime.now();
        } else {
            System.out.println("Total cannot be negative!");
        }
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
        this.modifiedAt = LocalDateTime.now();
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getModifiedAt() {
        return modifiedAt;
    }

    public void setModifiedAt(LocalDateTime modifiedAt) {
        this.modifiedAt = modifiedAt;
    }
}


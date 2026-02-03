import java.time.LocalDateTime;

public class shipment {

        private int id;
        private int orderId;
        private String status;
        private String trackingCode;
        private LocalDateTime shippedAt;
        private LocalDateTime deliveredAt;


        public shipment() {
            this.status = "Pending";
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getOrderId() {
            return orderId;
        }

        public void setOrderId(int orderId) {
            this.orderId = orderId;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;

            if (status != null) {
                switch (status.toLowerCase()) {
                    case "shipped":
                        this.shippedAt = LocalDateTime.now();
                        break;
                    case "delivered":
                        this.deliveredAt = LocalDateTime.now();
                        break;
                }
            }
        }

        public String getTrackingCode() {
            return trackingCode;
        }

        public void setTrackingCode(String trackingCode) {
            this.trackingCode = trackingCode;
        }

        public LocalDateTime getShippedAt() {
            return shippedAt;
        }

        public void setShippedAt(LocalDateTime shippedAt) {
            this.shippedAt = shippedAt;
        }

        public LocalDateTime getDeliveredAt() {
            return deliveredAt;
        }

        public void setDeliveredAt(LocalDateTime deliveredAt) {
            this.deliveredAt = deliveredAt;
        }
}

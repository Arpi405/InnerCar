

 class customer {

    private int id;
    private String email;
    private String password;
    private String phone;

    public customer() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {

        if (email != null && email.contains("@")) {
            this.email = email;
        } else {
            System.out.println("Invalid email address!");
        }
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {

        if (password != null && password.length() >= 6) {
            this.password = password;
        } else {
            System.out.println("Password must be at least 6 characters long!");
        }
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {

        if (phone != null && phone.matches("\\d+")) {
            this.phone = phone;
        } else {
            System.out.println("Phone number must contain only digits!");
        }
    }
}

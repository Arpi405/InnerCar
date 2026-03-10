import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { NavBar } from '../nav-bar/nav-bar';
import { CartService } from '../services/cart-service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-checkout',
  standalone: true,
  imports: [CommonModule, FormsModule, NavBar, HttpClientModule],
  templateUrl: './checkout.html',
  styleUrl: './checkout.css'
})
export class Checkout implements OnInit {
  total = 0;
  selectedPayment = '';
  name = '';
  email = '';
  address = '';
  phone = '';

  constructor(
    private cartService: CartService,
    private router: Router,
    private http: HttpClient
  ) {}

  ngOnInit() {
    this.total = this.cartService.getTotal();
  }

  pay() {
    if (!this.name || !this.email || !this.address || !this.phone) {
      alert('Kérjük töltse ki az összes mezőt!');
      return;
    }

    if (!this.selectedPayment) {
      alert('Kérjük válasszon fizetési módot!');
      return;
    }

    const cartItems = this.cartService.getItems().map(item => ({
      productId: item.id,
      quantity: item.quantity
    }));

    const orderRequest = {
      name: this.name,
      email: this.email,
      address: this.address,
      phone: this.phone,
      paymentMethod: this.selectedPayment,
      cartItems: cartItems
    };

    this.http.post('http://localhost:8080/order', orderRequest, { responseType: 'text' }).subscribe({
      next: (response) => {
        alert('Sikeres rendelés! Köszönjük a vásárlást! ' + response);
        this.cartService.clearCart();
        this.router.navigate(['/home']);
      },
      error: (err) => {
        console.error('Hiba a rendeléskor:', err);
        alert('Hiba történt a rendelés során!');
      }
    });
  }
}
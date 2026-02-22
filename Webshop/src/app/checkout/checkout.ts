import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { NavBar } from '../nav-bar/nav-bar';
import { CartService } from '../services/cart-service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-checkout',
  standalone: true,
  imports: [CommonModule, FormsModule, NavBar],
  templateUrl: './checkout.html',
  styleUrl: './checkout.css'
})
export class Checkout implements OnInit {
  total = 0;
  selectedPayment = '';

  constructor(private cartService: CartService, private router: Router) {}

  ngOnInit() {
    this.total = this.cartService.getTotal();
  }

  pay() {
    if (!this.selectedPayment) {
      alert('Kérjük válasszon fizetési módot!');
      return;
    }
    alert('Sikeres fizetés!');
    this.cartService.clearCart();
    this.router.navigate(['/home']);
  }
}

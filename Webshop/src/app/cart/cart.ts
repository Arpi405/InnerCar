import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CartService } from '../services/cart-service';
import { Router, RouterModule } from '@angular/router';
import { NavBar } from "../nav-bar/nav-bar";

@Component({
  selector: 'app-cart',
  standalone: true,
  imports: [CommonModule, RouterModule, NavBar],
  templateUrl: './cart.html',
  styleUrl: './cart.css'
})
export class Cart {
  items: any[] = [];

  constructor(private cartService: CartService, private router: Router) {
    this.items = this.cartService.getItems();
  }

  removeFromCart(item: any) {
    this.cartService.removeFromCart(item.id);
    this.items = this.cartService.getItems();
  }

  checkout() {
    if (this.items.length === 0) {
      alert('Üres a kosarad!');
      return;
    }
    this.router.navigate(['/checkout']);
  }

  get total() {
    return this.cartService.getTotal();
  }
}
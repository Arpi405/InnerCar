import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CartItem, CartService } from '../services/cart-service';
import { RouterModule } from '@angular/router';
import { NavBar } from "../nav-bar/nav-bar";

@Component({
  selector: 'app-cart',
  standalone: true,
  imports: [CommonModule, RouterModule, NavBar],
  templateUrl: './cart.html',
  styleUrl: './cart.css'
})
export class Cart {
checkout() {
throw new Error('Method not implemented.');
}
removeFromCart(_t7: CartItem) {
throw new Error('Method not implemented.');
}
  items: CartItem[] = [];

  constructor(private cartService: CartService) {
    this.items = this.cartService.getItems();
  }

  remove(id: number) {
    this.cartService.removeFromCart(id);
    this.items = this.cartService.getItems();
  }

  get total() {
    return this.cartService.getTotal();
  }
}

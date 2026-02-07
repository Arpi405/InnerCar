import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { CartService } from '../services/cart-service';
import { NavBar } from '../nav-bar/nav-bar';

@Component({
  selector: 'app-home-page',
  standalone: true,
  imports: [CommonModule, NavBar],
  templateUrl: './home-page.html',
  styleUrls: ['./home-page.css']
})
export class HomePage implements OnInit {
  products: any[] = [];

  constructor(private http: HttpClient, private cartService: CartService) {}

  ngOnInit() {
    this.http.get<any[]>('http://localhost:8080/products').subscribe(data => {
      this.products = data;
    });
  }

  onAddToCart(product: any) {
    this.cartService.addToCart(product);
  }
}
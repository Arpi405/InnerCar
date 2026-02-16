import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { CartService } from '../services/cart-service';
import { NavBar } from '../nav-bar/nav-bar';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-home-page',
  standalone: true,
  imports: [CommonModule, NavBar, RouterModule, HttpClientModule],
  templateUrl: './home-page.html',
  styleUrls: ['./home-page.css']
})
export class HomePage implements OnInit {
  products: any[] = [];

  constructor(private http: HttpClient, private cartService: CartService) {}

  ngOnInit() {
    this.http.get<any[]>('http://localhost:8080/api/products').subscribe({
      next: (data) => {
        this.products = data;
        console.log('Termékek betöltve:', data);
      },
      error: (err) => {
        console.error('Hiba a termékek betöltésekor:', err);
        alert('Nem sikerült elérni a szervert! Fut a Java backend?');
      }
    });
  }

  onAddToCart(product: any) {
    this.cartService.addToCart(product);
  }
}
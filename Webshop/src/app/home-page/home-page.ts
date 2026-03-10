import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { CartService } from '../services/cart-service';
import { NavBar } from '../nav-bar/nav-bar';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-home-page',
  standalone: true,
  imports: [CommonModule, RouterModule, HttpClientModule, NavBar, FormsModule],
  templateUrl: './home-page.html',
  styleUrls: ['./home-page.css']
})
export class HomePage implements OnInit {
  products: any[] = [];
  categories: any[] = [];
  models: any[] = [];

  selectedCategory: string = '';
  selectedModel: string = '';
  minPrice: number | null = null;
  maxPrice: number | null = null;

  constructor(
    private http: HttpClient,
    private cartService: CartService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit() {
    this.http.get<any[]>('http://localhost:8080/api/products').subscribe({
      next: (data) => {
        this.products = data.map(p => ({ ...p, quantity: 1 }));
        this.cdr.detectChanges();
      },
      error: (err) => console.error('Hiba:', err)
    });

    this.http.get<any[]>('http://localhost:8080/api/categories').subscribe({
      next: (data) => {
        this.categories = data;
        this.cdr.detectChanges();
      },
      error: (err) => console.error('Hiba a kategóriák betöltésekor:', err)
    });

    this.http.get<any[]>('http://localhost:8080/api/models').subscribe({
      next: (data) => {
        this.models = data;
        this.cdr.detectChanges();
      },
      error: (err) => console.error('Hiba a modellek betöltésekor:', err)
    });
  }

  search() {
    const params: any = {};
    if (this.selectedCategory) params['categoryId'] = this.selectedCategory;
    if (this.selectedModel) params['modelId'] = this.selectedModel;
    if (this.minPrice) params['minPrice'] = this.minPrice;
    if (this.maxPrice) params['maxPrice'] = this.maxPrice;

    this.http.get<any[]>('http://localhost:8080/api/products/filter', { params }).subscribe({
      next: (data) => {
        this.products = data.map(p => ({ ...p, quantity: 1 }));
        this.cdr.detectChanges();
      },
      error: (err) => console.error('Hiba a szűréskor:', err)
    });
  }

  increaseQuantity(product: any, event: Event) {
    event.stopPropagation();
    product.quantity++;
  }

  decreaseQuantity(product: any, event: Event) {
    event.stopPropagation();
    if (product.quantity > 1) {
      product.quantity--;
    }
  }

  onAddToCart(product: any, event: Event) {
    event.stopPropagation();
    for (let i = 0; i < product.quantity; i++) {
      this.cartService.addToCartSilent(product);
    }
    alert(`${product.quantity} db ${product.name} a kosárba került!`);
    product.quantity = 1;
  }
}
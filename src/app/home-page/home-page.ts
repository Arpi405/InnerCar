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

  selectedCategory: number | null = null;
  selectedModel: number | null = null;
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
        this.products = data;
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
    let url = 'http://localhost:8080/api/products?';
    if (this.selectedCategory) url += `categoryId=${this.selectedCategory}&`;
    if (this.selectedModel) url += `modelId=${this.selectedModel}&`;
    if (this.minPrice) url += `minPrice=${this.minPrice}&`;
    if (this.maxPrice) url += `maxPrice=${this.maxPrice}&`;

    this.http.get<any[]>(url).subscribe({
      next: (data) => {
        this.products = data;
        this.cdr.detectChanges();
      },
      error: (err) => console.error('Hiba a kereséskor:', err)
    });
  }

  onAddToCart(product: any) {
    this.cartService.addToCart(product);
  }
}
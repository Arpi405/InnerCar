import { CommonModule } from '@angular/common';
import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { NavBar } from "../nav-bar/nav-bar";
import { ActivatedRoute } from '@angular/router';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { CartService } from '../services/cart-service';

@Component({
  selector: 'app-product-detail',
  standalone: true,
  imports: [CommonModule, NavBar, HttpClientModule],
  templateUrl: './product-detail.html',
  styleUrl: './product-detail.css',
})
export class ProductDetail implements OnInit {

  product: any = {
    name: 'Betöltés...',
    price: 0,
    description: '',
  };
  
  images: string[] = [];
  currentImageIndex: number = 0;

  constructor(
    private route: ActivatedRoute, 
    private http: HttpClient,
    private cartService: CartService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit() {
    const id = this.route.snapshot.paramMap.get('id');

    if (id) {
      this.http.get<any>(`http://localhost:8080/api/products/${id}`).subscribe({
        next: (data) => {
          this.product = data;
          this.images = data.imageUrl ? [data.imageUrl] : ['alcantara.jpg'];
          this.cdr.detectChanges();
        },
        error: (err) => {
          console.error('Nem sikerült betölteni a terméket', err);
        }
      });
    }
  }

  nextImage() {
    if (this.images.length > 0) {
      this.currentImageIndex = (this.currentImageIndex + 1) % this.images.length;
    }
  }

  prevImage() {
    if (this.images.length > 0) {
      this.currentImageIndex = (this.currentImageIndex - 1 + this.images.length) % this.images.length;
    }
  }

  addToFavorites() {
    const favorites = JSON.parse(localStorage.getItem('favorites') || '[]');
    const already = favorites.find((f: any) => f.id === this.product.id);
    
    if (already) {
      alert('Ez a termék már a kedvenceid között van!');
      return;
    }
    
    favorites.push(this.product);
    localStorage.setItem('favorites', JSON.stringify(favorites));
    alert('Kedvencekhez adva!');
  }

  addToCart() {
    this.cartService.addToCart(this.product);
  }
}
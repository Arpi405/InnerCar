import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NavBar } from '../nav-bar/nav-bar';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-favorites',
  standalone: true,
  imports: [CommonModule, NavBar, RouterModule],
  templateUrl: './favorites.html',
  styleUrl: './favorites.css'
})
export class Favorites implements OnInit {
  favorites: any[] = [];

  ngOnInit() {
    const saved = localStorage.getItem('favorites');
    if (saved) {
      this.favorites = JSON.parse(saved);
    }
  }

  removeFromFavorites(item: any) {
    this.favorites = this.favorites.filter(f => f.id !== item.id);
    localStorage.setItem('favorites', JSON.stringify(this.favorites));
  }
}
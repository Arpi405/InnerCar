import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NavBar } from '../nav-bar/nav-bar';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule, NavBar, RouterModule],
  templateUrl: './profile.html',
  styleUrl: './profile.css'
})
export class Profile implements OnInit {
  name = '';
  email = '';

  ngOnInit() {
    this.name = localStorage.getItem('name') || 'Ismeretlen';
    this.email = localStorage.getItem('email') || '';
  }
}
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { NavBar } from '../nav-bar/nav-bar';
import { Router } from '@angular/router';

@Component({
  selector: 'app-settings',
  standalone: true,
  imports: [CommonModule, FormsModule, HttpClientModule, NavBar],
  templateUrl: './settings.html',
  styleUrl: './settings.css'
})
export class Settings implements OnInit {
  name = '';
  email = '';
  phone = '';
  address = '';
  newPassword = '';
  confirmPassword = '';
  successMessage = '';
  errorMessage = '';

  constructor(private http: HttpClient, private router: Router) {}

  ngOnInit() {
    const token = localStorage.getItem('token');
    if (!token) {
      this.router.navigate(['/login']);
      return;
    }
    this.email = localStorage.getItem('email') || '';
    this.name = localStorage.getItem('name') || '';
  }

  save() {
    if (this.newPassword && this.newPassword !== this.confirmPassword) {
      this.errorMessage = 'A két jelszó nem egyezik!';
      this.successMessage = '';
      return;
    }

    const updateData: any = {
      email: this.email,
      name: this.name,
      phone: this.phone,
      address: this.address,
    };

    if (this.newPassword) {
      updateData.password = this.newPassword;
    }

    this.http.put('http://localhost:8080/api/customer/update', updateData, { responseType: 'text' }).subscribe({
      next: () => {
        localStorage.setItem('name', this.name);
        this.successMessage = 'Adatok sikeresen mentve!';
        this.errorMessage = '';
        this.newPassword = '';
        this.confirmPassword = '';
      },
      error: (err) => {
        this.errorMessage = 'Hiba történt a mentés során!';
        console.error(err);
      }
    });
  }
}
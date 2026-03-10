import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-forgot-password',
  standalone: true,
  imports: [CommonModule, FormsModule, HttpClientModule],
  templateUrl: './forgot-password.html',
  styleUrl: './forgot-password.css',
})
export class ForgotPassword {
  email = '';
  errorMessage = '';

  constructor(private http: HttpClient, private router: Router) {}

  send() {
    if (!this.email) {
      this.errorMessage = 'Adja meg az email címét!';
      return;
    }

    this.http.post<any>('http://localhost:8080/forgot-password', { email: this.email }).subscribe({
      next: () => {
        alert('Email elküldve! Ellenőrizze a postaládáját.');
        this.router.navigate(['/reset-password']);
      },
      error: (err) => {
        this.errorMessage = 'Hiba történt, próbálja újra!';
        console.error(err);
      }
    });
  }
}

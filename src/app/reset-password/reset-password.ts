import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-reset-password',
  standalone: true,
  imports: [CommonModule, FormsModule, HttpClientModule],
  templateUrl: './reset-password.html',
  styleUrl: './reset-password.css',
})
export class ResetPassword {
  password = '';
  confirmPassword = '';
  errorMessage = '';

  constructor(private http: HttpClient, private router: Router) {}

  resetPassword() {
    if (this.password !== this.confirmPassword) {
      this.errorMessage = 'A két jelszó nem egyezik!';
      return;
    }

    if (this.password.length < 6) {
      this.errorMessage = 'A jelszónak legalább 6 karakter hosszúnak kell lennie!';
      return;
    }

    this.http.post<any>('http://localhost:8080/reset-password', { password: this.password }).subscribe({
      next: () => {
        alert('Jelszó sikeresen megváltoztatva!');
        this.router.navigate(['/login']);
      },
      error: (err) => {
        this.errorMessage = 'Hiba történt, próbálja újra!';
        console.error(err);
      }
    });
  }
}

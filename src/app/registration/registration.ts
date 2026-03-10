import { CommonModule, NgIf } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { HttpClient, HttpClientModule } from '@angular/common/http';

@Component({
  selector: 'app-registration',
  standalone: true,
  imports: [ReactiveFormsModule, NgIf, CommonModule, RouterModule, HttpClientModule],
  templateUrl: './registration.html',
  styleUrl: './registration.css',
})
export class Registration {

  registrationForm: any;
  errorMessage = '';

  constructor(private fb: FormBuilder, private router: Router, private http: HttpClient) {
    this.registrationForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      confirmPassword: ['', Validators.required]
    });
  }

  onSubmit() {
    if (this.registrationForm.valid) {
      const { email, password, confirmPassword } = this.registrationForm.value;

      if (password !== confirmPassword) {
        this.errorMessage = 'A két jelszó nem egyezik!';
        return;
      }

      this.http.post<any>('http://localhost:8080/api/auth/register', { email, password }).subscribe({
        next: () => {
          alert('Sikeres regisztráció!');
          this.router.navigate(['/login']);
        },
        error: (err) => {
          this.errorMessage = 'Hiba történt a regisztráció során!';
          console.error(err);
        }
      });
    } else {
      this.registrationForm.markAllAsTouched();
    }
  }
}
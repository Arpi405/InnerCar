import { CommonModule, NgIf } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-registration',
  standalone: true,
  imports: [ReactiveFormsModule, NgIf, CommonModule, RouterModule],
  templateUrl: './registration.html',
  styleUrl: './registration.css',
})
export class Registration {

  registrationForm: any;

  constructor(private fb: FormBuilder, private router: Router) {
    this.registrationForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      confirmPassword: ['', Validators.required]
    });
  }

  onSubmit() {
    if (this.registrationForm.valid) {
      console.log("Regisztráció sikeres!", this.registrationForm.value);
      this.router.navigate(['/']);
    } else {
      this.registrationForm.markAllAsTouched();
    }
  }
}

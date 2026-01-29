import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { NavBar } from "../nav-bar/nav-bar";

@Component({
  selector: 'app-checkout',
  standalone: true,
  imports: [CommonModule, NavBar],
  templateUrl: './checkout.html',
  styleUrl: './checkout.css',
})
export class Checkout {

}

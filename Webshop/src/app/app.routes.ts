import { Routes } from '@angular/router';

export const routes: Routes = [
  // Kezdőlap frissítéskor is
  { path: '', redirectTo: 'home', pathMatch: 'full' },

  {
    path: 'home',
    loadComponent: () =>
      import('./home-page/home-page').then(m => m.HomePage),
  },
  {
    path: 'cart',
    loadComponent: () =>
      import('./cart/cart').then(m => m.Cart),
  },
  {
    path: 'checkout',
    loadComponent: () =>
      import('./checkout/checkout').then(m => m.Checkout),
  },

  {
    path: 'login',
    loadComponent: () =>
      import('./login/login').then(m => m.Login),
  },
  {
    path: 'register',
    loadComponent: () =>
      import('./registration/registration').then(m => m.Registration),
  },

  {
    path: 'search',
    loadComponent: () =>
      import('./search-result/search-result').then(m => m.SearchResult),
  },

  // 404 fallback
  { path: '**', redirectTo: 'home' },
];

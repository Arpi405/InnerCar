import { Routes } from '@angular/router';

export const routes: Routes = [
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
  {
    path: 'forgot-password',
    loadComponent: () =>
      import('./forgot-password/forgot-password').then(m => m.ForgotPassword),
  },
  {
    path: 'reset-password',
    loadComponent: () =>
      import('./reset-password/reset-password').then(m => m.ResetPassword),
  },

  {
  path: 'profile',
  loadComponent: () =>
    import('./profile/profile').then(m => m.Profile),
  },

  {
  path: 'product/:id',
  loadComponent: () =>
    import('./product-detail/product-detail').then(m => m.ProductDetail),
},

  { path: '**', redirectTo: 'home' },
];

import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
import { NavBar } from "../nav-bar/nav-bar";


@Component({
  selector: 'app-search-result',
  standalone: true,
  imports: [CommonModule, NavBar, RouterModule],
  templateUrl: './search-result.html',
  styleUrl: './search-result.css',
})
export class SearchResult implements OnInit {
  filters: any = {};
  result: any[] = [];
  products: any[] = [];

private route= inject(ActivatedRoute);

  ngOnInit(): void {
      this.route.queryParams.subscribe(params =>{
        this.filters = params;
        this.search();
      });
  }

  search() {

  }
}

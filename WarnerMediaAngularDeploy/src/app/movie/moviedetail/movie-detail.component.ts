import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { Movie } from 'src/app/shared/objects/movie';
import { MovieService } from 'src/app/shared/services/movie.service';

@Component({
    templateUrl: './movie-detail.component.html',
    styleUrls: ['./movie-detail.component.css']
  })

export class MovieDetailComponent implements OnInit {
    pageTitle = 'Movie Detail';
    errorMessage = '';
    movie: Movie | undefined;

    constructor(private route: ActivatedRoute,
        private router: Router,
        private MovieService: MovieService) {
    }

    ngOnInit() {
      const param = this.route.snapshot.paramMap.get('id');
        if (param) {
          const id = +param;
          this.getMovie(id);
        }
      }

      getMovie(id: number) {
        this.MovieService.getMovie(id).subscribe(movie => {
          this.movie = movie;
        });
      }

      onBack(): void {
        this.router.navigate(['/movies']);
      }
}
import {Component, OnInit} from '@angular/core';
import { Movie } from 'src/app/shared/objects/movie';
import { MovieService } from 'src/app/shared/services/movie.service';
import { catchError, tap, map } from 'rxjs/operators';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { Router } from '@angular/router';

@Component({
    selector: 'pm-movies',
    templateUrl: './movie-list.component.html',
    styleUrls: ['./movie-list.component.css']
})

export class MovieListComponent implements OnInit{

    pageTitle: string = 'Movie List';
    imageWidth: number = 50;
    imageMargin: number = 2;
    showImage: boolean = false;
    _listFilter: string = 'casablanca';
    errorMessage: string;
    filteredMovies: Movie[];
    searchString: string = '';

    constructor(private movieService: MovieService, private router: Router) {
        
    }

    filterMovies() {
      this.movieService.getMovies(this.searchString).subscribe(
        movies => { 
          
          this.filteredMovies = movies;
        }
      )
    }

    goToProductDetail(productId: number) {
      
      this.router.navigate(['movies/' + productId.toString()]);
    }



    performFilter(filterBy: string): Movie[]{
      filterBy = filterBy.toLocaleLowerCase();
      
      this.movieService.getMovies(filterBy).subscribe(
            movies => { 
              
              this.filteredMovies = movies;
              
            }
      )
      
    return this.filteredMovies;
      
    }

    private handleError(err: HttpErrorResponse) {
      
      let errorMessage = '';
      if (err.error instanceof ErrorEvent) {
        
        errorMessage = `An error occurred: ${err.error.message}`;
      } else {
        
        errorMessage = `Server returned code: ${err.status}, error message is: ${err.message}`;
      }
      console.error(errorMessage);
      return throwError(errorMessage);
    }

    private extractData(res: Response): any {
      
      const body = res;
      return body || {};
    }

    toggleImage(): void {
        this.showImage = !this.showImage;
    }

    ngOnInit(): void {
      
      this.movieService.getMovies('').subscribe(
        movies => { 
          
          this.filteredMovies = movies;
          
        }
  )
    }
}
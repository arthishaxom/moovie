part of 'movie_cubit.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MovieModel> movies;

  MovieLoaded(this.movies);
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}

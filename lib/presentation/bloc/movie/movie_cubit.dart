// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mooive/models/movie_model.dart';
import 'package:mooive/repo/movie_repo.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepo movieRepo;
  MovieCubit(
    this.movieRepo,
  ) : super(MovieInitial());

  Future<void> fetchMovies() async {
    try {
      emit(MovieLoading());
      final List<MovieModel> movies = await movieRepo.getMovies();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(
        MovieError(
          e.toString(),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooive/models/movie_model.dart';
import 'package:mooive/repo/movie_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MovieRepo movieRepo;

  SearchCubit(this.movieRepo) : super(SearchInitial());

  void searchMovies(String query) async {
    try {
      emit(SearchLoading());
      final movies = await movieRepo.searchMovies(query);
      emit(SearchLoaded(movies));
    } catch (e) {
      emit(SearchError('Failed to load search results'));
    }
  }
}

import 'package:dio/dio.dart';
import 'package:mooive/models/movie_model.dart';

class MovieRepo {
  final Dio _dio;
  List<MovieModel> movies = [];
  List<MovieModel> searchRes = [];

  MovieRepo({required Dio dio}) : _dio = dio;

  Future<List<MovieModel>> getMovies() async {
    final res = await _dio.get('https://api.tvmaze.com/search/shows?q=all');
    for (Map<String, dynamic> m in res.data) {
      movies.add(
        MovieModel.fromJson(m),
      );
    }
    return movies;
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    searchRes.clear();
    final res = await _dio.get("https://api.tvmaze.com/search/shows?q=$query");
    for (Map<String, dynamic> m in res.data) {
      searchRes.add(
        MovieModel.fromJson(m),
      );
    }
    return searchRes;
  }
}

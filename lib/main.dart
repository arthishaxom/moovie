// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mooive/presentation/bloc/movie/movie_cubit.dart';
import 'package:mooive/presentation/bloc/search/search_cubit.dart';
import 'package:mooive/presentation/pages/home_page.dart';
import 'package:mooive/repo/movie_repo.dart';

void main() {
  final Dio dio = Dio();
  final MovieRepo movieRepo = MovieRepo(dio: dio);
  runApp(
    MyApp(
      movieRepo: movieRepo,
    ),
  );
}

class MyApp extends StatelessWidget {
  final MovieRepo movieRepo;
  const MyApp({
    super.key,
    required this.movieRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(movieRepo),
        ),
        BlocProvider(
          create: (context) => SearchCubit(movieRepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moovie',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: const Color.fromARGB(255, 255, 26, 26),
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

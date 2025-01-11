import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooive/presentation/bloc/search/search_cubit.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          leading: const Icon(Icons.search_rounded),
          trailing: [
            GestureDetector(
              onTap: () {
                searchController.clear();
              },
              child: const Icon(
                Icons.close_rounded,
              ),
            )
          ],
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          hintText: "Search a Movie Title",
          controller: searchController,
          onSubmitted: (value) {
            context.read<SearchCubit>().searchMovies(value);
          },
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 400),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MovieCard(movie: movie),
                  );
                },
              ),
            );
          } else if (state is SearchError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Search for a movie'));
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooive/models/movie_model.dart';
import 'package:mooive/presentation/bloc/movie/movie_cubit.dart';
import 'package:mooive/presentation/pages/search_page.dart';
import 'package:mooive/presentation/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _currIndex = 1;
              });
            },
          ),
        ],
      ),
      body: _currIndex == 0 ? _buildSections() : const SearchScreen(),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: Colors.transparent,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        selectedIndex: _currIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: Colors.white30,
            ),
            label: 'Home',
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.search,
              color: Colors.white30,
            ),
            label: 'Search',
            selectedIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSections() {
    return BlocBuilder<MovieCubit, MovieState>(
      builder: (context, state) {
        if (state is MovieInitial) {
          context.read<MovieCubit>().fetchMovies();
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieLoaded) {
          final movies = state.movies;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                _buildSection('Trending Now', movies),
                _buildSection('Top Picks', movies),
                _buildSection('New Releases', movies),
              ],
            ),
          );
        } else if (state is MovieError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Something went wrong.'));
        }
      },
    );
  }

  Widget _buildSection(String title, List<MovieModel> movies) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MovieCard(movie: movie),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

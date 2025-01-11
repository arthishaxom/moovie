import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mooive/models/movie_model.dart';

class DetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final tags = [movie.language, movie.type, movie.status];
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  alignment: Alignment.topCenter,
                  imageUrl: movie.imageurl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      LinearProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                movie.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 400,
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Badge(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      label: Text(tags[index]),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 8,
                  ),
                  itemCount: tags.length,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                movie.summary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

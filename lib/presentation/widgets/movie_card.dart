import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mooive/models/movie_model.dart';
import 'package:mooive/presentation/pages/details_page.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(movie: movie),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: movie.imageurl != ''
                    ? CachedNetworkImage(
                        imageUrl: movie.imageurl,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                LinearProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : const Placeholder(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              movie.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              movie.summary,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

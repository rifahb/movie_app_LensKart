import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../data/models/movie_model.dart';
import '../providers/user_list_provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: movie.backdropPath != null
                  ? CachedNetworkImage(
                      imageUrl: '${AppConstants.imageBaseUrl}${movie.backdropPath}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey[900]),
                      errorWidget: (context, url, error) => Container(color: Colors.grey[900]),
                    )
                  : Container(color: Colors.grey[900]),
            ),
            actions: [
              Consumer<UserListProvider>(
                builder: (context, provider, child) {
                  final isFav = provider.isFavorite(movie.id);
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      provider.toggleFavorite(movie);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(isFav ? 'Removed from Favorites' : 'Added to Favorites')),
                      );
                    },
                  );
                },
              ),
              Consumer<UserListProvider>(
                builder: (context, provider, child) {
                  final isWatch = provider.isWatchlisted(movie.id);
                  return IconButton(
                    icon: Icon(
                      isWatch ? Icons.bookmark : Icons.bookmark_border,
                      color: isWatch ? Colors.amber : Colors.white,
                    ),
                    onPressed: () {
                      provider.toggleWatchlist(movie);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(isWatch ? 'Removed from Watchlist' : 'Added to Watchlist')),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: '${AppConstants.imageBaseUrl}${movie.posterPath}',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const SizedBox(width: 100, height: 150),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Release Date: ${movie.releaseDate}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                CircularPercentIndicator(
                                  radius: 24.0,
                                  lineWidth: 4.0,
                                  percent: movie.voteAverage / 10,
                                  center: Text(
                                    movie.voteAverage.toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                  progressColor: Colors.green,
                                  backgroundColor: Colors.grey[800]!,
                                ),
                                const SizedBox(width: 12),
                                const Text('User Score'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // In-App Notification
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Movie is Playing"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

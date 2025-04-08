import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/movie.dart';
import '../config/constants.dart';
import 'common/glass_container.dart';
import 'common/glowing_card.dart';
import 'common/neumorphic_button.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  final List<Movie> similarMovies;
  final Function(Movie)? onSimilarMovieTap;

  const MovieDetails({
    Key? key,
    required this.movie,
    required this.similarMovies,
    this.onSimilarMovieTap,
  }) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late YoutubePlayerController _youtubeController;
  bool _isTrailerPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.movie.youtubeTrailerId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: widget.movie.youtubeTrailerId!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                widget.movie.backdropUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              if (widget.movie.youtubeTrailerId != null)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: NeumorphicButton(
                    onPressed: () {
                      setState(() => _isTrailerPlaying = !_isTrailerPlaying);
                    },
                    child: Icon(
                      _isTrailerPlaying ? Icons.close : Icons.play_arrow,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
            ],
          ),
          if (_isTrailerPlaying && widget.movie.youtubeTrailerId != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: theme.colorScheme.primary,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.movie.voteAverage.toStringAsFixed(1),
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.movie.year,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.timer,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.movie.runtime} min',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Overview',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.movie.overview,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                if (widget.movie.genres.isNotEmpty) ...[
                  Text(
                    'Genres',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.movie.genres.map((genre) {
                      return GlassContainer(
                        child: Text(
                          genre,
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 16),
                if (widget.similarMovies.isNotEmpty) ...[
                  Text(
                    'Similar Movies',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.similarMovies.length,
                      itemBuilder: (context, index) {
                        final movie = widget.similarMovies[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: GlowingCard(
                            onTap: () => widget.onSimilarMovieTap?.call(movie),
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.defaultBorderRadius,
                                    ),
                                    child: Image.network(
                                      movie.posterUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie.title,
                                  style: theme.textTheme.bodyMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(
          begin: 0.3,
          end: 0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
  }
} 
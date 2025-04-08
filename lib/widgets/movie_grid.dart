import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/movie.dart';
import '../config/constants.dart';
import 'common/glowing_card.dart';
import 'common/glass_container.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final Function(Movie)? onMovieTap;
  final bool isLoading;
  final ScrollController? scrollController;

  const MovieGrid({
    Key? key,
    required this.movies,
    this.onMovieTap,
    this.isLoading = false,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _calculateCrossAxisCount(constraints.maxWidth);
        final cellWidth = constraints.maxWidth / crossAxisCount;
        final cellHeight = cellWidth * AppConstants.cardAspectRatio;

        return SingleChildScrollView(
          controller: scrollController,
          child: LayoutGrid(
            columnSizes: List.filled(crossAxisCount, 1.fr),
            rowSizes: List.filled(
              (movies.length / crossAxisCount).ceil(),
              auto,
            ),
            children: movies.asMap().entries.map((entry) {
              final index = entry.key;
              final movie = entry.value;
              final row = index ~/ crossAxisCount;
              final column = index % crossAxisCount;

              return GridPlacement(
                columnStart: column,
                columnSpan: 1,
                rowStart: row,
                rowSpan: 1,
                child: GlowingCard(
                  onTap: () => onMovieTap?.call(movie),
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
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const Spacer(),
                          Text(
                            movie.year,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn().slideY(
                      begin: 0.3,
                      end: 0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  int _calculateCrossAxisCount(double width) {
    if (width > 1200) return 6;
    if (width > 900) return 5;
    if (width > 600) return 4;
    if (width > 400) return 3;
    return 2;
  }
} 
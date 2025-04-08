import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../config/theme.dart';

class TrailerPlayer extends StatefulWidget {
  final String videoId;
  final bool autoPlay;

  const TrailerPlayer({
    Key? key,
    required this.videoId,
    this.autoPlay = false,
  }) : super(key: key);

  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: widget.autoPlay,
        mute: false,
        enableCaption: true,
        captionLanguage: 'en',
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: theme.colorScheme.primary,
          progressColors: ProgressBarColors(
            playedColor: theme.colorScheme.primary,
            handleColor: theme.colorScheme.primary,
            bufferedColor: theme.colorScheme.primary.withOpacity(0.3),
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          ),
          onReady: () {
            _controller.addListener(() {
              if (_controller.value.isFullScreen) {
                _controller.toggleFullScreenMode();
              }
            });
          },
        ),
      ),
    );
  }
} 
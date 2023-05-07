import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerWidget extends StatefulWidget {
  final String videoUrl;

  const TrailerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<TrailerWidget> createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      height: 160.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(widget.videoUrl)}/hqdefault.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            ),
          );
        },
        child: const Center(
          child: Icon(
            Icons.play_circle_outline,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

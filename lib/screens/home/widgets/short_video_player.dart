import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortVideoPlayer extends StatefulWidget {

  final String videoUrl;

  const ShortVideoPlayer({
    super.key,
    required this.videoUrl,
  });

  @override
  State<ShortVideoPlayer> createState() =>
      _ShortVideoPlayerState();
}

class _ShortVideoPlayerState
    extends State<ShortVideoPlayer> {

  late VideoPlayerController controller;

  @override
  void initState() {

    super.initState();

    controller =
        VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )
          ..initialize().then((_) {

            controller.play();

            controller.setLooping(true);

            setState(() {});
          });
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!controller.value.isInitialized) {

      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox.expand(

      child: FittedBox(

        fit: BoxFit.cover,

        child: SizedBox(

          width:
              controller.value.size.width,

          height:
              controller.value.size.height,

          child: VideoPlayer(
            controller,
          ),
        ),
      ),
    );
  }
}
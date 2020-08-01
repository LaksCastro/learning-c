import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final String url;
  final String title;

  Player({this.title = 'Chewie Demo', this.url});

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState(url: url);
  }
}

class _ChewieDemoState extends State<Player> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  final String url;

  _ChewieDemoState({this.url});

  initializePlayerController() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();

    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowFullScreen: true,
        allowedScreenSleep: false,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ],
        fullScreenByDefault: true,
        systemOverlaysAfterFullScreen: [
          SystemUiOverlay.bottom,
          SystemUiOverlay.top
        ],
        placeholder: Container(
          color: Colors.black,
        ),
        autoInitialize: true,
      );

      _chewieController.enterFullScreen();
    });
  }

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(url);

    initializePlayerController();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 0,
        child: (_chewieController == null)
            ? Center(child: CircularProgressIndicator())
            : (Container(
                child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    ),
                  ),
                ],
              ))));
  }
}

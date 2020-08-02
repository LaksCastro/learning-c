import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final String url;

  Player({this.url});

  @override
  State<StatefulWidget> createState() {
    return _PlayerState(url: url);
  }
}

class _PlayerState extends State<Player> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  final String url;

  _PlayerState({this.url});

  initializePlayerController() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowedScreenSleep: false,
        allowFullScreen: true,
        fullScreenByDefault: true,
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
    _videoPlayerController?.dispose();
    _chewieController?.dispose();

    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

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

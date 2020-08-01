import 'package:anime_dart/get_it.dart';
import 'package:anime_dart/store/watch_episode_controller.dart';
import 'package:flutter/material.dart';

import "package:anime_dart/models/barrel.dart";
import "package:anime_dart/components/barrel.dart";

class WatchEpisode extends StatefulWidget {
  final WatchEpisodeArgs args;

  WatchEpisode({this.args});

  @override
  _WatchEpisodeState createState() => _WatchEpisodeState(args: args);
}

class _WatchEpisodeState extends State<WatchEpisode> {
  final WatchEpisodeArgs args;
  final watchEpisodeController = getIt<WatchEpisodeController>();

  _WatchEpisodeState({this.args});
  @override
  void initState() {
    watchEpisodeController.setEpisodeInfo(
        labelValue: args.label,
        imageUrlValue: args.imageUrl,
        episodeIdValue: args.episodeId);

    watchEpisodeController.loadVideoUrl();

    super.initState();
  }

  void dispose() {
    watchEpisodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(args.label)),
        body: SingleChildScrollView(
            child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 0,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  EpisodeInfo(),
                  WatchButtons(),
                ],
              ),
            ),
          ),
        )));
  }
}

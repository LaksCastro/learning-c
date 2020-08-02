import 'package:anime_dart/get_it.dart';
import 'package:anime_dart/models/anime_details_args.dart';
import 'package:anime_dart/screens/anime_details.dart';
import 'package:anime_dart/store/watch_episode_controller.dart';
import 'package:flutter/material.dart';

import "package:anime_dart/models/watch_episode_args.dart";
import "package:anime_dart/components/barrel.dart";
import 'package:flutter_mobx/flutter_mobx.dart';

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
        animeIdValue: args.animeId,
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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 0,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  WatchEpisodeHeader(
                    imageUrl: args.imageUrl,
                    label: args.label,
                  ),
                  Observer(builder: (_) {
                    if (watchEpisodeController.loadingVideoUrl) {
                      return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: CircularProgressIndicator());
                    }

                    return WatchButtons(
                      videoUrlHd: watchEpisodeController.videoUrlHd,
                      videoUrl: watchEpisodeController.videoUrl,
                    );
                  })
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AnimeDetails(
                        args: AnimeDetailsArgs(
                            animeId: watchEpisodeController.animeId,
                            title: watchEpisodeController.label))));
          },
          label: Text('Ver lista de episódios'),
          icon: Icon(Icons.playlist_add_check),
        ));
  }
}

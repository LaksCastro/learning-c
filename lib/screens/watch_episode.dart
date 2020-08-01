import 'package:anime_dart/get_it.dart';
import 'package:anime_dart/screens/player.dart';
import 'package:anime_dart/services/anime_tv_api.dart';
import 'package:anime_dart/store/watch_episode_controller.dart';
import 'package:anime_dart/theme/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import "package:anime_dart/models/barrel.dart";
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

class EpisodeInfo extends StatefulWidget {
  @override
  _EpisodeInfoState createState() => _EpisodeInfoState();
}

class _EpisodeInfoState extends State<EpisodeInfo> {
  final watchEpisodeController = getIt<WatchEpisodeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black.withOpacity(.1),
        padding: EdgeInsets.all(20),
        child: Observer(builder: (_) {
          if (!watchEpisodeController.episodeInfoLoaded) {
            return Center(child: CircularProgressIndicator());
          }

          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: 140,
                height: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        httpHeaders: AnimeTvApi.httpHeaders,
                        imageUrl: watchEpisodeController.imageUrl,
                        placeholder: (context, url) => Container(
                            width: 140,
                            height: 200,
                            color: Colors.purple.withOpacity(.10)),
                        errorWidget: (context, url, error) => Container(
                            width: 140,
                            height: 200,
                            color: Colors.black.withOpacity(.60))))),
            Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text("HD",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(watchEpisodeController.label,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .fontSize)))
                ]))
          ]);
        }));
  }
}

class WatchButtons extends StatefulWidget {
  @override
  _WatchButtonsState createState() => _WatchButtonsState();
}

class _WatchButtonsState extends State<WatchButtons> {
  final watchEpisodeController = getIt<WatchEpisodeController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Observer(builder: (_) {
        if (watchEpisodeController.loadingVideoUrl) {
          return Container(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()));
        }

        return Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            RippleButton(
                color: AppTheme.primaryColor,
                onTap: () {
                  if (watchEpisodeController.videoUrlHd == null) {
                    return;
                  }

                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Player(url: watchEpisodeController.videoUrlHd);
                  }));
                },
                label: "Assistir em HD"),
            RippleButton(
                color: Colors.blue[600],
                onTap: () {
                  if (watchEpisodeController.videoUrl == null) {
                    return;
                  }

                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Player(url: watchEpisodeController.videoUrl);
                  }));
                },
                label: "Assistir"),
          ]),
        );
      }),
    );
  }
}

class RippleButton extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final Color color;

  RippleButton({this.onTap, this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(5)),
              child: Material(
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Text(label,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ),
                color: Colors.transparent,
              ),
            )));
  }
}

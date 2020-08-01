import 'package:anime_dart/get_it.dart';
import 'package:anime_dart/services/anime_tv_api.dart';
import 'package:anime_dart/store/watch_episode_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

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

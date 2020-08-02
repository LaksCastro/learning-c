import 'package:anime_dart/models/barrel.dart';
import 'package:flutter/material.dart';

import "package:anime_dart/components/anime_details_episodes_tile.dart";

class AnimeDetailsEpisodes extends StatelessWidget {
  final List<EpisodeInfo> episodes;

  AnimeDetailsEpisodes({Key key, @required this.episodes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    for (final episode in episodes) {
      items.add(GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: episode.link));
          },
          child: Container(
              alignment: Alignment.centerLeft,
              color: Colors.black.withOpacity(0.1),
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(20),
              child: Text(episode.label))));
    }

    List<Widget> body = [];

    body.add(Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(children: items)));

    return Container(
      child: Column(
        children: body,
      ),
    );
  }
}

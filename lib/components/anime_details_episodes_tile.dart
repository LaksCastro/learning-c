import 'package:anime_dart/models/barrel.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class AnimeDetailsEpisodesTile extends StatelessWidget {
  final EpisodeInfo episode;

  AnimeDetailsEpisodesTile({Key key, this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: episode.link));
        },
        child: Container(
            alignment: Alignment.centerLeft,
            color: Theme.of(context).backgroundColor,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(20),
            child: Row(children: [
              Icon(OMIcons.playArrow,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.5)),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child:
                          Text(episode.label, style: TextStyle(height: 1.5)))),
            ])));
  }
}

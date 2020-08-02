import 'package:anime_dart/components/ripple_button.dart';
import 'package:anime_dart/screens/player.dart';
import 'package:flutter/material.dart';

class WatchButtons extends StatelessWidget {
  final String videoUrlHd;
  final String videoUrl;

  WatchButtons({this.videoUrlHd, @required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          videoUrlHd == null
              ? (RippleButton(
                  color: Colors.grey[600],
                  onTap: () {},
                  label: "Esse episódio não está disponível em HD"))
              : (RippleButton(
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: () {
                    if (videoUrlHd == null) {
                      return;
                    }

                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Player(url: videoUrlHd);
                    }));
                  },
                  label: "Assistir em HD")),
          RippleButton(
              color: Theme.of(context).colorScheme.secondaryVariant,
              onTap: () {
                if (videoUrl == null) {
                  return;
                }

                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Player(url: videoUrl);
                }));
              },
              label: "Assistir"),
        ]),
      ),
    );
  }
}

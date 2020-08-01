import 'package:anime_dart/components/ripple_button.dart';
import 'package:anime_dart/get_it.dart';
import 'package:anime_dart/screens/player.dart';
import 'package:anime_dart/store/watch_episode_controller.dart';
import 'package:anime_dart/theme/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

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

import 'package:anime_dart/get_it.dart';
import 'package:anime_dart/store/barrel.dart';
import 'package:flutter/material.dart';

import "package:anime_dart/models/barrel.dart";
import "package:anime_dart/components/barrel.dart";
import 'package:flutter_mobx/flutter_mobx.dart';

class AnimeDetails extends StatefulWidget {
  final AnimeDetailsArgs args;

  AnimeDetails({this.args});

  @override
  _AnimeDetailsState createState() => _AnimeDetailsState(args: args);
}

class _AnimeDetailsState extends State<AnimeDetails> {
  final AnimeDetailsArgs args;
  final animeDetailsController = getIt<AnimeDetailsController>();

  _AnimeDetailsState({this.args});

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Observer(builder: (_) {
      if (animeDetailsController.loading) {
        return Text(args.title);
      }

      return Text(animeDetailsController.details.title);
    })), body: Observer(builder: (_) {
      if (animeDetailsController.loading) {
        return Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
          child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 0,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                AnimeDetailsHeader(),
                AnimeDetailsEpisodes(),
              ],
            ),
          ),
        ),
      ));
    }));
  }
}

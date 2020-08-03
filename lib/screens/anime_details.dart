import 'dart:async';

import 'package:anime_dart/get_it.dart';
import 'package:anime_dart/store/barrel.dart';
import 'package:flutter/material.dart';

import "package:anime_dart/models/barrel.dart";
import "package:anime_dart/components/barrel.dart";
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class AnimeDetails extends StatefulWidget {
  final AnimeDetailsArgs args;

  AnimeDetails({this.args});

  @override
  _AnimeDetailsState createState() => _AnimeDetailsState(args: args);
}

class _AnimeDetailsState extends State<AnimeDetails> {
  final AnimeDetailsArgs args;
  final animeDetailsController = getIt<AnimeDetailsController>();

  final _searchQuery = TextEditingController();
  Timer _debounce;

  _AnimeDetailsState({this.args});

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final text = _searchQuery.text;

      if (text == animeDetailsController.internalSearch) {
        return;
      }

      animeDetailsController.setInternalSearch(text);
      animeDetailsController.filterEpisodes();
    });
  }

  _enableSearchMode() {
    animeDetailsController.showSearchField(true);
  }

  _closeSearchMode() {
    _searchQuery.clear();
    animeDetailsController.closeSearchMode();
  }

  @override
  void initState() {
    super.initState();

    animeDetailsController.loadDetails(args.animeId);

    _searchQuery.addListener(_onSearchChanged);
  }

  void dispose() {
    animeDetailsController.dispose();

    _searchQuery?.removeListener(_onSearchChanged);
    _searchQuery?.dispose();
    _debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Observer(builder: (_) {
          if (animeDetailsController.loading) {
            return Text(args.title);
          }

          if (animeDetailsController.showSearch) {
            return Row(children: [
              Expanded(
                  child: TextField(
                      autofocus: true,
                      style: TextStyle(
                          color: Theme.of(context).primaryIconTheme.color),
                      cursorColor: Theme.of(context).primaryIconTheme.color,
                      decoration: InputDecoration.collapsed(
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .primaryIconTheme
                                  .color
                                  .withOpacity(0.5)),
                          hintText: 'Digite o número do episódio'),
                      controller: _searchQuery)),
              GestureDetector(
                  onTap: _closeSearchMode,
                  child: Container(
                      height: 40,
                      width: 50,
                      child: Icon(Icons.close),
                      alignment: Alignment.centerRight))
            ]);
          }

          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(animeDetailsController.details.title)),
                GestureDetector(
                    onTap: _enableSearchMode,
                    child: Container(
                        height: 40,
                        width: 50,
                        child: Icon(Icons.search),
                        alignment: Alignment.centerRight))
              ]);
        })),
        body: Observer(builder: (_) {
          if (animeDetailsController.loading) {
            return Center(child: CircularProgressIndicator());
          }

          List<Widget> body = [];

          if (!animeDetailsController.searchMode &&
              !animeDetailsController.showSearch) {
            body.add(
                AnimeDetailsHeader(details: animeDetailsController.details));
          }
          if (animeDetailsController.searchMode) {
            if (animeDetailsController.notFoundInternalSearch) {
              return Center(
                  child: Text(
                      "Não foi posível encontrar o episódio especificado"));
            }

            body.add(AnimeDetailsEpisodes(
                episodes: animeDetailsController.filteredEpisodes));
          } else {
            body.add(AnimeDetailsEpisodes(
                episodes: animeDetailsController.details.episodes));
          }

          return SingleChildScrollView(
            child: Container(
                child: Column(
              children: body,
            )),
          );
        }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).backgroundColor,
            onPressed: () {},
            child: Icon(Icons.favorite, color: Colors.red[300])));
  }
}

import 'package:anime_dart/models/barrel.dart';
import 'package:anime_dart/services/anime_tv_api.dart';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

class SearchProvider {
  static final _animeTvApi = AnimeTvApi();

  String getKeyword(String text) {
    return removeDiacritics(text.replaceAll(" ", "_"));
  }

  Future<List<Resource>> searchByKeyword(String keyword) async {
    try {
      List<Resource> resources = [];

      final resourcesData =
          await SearchProvider._animeTvApi.searchByKeyword(keyword);

      for (final resourceData in resourcesData) {
        resources.add(
          Resource(
              imageUrl: resourceData.imageUrl,
              label: resourceData.label,
              id: resourceData.id,
              link: (_) => Scaffold(
                  appBar:
                      AppBar(title: Text("Page Anime Info and Episodes List")),
                  body: Center(
                      child: Text(
                          "Aqui será listado os episodios de um certo anime")))),
        );
      }

      return resources;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

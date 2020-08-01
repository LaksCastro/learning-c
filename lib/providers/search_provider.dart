import 'package:anime_dart/models/barrel.dart';
import 'package:anime_dart/services/anime_tv_api.dart';

import 'package:diacritic/diacritic.dart';

class SearchProvider {
  static final _animeTvApi = AnimeTvApi();

  String getKeyword(String text){
    return removeDiacritics(text.replaceAll(" ", "_"));
  }

  Future<List<Resource>> searchByKeyword(String keyword) async {
    try {
      List<Resource> resources = [];

      final resourcesData = await LatestProvider._animeTvApi.searchByKeyword(keyword);

      for (final resourceData in resourcesData) {
        resources.add(
          Resource(
              imageUrl: resourceData.imageUrl,
              label: resourceData.label,
              id: resourceData.id,
              link: (_) => WatchEpisode(
                  args: WatchEpisodeArgs(
                      episodeId: resourceData.id,
                      imageUrl: resourceData.imageUrl,
                      label: resourceData.label))),
        );
      }

      return resources;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

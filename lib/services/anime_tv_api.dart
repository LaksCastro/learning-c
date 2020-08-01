import "dart:convert";
import "dart:async";

import 'package:http/http.dart' as http;

import 'package:anime_dart/models/barrel.dart';

class AnimeTvApi {
  static final Map<String, String> httpHeaders = {
    "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36"
  };

  final String _baseUrl = "https://appanimeplus.tk/api-achance.php";
  final String _imageBaseUrl = "https://cdn.appanimeplus.tk/img/";

  Future<List<ResourceData>> getLatest() async {
    final response =
        await http.get("$_baseUrl?latest", headers: AnimeTvApi.httpHeaders);

    final data = json.decode(response.body.substring(3)) as List;

    List<ResourceData> resources = [];

    for (final element in data) {
      resources.add(ResourceData(
          imageUrl: "$_imageBaseUrl${element["category_image"]}",
          label: element["title"],
          id: element["video_id"]));
    }

    return resources;
  }

  Future<VideoData> getVideo(String episodeId) async {
    final response = await http.get("$_baseUrl?episodios=$episodeId",
        headers: AnimeTvApi.httpHeaders);

    final data = json.decode(response.body.substring(3));

    String urlHd = data[0]["locationsd"] ?? "";

    final videoData = VideoData(
        episodeId: episodeId,
        url: data[0]["location"],
        urlHd: urlHd.length > 5 ? urlHd : null);

    return videoData;
  }

  Future<List<ResourceData>> searchByKeyword(String keyword){
    try {
       
    final response =
        await http.get("$_baseUrl?search=$keyword", headers: AnimeTvApi.httpHeaders);

    final data = json.decode(response.body.substring(3)) as List;

    List<ResourceData> resources = [];

    for (final element in data) {
      resources.add(ResourceData(
          imageUrl: "$_imageBaseUrl${element["category_image"]}",
          label: element["category_name"],
          id: element["id"]));
    }

    return resources;
    } catch(e){
      return [];
    }
  }
}

import 'package:anime_dart/models/anime_details_args.dart';
import 'package:anime_dart/screens/anime_details.dart';
import 'package:anime_dart/services/anime_tv_api.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:anime_dart/models/resource.dart';

class ResourceTile extends StatelessWidget {
  final Resource resource;
  final bool isLast;
  final String cardLabel;

  ResourceTile({Key key, this.resource, this.isLast, this.cardLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = 100;
    double imageHeight = 140;

    return GestureDetector(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: resource.link)),
        child: Container(
            margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
            padding: EdgeInsets.all(10),
            color: Colors.black.withOpacity(.05),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  width: imageWidth,
                  height: imageHeight,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          httpHeaders: AnimeTvApi.httpHeaders,
                          imageUrl: resource.imageUrl,
                          placeholder: (context, url) => Container(
                              width: imageWidth,
                              height: imageHeight,
                              color: Colors.purple.withOpacity(.10)),
                          errorWidget: (context, url, error) => Container(
                              width: imageWidth,
                              height: imageHeight,
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
                      child: Text(cardLabel,
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(resource.label,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .fontSize))),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: FlatButton(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return AnimeDetails(
                                    args: AnimeDetailsArgs(
                                        animeId: resource.linkId ?? resource.id,
                                        title: resource.label));
                              }));
                            },
                            child: Text("Listar episódios")))
                  ]))
            ])));
  }
}

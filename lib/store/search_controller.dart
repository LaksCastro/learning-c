import 'package:anime_dart/models/barrel.dart';
import 'package:mobx/mobx.dart';
import "package:anime_dart/providers/search_provider.dart";

part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final _provider = SearchProvider();

  @observable
  String text = "";

  @observable
  ObservableList<Resource> results = ObservableList<Resource>.of([]);

  @computed
  bool get waitingType => text == "";

  @computed
  bool get notFound => text != "" && results.length == 0;

  @action
  setText(value) {
    text = value;
  }

  @action
  loadResults() async {
    final keyword = _provider.getKeyword(text);

    final searchedResources = await _provider.searchByKeyword(keyword);

    runInAction(() {
      results.addAll(ObservableList<Resource>.of(searchedResources));
    });
  }
}

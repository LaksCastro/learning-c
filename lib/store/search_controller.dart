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

  @action
  setText(value) {
    text = value;
  }

  @action
  loadResults() {}
}

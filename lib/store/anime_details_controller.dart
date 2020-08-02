import 'package:anime_dart/models/barrel.dart';
import 'package:anime_dart/providers/barrel.dart';
import 'package:mobx/mobx.dart';
part 'anime_details_controller.g.dart';

class AnimeDetailsController = _AnimeDetailsControllerBase
    with _$AnimeDetailsController;

abstract class _AnimeDetailsControllerBase with Store {
  final _provider = AnimeDetailsProvider();

  @observable
  AnimeDetails details;

  @observable
  bool error = false;

  @computed
  bool get loading => details == null && error == false;

  @action
  loadDetails(String animeId) async {
    final animeDetails = await _provider.detailsOf(animeId);

    if (animeDetails == null) {
      return runInAction(() {
        error = true;
        details = null;
      });
    }

    runInAction(() {
      details = animeDetails;
      error = false;
    });
  }

  @action
  dispose() {
    details = null;
    error = false;
  }
}

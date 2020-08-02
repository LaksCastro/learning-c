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

  @observable
  String internalSearch = "";

  @observable
  var filteredEpisodes = ObservableList<EpisodeInfo>.of([]);

  @observable
  bool showSearch = false;

  @computed
  bool get searchMode => internalSearch != "";

  @computed
  bool get notFoundInternalSearch => searchMode && filteredEpisodes.length == 0;

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
  showSearchField(bool yesOrNo) {
    showSearch = yesOrNo;
  }

  @action
  setInternalSearch(String keyword) {
    internalSearch = keyword;
  }

  @action
  closeSearchMode() {
    showSearchField(false);
    setInternalSearch("");
    filteredEpisodes = ObservableList<EpisodeInfo>.of([]);
  }

  @action
  filterEpisodes() {
    int length = details.episodes.length;

    filteredEpisodes = ObservableList<EpisodeInfo>.of([]);

    for (int i = length - 1; i >= 0; i--) {
      final episode = details.episodes[i];

      if (episode.label.contains(internalSearch)) {
        filteredEpisodes.add(episode);
      }
    }
  }

  @action
  dispose() {
    details = null;
    error = false;
    showSearch = false;
    internalSearch = "";
    filteredEpisodes = ObservableList<EpisodeInfo>.of([]);
  }
}

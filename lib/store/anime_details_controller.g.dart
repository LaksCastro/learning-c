// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AnimeDetailsController on _AnimeDetailsControllerBase, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_AnimeDetailsControllerBase.loading'))
      .value;

  final _$detailsAtom = Atom(name: '_AnimeDetailsControllerBase.details');

  @override
  AnimeDetails get details {
    _$detailsAtom.reportRead();
    return super.details;
  }

  @override
  set details(AnimeDetails value) {
    _$detailsAtom.reportWrite(value, super.details, () {
      super.details = value;
    });
  }

  final _$errorAtom = Atom(name: '_AnimeDetailsControllerBase.error');

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loadDetailsAsyncAction =
      AsyncAction('_AnimeDetailsControllerBase.loadDetails');

  @override
  Future loadDetails(String animeId) {
    return _$loadDetailsAsyncAction.run(() => super.loadDetails(animeId));
  }

  final _$_AnimeDetailsControllerBaseActionController =
      ActionController(name: '_AnimeDetailsControllerBase');

  @override
  dynamic dispose() {
    final _$actionInfo = _$_AnimeDetailsControllerBaseActionController
        .startAction(name: '_AnimeDetailsControllerBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_AnimeDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
details: ${details},
error: ${error},
loading: ${loading}
    ''';
  }
}

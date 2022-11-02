import 'dart:async';

import 'package:wallpaper_demo/domain/usecase/search_usecase.dart';
import 'package:wallpaper_demo/presentation/base/base_viewmodel.dart';
import 'package:wallpaper_demo/presentation/common/freezed/freezed_data_class.dart';
import 'package:wallpaper_demo/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/model/model.dart';
import '../common/state_renderer/state_renderer_impl.dart';

class SearchViewModel extends BaseViewModel
    with SearchViewModelInputs, SearchViewModelOutputs {
  StreamController _searchStreamController = BehaviorSubject<List<Source>>();

  var searchObject = SearchObject('');

  SearchUseCase _searchUseCase;
  SearchViewModel(this._searchUseCase);

  @override
  // TODO: implement inputSearch
  Sink get inputSearch => _searchStreamController.sink;

  @override
  // TODO: implement outputSearch
  Stream<List<Source>> get outputSearch =>
      _searchStreamController.stream.map((search) => search);

  @override
  setSearch(String search) {
    if (search.isNotEmpty) {
      searchObject = searchObject.copyWith(search: search);
    }
  }

  _search() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await _searchUseCase.execute(SearchUseCaseInput(searchObject.search)))
        .fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
    }, (searchResult) {
      inputState.add(ContentState());
      inputSearch.add(searchResult.photo);
    });
  }

  @override
  void start() {
    _search();
  }

  @override
  void dispose() {
    _searchStreamController.close();
    super.dispose();
  }
}

abstract class SearchViewModelInputs {
  setSearch(String search);
  Sink get inputSearch;
}

abstract class SearchViewModelOutputs {
  Stream<List<Source>> get outputSearch;
}

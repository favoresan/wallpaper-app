import 'dart:async';
import 'dart:ffi';

import 'package:rxdart/subjects.dart';
import 'package:wallpaper_demo/domain/model/model.dart';
import 'package:wallpaper_demo/domain/usecase/grid_usecase.dart';
import 'package:wallpaper_demo/presentation/common/state_renderer/state_renderer.dart';
import 'package:wallpaper_demo/presentation/common/state_renderer/state_renderer_impl.dart';

import '../base/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  StreamController _gridStreamController = BehaviorSubject<List<Source>>();
  StreamController _inputSearchController = BehaviorSubject<String>();
  GridUseCase _gridUseCase;
  HomeViewModel(this._gridUseCase);
  @override
  void dispose() {
    // TODO: implement dispose
    _gridStreamController.close();
  }

  @override
  void start() {
    _getGrid();
  }

  _getGrid() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await _gridUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
      // print(failure.message);
    }, (data) {
      inputState.add(ContentState());
      inputGridData.add(data.photo);
      // print(data.photo);
    });
  }

  @override
  // TODO: implement inputGridData
  Sink get inputGridData => _gridStreamController.sink;

  @override
  // TODO: implement outputGridData
  Stream<List<Source>> get outputGridData =>
      _gridStreamController.stream.map((grid) => grid);

  @override
  // TODO: implement inputSearch
  Sink get inputSearch => _inputSearchController.sink;

  bool _isSearchValid(String search) {
    return search.length >= 3;
  }

  @override
  // TODO: implement outPutSearch
  Stream<bool> get outPutSearchValid =>
      _inputSearchController.stream.map((search) => _isSearchValid(search));

  @override
  setSearch(String search) {
    inputSearch.add(search);
  }
}

abstract class HomeViewModelInputs {
  setSearch(String search);
  Sink get inputGridData;
  Sink get inputSearch;
}

abstract class HomeViewModelOutputs {
  Stream<List<Source>> get outputGridData;
  Stream<bool> get outPutSearchValid;
}

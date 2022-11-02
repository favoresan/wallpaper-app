import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:wallpaper_demo/domain/usecase/category_usecase.dart';
import 'package:wallpaper_demo/presentation/base/base_viewmodel.dart';
import 'package:wallpaper_demo/presentation/common/freezed/freezed_data_class.dart';

import '../../domain/model/model.dart';
import '../../domain/usecase/search_usecase.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_impl.dart';

class CategoryViewModel extends BaseViewModel
    with CategoryViewModelInputs, CategoryViewModelOutputs {
  StreamController _categoryStreamController = BehaviorSubject<List<Source>>();
  var categoryObject = SearchObject('');

  CategoryUseCase _categoryUseCase;
  CategoryViewModel(this._categoryUseCase);

  @override
  // TODO: implement inputCategorySearch
  Sink get inputCategorySearch => _categoryStreamController.sink;

  @override
  // TODO: implement outputCategorySearch
  Stream<List<Source>> get outputCategorySearch =>
      _categoryStreamController.stream.map((search) => search);

  @override
  setSearch(String search) {
    if (search.isNotEmpty) {
      categoryObject = categoryObject.copyWith(search: search);
    }
  }

  _search() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await _categoryUseCase
            .execute(CategoryUseCaseInput(categoryObject.search)))
        .fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
    }, (searchResult) {
      inputState.add(ContentState());
      inputCategorySearch.add(searchResult.photo);
    });
  }

  @override
  void start() {
    _search();
  }

  @override
  void dispose() {
    _categoryStreamController.close();
    super.dispose();
  }
}

abstract class CategoryViewModelInputs {
  setSearch(String search);
  Sink get inputCategorySearch;
}

abstract class CategoryViewModelOutputs {
  Stream<List<Source>> get outputCategorySearch;
}

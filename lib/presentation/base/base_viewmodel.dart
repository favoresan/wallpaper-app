import 'dart:async';

import 'package:wallpaper_demo/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  // TODO: implement inputState
  Sink get inputState => _inputStreamController.sink;

  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}

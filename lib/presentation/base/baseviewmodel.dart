import 'dart:async';

import 'package:flutter_restapi/presentation/base/common/state_renderer/state_renderer.impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  //shared variable and function that will be used through any view model

  final StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateStreamController;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowstate) => flowstate);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start();

  //will be called while init. of view model
  void dispose();

//will be called when viewmodel dies

  Sink get inputState;
}

abstract mixin class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}

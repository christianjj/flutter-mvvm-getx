import 'dart:async';
import 'dart:ffi';

import 'package:flutter_restapi/domain/model/model.dart';
import 'package:flutter_restapi/domain/usecase/home_usecase.dart';
import 'package:flutter_restapi/presentation/base/baseviewmodel.dart';
import 'package:flutter_restapi/presentation/base/common/state_renderer/state_renderer.dart';
import 'package:flutter_restapi/presentation/base/common/state_renderer/state_renderer.impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  final StreamController _homeObjectStreamContoller =
      BehaviorSubject<HomeViewData>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHome();
  }

  _getHome() async{
  inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
  (await _homeUseCase.execute(Void))
      .fold((failure){
        inputState.add(ErrorState(StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));

  },
          (homeObject)  {
          inputState.add(ContentState());
          inputHomeObject.add(HomeViewData(homeObject.data.services, homeObject.data.store, homeObject.data.banner));
          });
  }

  @override
  void dispose() {
    _homeObjectStreamContoller.close();
    super.dispose();
  }

  @override
  Sink get inputHomeObject => _homeObjectStreamContoller.sink;


  @override
  Stream<HomeViewData> get outputHomeObject =>
      _homeObjectStreamContoller.stream.map((homeObject) => homeObject);


}

abstract mixin class HomeViewModelInputs {
  Sink get inputHomeObject;
}

abstract mixin class HomeViewModelOutputs {
  Stream<HomeViewData> get outputHomeObject;

}

class HomeViewData{
  List<Services> services;
  List<Store> store;
  List<Banners> banner;

  HomeViewData(this.services, this.store, this.banner);
}



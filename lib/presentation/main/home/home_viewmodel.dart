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

  final StreamController _bannerStreamController =
      BehaviorSubject<List<Banners>>();
  final StreamController _serviceStreamController =
      BehaviorSubject<List<Services>>();
  final StreamController _storeStreamController =
      BehaviorSubject<List<Store>>();

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
          inputBanners.add(homeObject.data.banner);
          inputServices.add(homeObject.data.services);
          inputStores.add(homeObject.data.store);

          });
  }

  @override
  void dispose() {
    _serviceStreamController.close();
    _bannerStreamController.close();
    _storeStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannerStreamController.sink;

  @override
  Sink get inputServices => _serviceStreamController.sink;

  @override
  Sink get inputStores => _storeStreamController.sink;

  @override
  Stream<List<Banners>> get outputBanner =>
      _bannerStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Services>> get outputServices =>
      _serviceStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storeStreamController.stream.map((store) => store);
}

abstract mixin class HomeViewModelInputs {
  Sink get inputStores;

  Sink get inputServices;

  Sink get inputBanners;
}

abstract mixin class HomeViewModelOutputs {
  Stream<List<Store>> get outputStores;

  Stream<List<Services>> get outputServices;

  Stream<List<Banners>> get outputBanner;
}

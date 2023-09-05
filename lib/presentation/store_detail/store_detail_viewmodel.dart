import 'dart:async';
import 'dart:ffi';

import 'package:flutter_restapi/domain/model/model.dart';
import 'package:flutter_restapi/domain/usecase/store_details_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../base/baseviewmodel.dart';
import '../base/common/state_renderer/state_renderer.dart';
import '../base/common/state_renderer/state_renderer.impl.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  StoreDetailsUseCase _storeDetailsUseCase;

  StoreDetailsViewModel(this._storeDetailsUseCase);

  final StreamController _storeObjectStreamContoller =
      BehaviorSubject<StoreDetails>();

  var id = 0;

  @override
  void start() {
    getStoreDetails();
  }

  @override
  void dispose() {
    _storeObjectStreamContoller.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetailsObject => _storeObjectStreamContoller.sink;

  @override
  Stream<StoreDetails> get outputStoreDetailsObject =>
      _storeObjectStreamContoller.stream.map((storeDetails) => storeDetails);


  getStoreDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _storeDetailsUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (storeDetailsObject) {
      inputState.add(ContentState());
      inputStoreDetailsObject.add(storeDetailsObject);
    });
  }
}

abstract mixin class StoreDetailsViewModelInputs {
  Sink get inputStoreDetailsObject;


}

abstract mixin class StoreDetailsViewModelOutputs {
  Stream<StoreDetails> get outputStoreDetailsObject;
}

class StoreDetailsViewData {
  int id;
  String image;
  String title;
  String details;
  String services;
  String about;

  StoreDetailsViewData(
      this.id, this.image, this.title, this.details, this.services, this.about);
}

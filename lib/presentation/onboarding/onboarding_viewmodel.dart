import 'dart:async';

import 'package:flutter_restapi/domain/model/model.dart';
import 'package:flutter_restapi/presentation/base/baseviewmodel.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
//stream controllers

  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
   _streamController.close();

  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
    //send this slider data to our view
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex ++;
    if (nextIndex > _list.length - 2){
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrev() {
    int previousIndex = _currentIndex --;
    if (previousIndex == -1){
      _currentIndex = _list.length -1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);
  
  List<SliderObject> _getSliderData() =>
      [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboarding_logo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboarding_logo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboarding_logo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboarding_logo4),
      ];
  
  _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

}

// inputs mean the orders that our view model will receive from our view
abstract mixin class OnBoardingViewModelInputs {
  void goNext(); // when user click next
  void goPrev();
  void onPageChanged(int index);

  Sink get inputSliderViewObject; // this is the way to add data to the stream.. stream input
}

// outputs mean data or results that will be sent from our view model to our view
abstract mixin class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;

 



}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

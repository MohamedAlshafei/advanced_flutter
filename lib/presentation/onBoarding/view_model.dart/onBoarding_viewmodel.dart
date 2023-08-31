import 'dart:async';
import 'package:advanced_flutter/domain/models.dart';
import '../../base/baseViewModel.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel with OnboardingViewModelInputs,OnboardingViewModelOutputs{
  
  final StreamController _streamController= StreamController<SliderViewObject>();
    late final List<SliderObject> _list;
    int _currentIndex =0;

  
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list=_getSliderData();
    _postDataToView();
  }
  
  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if(nextIndex == _list.length){
      nextIndex = 0;
    }
    return nextIndex;
  }
  
  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if(previousIndex == -1){
      previousIndex = _list.length -1;
    }
    return previousIndex;
  }
  
  @override
  void onPageChanged(int index) {
    _currentIndex=index;
    _postDataToView();
  }
  
  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;
  
  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
    _streamController.stream.map((sliderViewObject)=> sliderViewObject);

  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex],_currentIndex,_list.length));
  }

  List<SliderObject> _getSliderData()=>[
    SliderObject(
      AppStrings.onBoardingTitle1, 
      AppStrings.onBoardingSubTitle1, 
      ImageAssets.onBoardingLogo1),
    SliderObject(
      AppStrings.onBoardingTitle2, 
      AppStrings.onBoardingSubTitle2, 
      ImageAssets.onBoardingLogo2),
    SliderObject(
      AppStrings.onBoardingTitle3, 
      AppStrings.onBoardingSubTitle3, 
      ImageAssets.onBoardingLogo3),
    SliderObject(
      AppStrings.onBoardingTitle4, 
      AppStrings.onBoardingSubTitle4, 
      ImageAssets.onBoardingLogo4),
  ];

}

abstract class OnboardingViewModelInputs{
  int goNext();
  int goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}
abstract class OnboardingViewModelOutputs{
  Stream<SliderViewObject> get outputSliderViewObject;
}
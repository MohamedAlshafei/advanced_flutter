
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/models.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constant_manager.dart';
import '../../resources/strings_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../view_model.dart/onBoarding_viewmodel.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  PageController _pageController= PageController();
  final OnboardingViewModel _viewModel =OnboardingViewModel();

  _bind(){
    _viewModel.start();
  }
  
  @override
  void initState() {
    _bind();
    super.initState();
  }
  

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context,snapshot){
        return _getContentWidget(snapshot.data);
      }
      );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject){
    if(sliderViewObject ==null){
      return Container();
    }else{
      return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation:AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: sliderViewObject.numOfSlides,
        onPageChanged: (index){
          _viewModel.onPageChanged(index);
        },
        itemBuilder: (context,index){
          return OnBoardingPage(sliderViewObject.sliderObject);
        },
        
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                }, 
                child: Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,
                  style:Theme.of(context).textTheme.titleMedium
                  ),
                ),
            ),
            _getBottomSheetWidget(sliderViewObject),
          ],
        ),
      ),
    );
    }
    
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject){
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: (){
                _pageController.animateToPage(
                  _viewModel.goPrevious(), 
                  duration: const Duration(milliseconds: AppConstants.sliderAnimationTime), 
                  curve: Curves.bounceInOut
                  );
              },
            ),
            ),
          
          Row(
            children: [
              for(int i =0; i < sliderViewObject.numOfSlides; i++)
                Padding(padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i,sliderViewObject.currentIndex),)
            ],
          ),
    
    
    
    
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
              onTap: (){
                _pageController.animateToPage(
                  _viewModel.goNext(), 
                  duration: const Duration(milliseconds: AppConstants.sliderAnimationTime), 
                  curve: Curves.bounceInOut
                  );
              },
            ),
            ),
        ],
      ),
    );
  }


  Widget _getProperCircle(int index,int currentIndex){
    if(index==currentIndex){
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    }else{
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget{
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40,),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSize.s60,),
        SvgPicture.asset(
          _sliderObject.image!
        ),
      ],
    );
  }

}


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/presentation/base/common/state_renderer/state_renderer.impl.dart';
import 'package:flutter_restapi/presentation/main/home/home_viewmodel.dart';
import 'package:flutter_restapi/presentation/resources/strings_manager.dart';
import 'package:flutter_restapi/presentation/resources/values_manager.dart';
import '../../../app/dependecy_injection.dart';
import '../../../domain/model/model.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.start();
                }) ??
                Container();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewData>(
      stream: _viewModel.outputHomeObject,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getBannersCarousel(snapshot.data?.banner),
            _getSection(AppStrings.services),
            _getServices(snapshot.data?.services),
            _getSection(AppStrings.stores),
            _getStores(snapshot.data?.store)
          ],
        );
      }
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme
            .of(context)
            .textTheme
            .titleLarge,
      ),
    );
  }

  Widget _getBannersCarousel(List<Banners>? banners) {
    //return StreamBuilder<List<Banners>>(
     // stream: _viewModel.outputHomeObject.map((event) => event.banner),
      //builder: (context, snapshot) {
        return _getBanner(banners);
      //},

  }

  Widget _getBanner(List<Banners>? banners) {
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((banner) =>
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      side: BorderSide(
                          color: ColorManager.white, width: AppSize.s1_5)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: Image.network(banner.image, fit: BoxFit.cover),
                  ),
                ),
              ))
              .toList(),
          options: CarouselOptions(
              height: AppSize.s180,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

  Widget _getServices(List<Services>? services) {
   // return StreamBuilder<List<Services>>(
     // stream: _viewModel.outputHomeObject.map((event) => event.services),
     // builder: (context, snapshot) {
        return _getService(services);
     // },
    //);
  }

  _getService(List<Services>? service) {
    if (service != null) {
      return Padding(
        padding: EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: AppSize.s140,
          margin: EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: service
                .map((service) =>
                Card(
                  elevation: AppSize.s4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      side: BorderSide(
                          color: ColorManager.white, width: AppSize.s1_5)),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(
                          service.image,
                          fit: BoxFit.cover,
                          width: AppSize.s100,
                          height: AppSize.s100,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: AppPadding.p8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(service.title,
                                textAlign: TextAlign.center),
                          ))
                    ],
                  ),
                ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStores(List<Store>? store) {
    //return StreamBuilder<List<Store>>(
      //stream: _viewModel.outputHomeObject.map((event) => event.store),
      //builder: (context, snapshot) {
        return _getStoreWidget(store);
      //},
  //  );
  }

  _getStoreWidget(List<Store>? store) {
    if (store != null) {
      return Padding(
          padding: EdgeInsets.only(
              left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12, bottom: AppPadding.p28),
          child: Flex(
            direction: Axis.vertical,
            children: [
              GridView.count(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: AppSize.s8,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(store.length, (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.storeDetailsRoute);
                      },
                      child: Card(
                        elevation: AppSize.s4,
                        child: Image.network(store[index].image,
                            fit: BoxFit.cover),
                      ),
                    );
                  })
              )
            ],
          ));
    } else {
      return Container();
    }
  }
}

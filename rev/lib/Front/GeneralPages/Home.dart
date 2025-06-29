import 'dart:convert';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropFeatureItemIntoHomeScreen/DropFeatureItemIntoHomeScreenEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropFeatureItemIntoHomeScreen/DropFeatureItemIntoHomeScreenIntegration.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropFeatureItemIntoHomeScreen/DropFeatureItemIntoHomeScreenState.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropItemsIntoHomeScreen/DropItemsIntoHomeScreenEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropItemsIntoHomeScreen/DropItemsIntoHomeScreenIntegration.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropItemsIntoHomeScreen/DropItemsIntoHomeScreenState.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropNewItemsIntoHomeScreen/DropNewItemsIntoHomeScreenEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropNewItemsIntoHomeScreen/DropNewItemsIntoHomeScreenIntegration.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropNewItemsIntoHomeScreen/DropNewItemsIntoHomeScreenState.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropShoeItemsIntoHomeScreen/DropShoeItemsIntoHomeScreenEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropShoeItemsIntoHomeScreen/DropShoeItemsIntoHomeScreenIntegration.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropShoeItemsIntoHomeScreen/DropShoeItemsIntoHomeScreenState.dart';
import 'package:css/Backend/Controllers/ForProductControllers/ShowAllItems.dart';
import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/SignOutController.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Front/Functions/AppMethods.dart';
import 'package:css/Front/GeneralPages/SearchPage.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:card_loading/card_loading.dart';
import 'package:css/Tools/Colors.dart';
import 'package:css/Tools/Constructures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:css/Backend/RevenueItems/RevData.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

final controller = Get.put(ProfileController());
final control = Get.put(SignOutCopntroller());
final cartController = Get.put(AppMethods());
final showItemsMostOfTrinding = Get.put(ShowAllItemsMostOfTrinding());
final showItemsShoesProducts = Get.put(ShowAllItemsShoesProducts());
final showFeatureItems = Get.put(ShowFeatureItems());
final showNewItems = Get.put(ShowNewItems());

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedFeature = 0;
  int selectItems = 1;
  String? selectedSize;
  Color? selectedColor;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final siz = MediaQuery.of(context).size;
    SizedBox sizedBoxBewtweenTriggers = const SizedBox(width: 40);
    return Scaffold(
      appBar: navigateToSearchPage(),
      backgroundColor: white,
      body: SafeArea(
          child: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 20,
        animSpeedFactor: 20,
        height: 35,
        showChildOpacityTransition: false,
        backgroundColor: white,
        color: greenColor,
        onRefresh: () async {
          await showItemsMostOfTrinding.fetchAllItem();
          await showItemsShoesProducts.fetchAllItems();
          await showFeatureItems.fetchAllItems();
          await showNewItems.fetchAllItems();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  MostTrindingText(siz: siz),
                  mostTrindingItems(siz),
                  sizedBoxBewtweenTriggers,
                  FeaturesText(siz: siz),
                  featuresItems(siz),
                  sizedBoxBewtweenTriggers,
                  NewItems(siz: siz),
                  newItemsInRevenue(siz),
                  Shoes(siz: siz),
                  shoeSectionRevenue(siz),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  AppBar navigateToSearchPage() {
    return AppBar(
      forceMaterialTransparency: false,
      excludeHeaderSemantics: false,
      surfaceTintColor: white,
      shadowColor: white,
      backgroundColor: white,
      toolbarHeight: 45,
      elevation: 0,
      title: CupertinoSearchTextField(
        onTap: () => Get.to(() => const SearchPage()),
      ),
    );
  }

  MultiBlocProvider shoeSectionRevenue(Size siz) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => DropShoeItemsIntoHomeScreenIntegration(
                ShowAllItemsShoesProducts())
              ..add(
                DropShoeItemsIntoHomeScreenEventLoading(),
              )),
      ],
      child: BlocBuilder<DropShoeItemsIntoHomeScreenIntegration,
          DropShoeItemsIntoHomeScreenState>(
        builder: (context, shoesSectionInRevenueState) {
          final Alerts alerts = Alerts();
          if (shoesSectionInRevenueState
              is DropShoeItemsIntoHomeScreenStateLoading) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemCount: 2,
              itemBuilder: (context, index) => CardLoading(
                height: 200,
                margin: EdgeInsets.symmetric(
                    horizontal: siz.height * 0.005,
                    vertical: siz.height * 0.01),
                width: siz.width / 1.81,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
            );
          } else if (shoesSectionInRevenueState
              is DropShoeItemsIntoHomeScreenStateError) {
            print(shoesSectionInRevenueState.err);
            alerts.ifErrors(shoesSectionInRevenueState.err);
          } else if (shoesSectionInRevenueState
              is DropShoeItemsIntoHomeScreenStateLoaded) {
            List<RevenueIemsModel> revItems = shoesSectionInRevenueState.items;
            return SizedBox(
              height: siz.height / 2.3,
              child: ListView.builder(
                itemCount: revItems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) {
                  RevenueIemsModel model = revItems[idx];
                  bool isSizedSelected = false;

                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          SizedBox sizedBoxBewtweenTriggers =
                              const SizedBox(width: 5);
                          SizedBox sizedBoxBewtweenInfos =
                              const SizedBox(height: 15);
                          selectedIndex = idx;
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: white,
                              enableDrag: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, modalState) {
                                  return SizedBox(
                                    height: siz.height / 1.6,
                                    child: SingleChildScrollView(
                                      child: Center(
                                        child: Column(
                                          children: [
                                            imageItemInshowModalBottomSheet(
                                                siz, model),
                                            ///////////////////////////////////////
                                            ////////////[Name of item]////////////
                                            ///////////////////////////////////////
                                            nameItemInshowModalBottomSheet(
                                                siz, model),
                                            modelItemInshowModalBottomSheet(
                                                siz, model),

                                            rateItemInshowModalBottomSheet(
                                                siz, model),
                                            sizedBoxBewtweenInfos,
                                            itemDescriptionInModelBottomSheet(
                                                model),
                                            /////////////////////////////////////////
                                            ////////////////////////////////////////
                                            ///////////////////////////////////////
                                            sizedBoxBewtweenInfos,
                                            colorsAvailableInshowModalBottomSheet(
                                                model, sizedBoxBewtweenTriggers,
                                                (color) {
                                              modalState(
                                                () {
                                                  selectedColor = color;
                                                },
                                              );
                                            }),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            ///////////////////////////////////////
                                            ////////////[Sizes of item]////////////
                                            ///////////////////////////////////////
                                            sizeItemInshowModalBottomSheet(
                                                isSizedSelected, siz, model,
                                                (size) {
                                              modalState(
                                                () {
                                                  selectedSize = size;
                                                },
                                              );
                                            }),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            /////////////////////////////////////////////////////
                                            ////////////[Count of item & Add to cart]////////////
                                            ////////////////////////////////////////////////////
                                            countOfItemAndAddToCartOfShoesSectionInRevenueInshowModalBottomSheet(
                                                siz,
                                                shoesSectionInRevenueState,
                                                idx)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              });
                        });
                      },
                      child: ContainerOfFetchingShoeSectionInRevenueItems(
                        imgAdress: model.imgAdress,
                        name: model.name,
                        model: model.model,
                        itemColor: model.itemColor,
                        price: model.price,
                        liked: model.liked,
                        idx: idx,
                      ));
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Padding itemDescriptionInModelBottomSheet(RevenueIemsModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Item Description",
            style: GoogleFonts.aleo(
                color: black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            '${model.description}',
            style: GoogleFonts.aleo(
                color: black,
                // fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  MultiBlocProvider newItemsInRevenue(Size siz) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                DropNewItemsIntoHomeScreenIntegration(ShowNewItems())
                  ..add(
                    DropNewItemsIntoHomeScreenEventLoading(),
                  )),
      ],
      child: BlocBuilder<DropNewItemsIntoHomeScreenIntegration,
          DropNewItemsIntoHomeScreenState>(
        builder: (context, newItemsInRevenueState) {
          final Alerts alerts = Alerts();
          if (newItemsInRevenueState
              is DropNewItemsIntoHomeScreenStateLoading) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemCount: 2,
              itemBuilder: (context, index) => CardLoading(
                height: 200,
                margin: EdgeInsets.symmetric(
                    horizontal: siz.height * 0.005,
                    vertical: siz.height * 0.01),
                width: siz.width / 1.81,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
            );
          } else if (newItemsInRevenueState
              is DropNewItemsIntoHomeScreenStateError) {
            alerts.ifErrors(newItemsInRevenueState.err);
            print(newItemsInRevenueState.err);
          } else if (newItemsInRevenueState
              is DropNewItemsIntoHomeScreenStateLoaded) {
            List<RevenueIemsModel> revItems = newItemsInRevenueState.items;
            return SizedBox(
              height: siz.height / 2.3,
              child: ListView.builder(
                itemCount: revItems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) {
                  RevenueIemsModel model = revItems[idx];
                  final itemsBag = model;
                  bool isSizedSelected = false;

                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          print('Item Types: ${model.type}');
                          SizedBox sizedBoxBewtweenTriggers =
                              const SizedBox(width: 5);
                          SizedBox sizedBoxBewtweenInfos =
                              const SizedBox(height: 15);
                          selectedIndex = idx;
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: white,
                              enableDrag: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, modalState) {
                                  return SizedBox(
                                    height: siz.height / 1.6,
                                    child: SingleChildScrollView(
                                      child: Center(
                                        child: Column(
                                          children: [
                                            imageItemInshowModalBottomSheet(
                                                siz, itemsBag),
                                            ///////////////////////////////////////
                                            ////////////[Name of item]////////////
                                            ///////////////////////////////////////
                                            nameItemInshowModalBottomSheet(
                                                siz, itemsBag),
                                            modelItemInshowModalBottomSheet(
                                                siz, itemsBag),

                                            rateItemInshowModalBottomSheet(
                                                siz, itemsBag),
                                            sizedBoxBewtweenInfos,
                                            /////////////////////////////////////////
                                            ////////////////////////////////////////
                                            ///////////////////////////////////////
                                            itemDescriptionInModelBottomSheet(
                                                model),
                                            colorsAvailableInshowModalBottomSheet(
                                                itemsBag,
                                                sizedBoxBewtweenTriggers,
                                                (color) {
                                              modalState(
                                                () {
                                                  selectedColor = color;
                                                },
                                              );
                                            }),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            ///////////////////////////////////////
                                            ////////////[Sizes of item]////////////
                                            ///////////////////////////////////////
                                            if ((model.type ?? '')
                                                        .trim()
                                                        .toLowerCase() ==
                                                    'bags' ||
                                                (model.type ?? '')
                                                        .trim()
                                                        .toLowerCase() ==
                                                    'headsets')
                                              Container()
                                            else
                                              sizeItemInshowModalBottomSheet(
                                                  isSizedSelected,
                                                  siz,
                                                  itemsBag, (size) {
                                                modalState(
                                                  () {
                                                    selectedSize = size;
                                                  },
                                                );
                                              }),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            /////////////////////////////////////////////////////
                                            ////////////[Count of item & Add to cart]////////////
                                            ////////////////////////////////////////////////////
                                            countOfItemAndAddToCartOfNewItemsInRevenueInshowModalBottomSheet(
                                                siz,
                                                newItemsInRevenueState,
                                                idx)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              });
                        });
                      },
                      child: ContainerOfFetchingNewItemsInRevenueItems(
                        imgAdress: model.imgAdress,
                        name: model.name,
                        model: model.model,
                        itemColor: model.itemColor,
                        price: model.price,
                        liked: model.liked,
                        idx: idx,
                      ));
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  MultiBlocProvider featuresItems(Size siz) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                DropFeatureItemIntoHomeScreenIntegration(ShowFeatureItems())
                  ..add(
                    DropFeatureItemIntoHomeScreenEventLoading(),
                  )),
      ],
      child: BlocBuilder<DropFeatureItemIntoHomeScreenIntegration,
              DropFeatureItemIntoHomeScreenState>(
          builder: (context, featureItemsState) {
        final Alerts alerts = Alerts();
        if (featureItemsState is DropFeatureItemIntoHomeScreenStateLoading) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemCount: 2,
            itemBuilder: (context, index) => CardLoading(
              height: 200,
              margin: EdgeInsets.symmetric(
                  horizontal: siz.height * 0.005, vertical: siz.height * 0.01),
              width: siz.width / 1.81,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
          );
        } else if (featureItemsState
            is DropFeatureItemIntoHomeScreenStateError) {
          alerts.ifErrors(featureItemsState.err);
          print(featureItemsState.err);
        } else if (featureItemsState
            is DropFeatureItemIntoHomeScreenStateLoaded) {
          List<RevenueIemsModel> revItems = featureItemsState.items;
          return SizedBox(
            height: siz.height / 2.3,
            child: ListView.builder(
              itemCount: revItems.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, idx) {
                bool isSizedSelected = false;
                final item = revItems[idx];
                final RevenueIemsModel itemsbag = item;

                final model = revItems[idx];

                return GestureDetector(
                    onTap: () {
                      setState(() {
                        print('Item type is: "${model.type}"');
                        SizedBox sizedBoxBewtweenTriggers =
                            const SizedBox(width: 5);
                        SizedBox sizedBoxBewtweenInfos =
                            const SizedBox(height: 15);
                        selectedIndex = idx;
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: white,
                            enableDrag: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, modalSetState) {
                                return SizedBox(
                                  height: siz.height / 1.6,
                                  child: SingleChildScrollView(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          imageItemInshowModalBottomSheet(
                                              siz, model),
                                          ///////////////////////////////////////
                                          ////////////[Name of item]////////////
                                          ///////////////////////////////////////
                                          nameItemInshowModalBottomSheet(
                                              siz, model),

                                          modelItemInshowModalBottomSheet(
                                              siz, model),

                                          rateItemInshowModalBottomSheet(
                                              siz, model),
                                          sizedBoxBewtweenInfos,
                                          /////////////////////////////////////////
                                          ////////////////////////////////////////
                                          ///////////////////////////////////////
                                          itemDescriptionInModelBottomSheet(
                                              model),
                                          colorsAvailableInshowModalBottomSheet(
                                              model, sizedBoxBewtweenTriggers,
                                              (color) {
                                            modalSetState(
                                              () {
                                                selectedColor = color;
                                              },
                                            );
                                          }),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          ///////////////////////////////////////
                                          ////////////[Sizes of item]////////////
                                          ///////////////////////////////////////
                                          (model.type ?? '')
                                                      .trim()
                                                      .toLowerCase() ==
                                                  'bags'
                                              ? Container()
                                              : sizeItemInshowModalBottomSheet(
                                                  isSizedSelected,
                                                  siz,
                                                  itemsbag, (size) {
                                                  modalSetState(
                                                    () {
                                                      selectedSize = size;
                                                    },
                                                  );
                                                }),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          /////////////////////////////////////////////////////
                                          ////////////[Count of item & Add to cart]////////////
                                          ////////////////////////////////////////////////////
                                          countOfItemAndAddToCartOfFeaturesItemsInshowModalBottomSheet(
                                              siz, featureItemsState, idx)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            });
                      });
                    },
                    child: ContainerOfFetchingFeaturesItems(
                      imgAdress: model.imgAdress,
                      name: model.name,
                      model: model.model,
                      itemColor: model.itemColor,
                      price: model.price,
                      liked: model.liked,
                      idx: idx,
                    ));
              },
            ),
          );
        }
        return Container();
      }),
    );
  }

  MultiBlocProvider mostTrindingItems(Size siz) {
    final Alerts alerts = Alerts();
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => DropItemsIntoHomeScreenIntegration(
                  ShowAllItemsMostOfTrinding())
                ..add(
                  DropItemsIntoHomeScreenEventLoading(),
                )),
        ],
        child: BlocBuilder<DropItemsIntoHomeScreenIntegration,
            DropItemsIntoHomeScreenState>(
          builder: (context, addToCartstate) {
            if (addToCartstate is DropItemsIntoHomeScreenEventLoading) {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemCount: 2,
                itemBuilder: (context, index) => CardLoading(
                  height: 200,
                  margin: EdgeInsets.symmetric(
                      horizontal: siz.height * 0.005,
                      vertical: siz.height * 0.01),
                  width: siz.width / 1.81,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
              );
            }
            if (addToCartstate is DropItemsIntoHomeScreenStateError) {
              alerts.ifErrors(addToCartstate.toString());
              print('''
==========================addToCartstate${addToCartstate.err}
''');
              // alerts.ifErrors(addToCartstate.err);
            } else if (addToCartstate is DropItemsIntoHomeScreenStateLoaded) {
              List<RevenueIemsModel> revItems = addToCartstate.items;
              return SizedBox(
                height: siz.height / 2.3,
                child: ListView.builder(
                  itemCount: revItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, idx) {
                    final item = revItems[idx];
                    final RevenueIemsModel itemsbag = item;

                    final model = revItems[idx];
                    bool isSizedSelected = false;
                    // Show item in  bottom sheet
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            SizedBox sizedBoxBewtweenTriggers =
                                const SizedBox(width: 5);
                            selectedIndex = idx;
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: white,
                                enableDrag: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                context: context,
                                builder: (context) {
                                  // String? selectedSize;
                                  return StatefulBuilder(
                                      builder: (context, modalSetState) {
                                    return SizedBox(
                                      height: siz.height / 1.6,
                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              imageItemInshowModalBottomSheet(
                                                  siz, model),
                                              ///////////////////////////////////////
                                              ////////////[Name of item]////////////
                                              ///////////////////////////////////////
                                              nameItemInshowModalBottomSheet(
                                                  siz, model),
                                              modelItemInshowModalBottomSheet(
                                                  siz, model),
                                              const Divider(),
                                              //Description
                                              itemDescriptionInModelBottomSheet(
                                                  model),
                                              /////////////////////////////////////////
                                              ////////////////////////////////////////
                                              ///////////////////////////////////////
                                              colorsAvailableInshowModalBottomSheet(
                                                  model,
                                                  sizedBoxBewtweenTriggers,
                                                  (color) {
                                                modalSetState(
                                                  () {
                                                    selectedColor = color;
                                                  },
                                                );
                                              }),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              ///////////////////////////////////////
                                              ////////////[Sizes of item]////////////
                                              ///////////////////////////////////////
                                              sizeItemInshowModalBottomSheet(
                                                  isSizedSelected,
                                                  siz,
                                                  itemsbag, (size) {
                                                modalSetState(() {
                                                  selectedSize = size;
                                                });
                                              }),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              /////////////////////////////////////////////////////
                                              ////////////[Count of item & Add to cart]////////////
                                              ////////////////////////////////////////////////////
                                              countOfItemAndAddToCartOfMostTrindingItemsInshowModalBottomSheet(
                                                  siz, addToCartstate, idx)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                });
                          });
                        },
                        ///////////////////////////////////////
                        ////////////[items]////////////////////
                        ///////////////////////////////////////
                        child: ContainerOfFetchingMostTrindingItems(
                          imgAdress: model.imgAdress,
                          name: model.name,
                          model: model.model,
                          itemColor: model.itemColor,
                          price: model.price,
                          liked: model.liked,
                          idx: idx,
                        ));
                  },
                ),
              );
            }
            return Container();
          },
        ));
  }

  SizedBox sizeItemInshowModalBottomSheet(
    bool isSizedSelected,
    Size siz,
    RevenueIemsModel itemsbag,
    Function(String) onSizeSelected,
  ) {
    return SizedBox(
        height: siz.height * 0.04,
        width: siz.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: itemsbag.sizes.map(
                (String size) {
                  final bool isSelected = size == selectedSize;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: isSelected ? 1.7 : 1, color: black)),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                isSelected ? greenColor : white)),
                        onPressed: () => setState(() => onSizeSelected(size)),
                        child: Text(
                          size,
                          style: TextStyle(color: isSelected ? white : black),
                        )),
                  );
                },
              ).toList()),
        ));
  }

  Padding countOfItemAndAddToCartOfMostTrindingItemsInshowModalBottomSheet(
      Size siz, DropItemsIntoHomeScreenStateLoaded addToCartstate, int idx) {
    void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
      await cartController.saveItemsToTheCart(addToCartstate.items[idx]);
    }

    RevenueIemsModel model = addToCartstate.items[idx];
    bool isInCart = itemsInBag.contains(model);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: isInCart
              ? Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  width: siz.width / 4,
                  height: siz.height / 23,
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Added !',
                          style: GoogleFonts.aleo(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '✔️',
                          style: GoogleFonts.aleo(
                              color: white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        shadowColor:
                            WidgetStatePropertyAll(Colors.transparent)),
                    onPressed: () =>
                        toggleAddToCartFrommostTrendingInShowModalBottomSheet(),
                    label: Text(
                      'Add to your cart',
                      style: GoogleFonts.aleo(
                          color: white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    icon: const Icon(
                      Iconsax.shopping_cart,
                      color: white,
                    ),
                  ),
                ),
        ));
  }

  Padding countOfItemAndAddToCartOfShoesSectionInRevenueInshowModalBottomSheet(
      Size siz,
      DropShoeItemsIntoHomeScreenStateLoaded shoesSectionInRevenueState,
      int idx) {
    void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
      await cartController
          .saveItemsToTheCart(shoesSectionInRevenueState.items[idx]);
    }

    RevenueIemsModel model = shoesSectionInRevenueState.items[idx];
    bool isInCart = itemsInBag.contains(model);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: isInCart
              ? Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  width: siz.width / 4,
                  height: siz.height / 23,
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Added !',
                          style: GoogleFonts.aleo(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '✔️',
                          style: GoogleFonts.aleo(
                              color: white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        shadowColor:
                            WidgetStatePropertyAll(Colors.transparent)),
                    onPressed: () =>
                        toggleAddToCartFrommostTrendingInShowModalBottomSheet(),
                    label: Text(
                      'Add to your cart',
                      style: GoogleFonts.aleo(
                          color: white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    icon: const Icon(
                      Iconsax.shopping_cart,
                      color: white,
                    ),
                  ),
                ),
        ));
  }

  Padding countOfItemAndAddToCartOfNewItemsInRevenueInshowModalBottomSheet(
      Size siz,
      DropNewItemsIntoHomeScreenStateLoaded newItemsInRevenueState,
      int idx) {
    void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
      await cartController
          .saveItemsToTheCart(newItemsInRevenueState.items[idx]);
    }

    RevenueIemsModel model = newItemsInRevenueState.items[idx];
    bool isInCart = itemsInBag.contains(model);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: isInCart
              ? Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  width: siz.width / 4,
                  height: siz.height / 23,
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Added !',
                          style: GoogleFonts.aleo(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '✔️',
                          style: GoogleFonts.aleo(
                              color: white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        shadowColor:
                            WidgetStatePropertyAll(Colors.transparent)),
                    onPressed: () =>
                        toggleAddToCartFrommostTrendingInShowModalBottomSheet(),
                    label: Text(
                      'Add to your cart',
                      style: GoogleFonts.aleo(
                          color: white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    icon: const Icon(
                      Iconsax.shopping_cart,
                      color: white,
                    ),
                  ),
                ),
        ));
  }

  Padding countOfItemAndAddToCartOfFeaturesItemsInshowModalBottomSheet(Size siz,
      DropFeatureItemIntoHomeScreenStateLoaded featureItemsState, int idx) {
    void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
      await cartController.saveItemsToTheCart(featureItemsState.items[idx]);
    }

    RevenueIemsModel model = featureItemsState.items[idx];
    bool isInCart = itemsInBag.contains(model);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: isInCart
              ? Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  width: siz.width / 4,
                  height: siz.height / 23,
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Added !',
                          style: GoogleFonts.aleo(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '✔️',
                          style: GoogleFonts.aleo(
                              color: white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        shadowColor:
                            WidgetStatePropertyAll(Colors.transparent)),
                    onPressed: () =>
                        toggleAddToCartFrommostTrendingInShowModalBottomSheet(),
                    label: Text(
                      'Add to your cart',
                      style: GoogleFonts.aleo(
                          color: white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    icon: const Icon(
                      Iconsax.shopping_cart,
                      color: white,
                    ),
                  ),
                ),
        ));
  }

  SizedBox colorsAvailableInshowModalBottomSheet(RevenueIemsModel model,
      SizedBox sizedBoxBewtweenTriggers, Function(Color) onColorSelected) {
    final size = MediaQuery.of(context).size;
    // print("Colors for item: ${model.colorsAvailable}");
    return SizedBox(
        height: size.height * 0.04,
        width: size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: model.colorsAvailable.map(
                (color) {
                  final bool isSelected = color == selectedColor;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: isSelected ? 1.7 : 1, color: black)),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(color)),
                        onPressed: () => setState(() {
                              onColorSelected(color);
                            }),
                        child: const Text(
                          '',
                        )),
                  );
                },
              ).toList()),
        ));
  }

  SizedBox rateItemInshowModalBottomSheet(Size siz, RevenueIemsModel model) {
    return SizedBox(
      width: siz.width / 1.2,
      height: 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: model.rate.length,
        itemBuilder: (context, rateIndex) {
          return Container(child: model.rate[rateIndex]);
        },
      ),
    );
  }

  Container modelItemInshowModalBottomSheet(Size siz, RevenueIemsModel model) {
    return Container(
      width: siz.width,
      margin: const EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              model.model,
              style: GoogleFonts.aleo(
                  color: black, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          ///////////////////////////////////////
          ////////////[Price of item]////////////
          ///////////////////////////////////////
          SizedBox(
            child: Text(
              '${model.price} JOD',
              style: GoogleFonts.aleo(
                  color: black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.2),
            ),
          ),
        ],
      ),
    );
  }

  Container nameItemInshowModalBottomSheet(Size siz, RevenueIemsModel model) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      width: siz.width / 1,
      child: Text(
        model.name,
        style: GoogleFonts.aleo(
            color: black, fontSize: 28, fontWeight: FontWeight.w600),
      ),
    );
  }

  SizedBox imageItemInshowModalBottomSheet(Size siz, RevenueIemsModel model) {
    return SizedBox(
        ///////////////////////////////////////
        ////////////[Image of item]////////////
        ///////////////////////////////////////
        height: siz.height / 3,
        width: siz.width / 1.2 + 0.72,
        child:
            Image.memory(fit: BoxFit.contain, base64Decode(model.imgAdress)));
  }
}

class Shoes extends StatelessWidget {
  const Shoes({
    super.key,
    required this.siz,
  });

  final Size siz;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: siz.width / 1.1,
      child: Text(
        'Shoes',
        style: GoogleFonts.aleo(
            color: black, fontSize: 25, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class NewItems extends StatelessWidget {
  const NewItems({
    super.key,
    required this.siz,
  });

  final Size siz;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: siz.width / 1.1,
      child: Text(
        'New',
        style: GoogleFonts.aleo(
            color: grey, fontSize: 21, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class FeaturesText extends StatelessWidget {
  const FeaturesText({
    super.key,
    required this.siz,
  });

  final Size siz;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: siz.width / 1.1,
      child: Text(
        'Features',
        style: GoogleFonts.aleo(
            color: grey, fontSize: 21, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class MostTrindingText extends StatelessWidget {
  const MostTrindingText({
    super.key,
    required this.siz,
  });

  final Size siz;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: siz.width / 1.1,
      child: Text(
        'Most trinding',
        style: GoogleFonts.aleo(
            color: grey, fontSize: 21, fontWeight: FontWeight.w400),
      ),
    );
  }
}

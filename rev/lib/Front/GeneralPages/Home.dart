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
import 'package:css/Front/GeneralPages/OffersPage.dart';
import 'package:css/Front/GeneralPages/SearchPage.dart';
import 'package:css/Front/GeneralPages/Wishlist.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:card_loading/card_loading.dart';
import 'package:css/Tools/Colors.dart';
import 'package:css/Tools/Constructures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:css/Backend/RevenueItems/RevData.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

final controller = getx.Get.put(ProfileController());
final control = getx.Get.put(SignOutCopntroller());
final cartController = getx.Get.put(AppMethods());
final showItemsMostOfTrinding = getx.Get.put(ShowAllItemsMostOfTrinding());
final showItemsShoesProducts = getx.Get.put(ShowAllItemsShoesProducts());
final showFeatureItems = getx.Get.put(ShowFeatureItems());
final showNewItems = getx.Get.put(ShowNewItems());

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedFeature = 0;
  int selectItems = 1;
  String? selectedSize;
  // Color? selectedColor;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final siz = MediaQuery.of(context).size;
    SizedBox sizedBoxBewtweenTriggers = const SizedBox(width: 40);
    return Scaffold(
      appBar: navigateToSearchPage(siz),
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

  AppBar navigateToSearchPage(Size siz) {
    return AppBar(
      forceMaterialTransparency: false,
      excludeHeaderSemantics: false,
      surfaceTintColor: white,
      shadowColor: white,
      backgroundColor: white,
      toolbarHeight: 45,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () => getx.Get.to(() => const OffersPage(),
                transition: getx.Transition.rightToLeft),
            icon: const Icon(
              Iconsax.discount_circle,
            )),
        IconButton(
            onPressed: () => getx.Get.to(() => const WishList(),
                transition: getx.Transition.rightToLeft),
            icon: const Icon(
              Iconsax.heart,
            )),
      ],
      title: CupertinoSearchTextField(
        onTap: () => getx.Get.to(() => const SearchPage(),
            transition: getx.Transition.rightToLeft),
      ),
    );
  }

  Widget shoeSectionRevenue(Size siz) {
    Alerts alerts = Alerts();
    return buildItemsSection(
      context: context,
      size: siz,
      blocCreator: () =>
          DropShoeItemsIntoHomeScreenIntegration(ShowAllItemsShoesProducts()),
      loadingEvent: DropShoeItemsIntoHomeScreenEventLoading(),
      builder: (context, state, size) {
        if (state is DropShoeItemsIntoHomeScreenStateLoading) {
          return loadingStateBlocMethod(siz);
        } else if (state is DropShoeItemsIntoHomeScreenStateError) {
          alerts.ifErrors(state.err);
        } else if (state is DropShoeItemsIntoHomeScreenStateLoaded) {
          List<RevenueIemsModel> revItems = state.items;
          return listItemsAtBLOC(
              siz: siz,
              revItems: revItems,
              isSelectedItem: false,
              context: context,
              buildBottomSheetContent: (index, model, modalSetState) {
                bool isSizedSelected = false;
                return Center(
                  child: Column(
                    children: [
                      imageItemInshowModalBottomSheet(siz, model),
                      ///////////////////////////////////////
                      ////////////[Name of item]////////////
                      ///////////////////////////////////////
                      nameItemInshowModalBottomSheet(siz, model),
                      modelItemInshowModalBottomSheet(siz, model),
                      const Divider(),
                      itemDescriptionInModelBottomSheet(model),
                      /////////////////////////////////////////
                      ////////////////////////////////////////
                      ///////////////////////////////////////
                      sizedBoxBewtweenInfos,
                      colorsAvailableInshowModalBottomSheet(
                          model, sizedBoxBewtweenTriggers, model.selectedColor,
                          (select) {
                        modalSetState(() => context
                            .read<DropShoeItemsIntoHomeScreenIntegration>()
                            .add(SelectShoeItemsColorEvent(model.id, select)));
                      }),
                      const SizedBox(
                        height: 6,
                      ),
                      ///////////////////////////////////////
                      ////////////[Sizes of item]////////////
                      ///////////////////////////////////////
                      sizeItemInshowModalBottomSheet(
                          isSizedSelected, siz, model, (size) {
                        modalSetState(
                          () {
                            model.selectedSize = size;
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
                          siz, state, index)
                    ],
                  ),
                );
              },
              itemBuilder: (model, idx) =>
                  ContainerOfFetchingShoeSectionInRevenueItems(
                    imgAdress: model.imgAdress,
                    name: model.name,
                    model: model.model,
                    itemColor: model.itemColor,
                    price: model.price,
                    liked: model.liked,
                    idx: idx,
                  ));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget newItemsInRevenue(Size siz) {
    Alerts alerts = Alerts();
    return buildItemsSection(
      context: context,
      size: siz,
      blocCreator: () => DropNewItemsIntoHomeScreenIntegration(ShowNewItems()),
      loadingEvent: DropNewItemsIntoHomeScreenEventLoading(),
      builder: (context, state, size) {
        if (state is DropNewItemsIntoHomeScreenStateLoading) {
          return loadingStateBlocMethod(siz);
        } else if (state is DropNewItemsIntoHomeScreenStateError) {
          alerts.ifErrors(state.err);
        } else if (state is DropNewItemsIntoHomeScreenStateLoaded) {
          List<RevenueIemsModel> revItems = state.items;
          return listItemsAtBLOC(
              siz: siz,
              revItems: revItems,
              isSelectedItem: false,
              context: context,
              buildBottomSheetContent: (index, model, modalSetState) {
                bool isSizedSelected = false;
                return Center(
                  child: Column(
                    children: [
                      imageItemInshowModalBottomSheet(siz, model),
                      ///////////////////////////////////////
                      ////////////[Name of item]////////////
                      ///////////////////////////////////////
                      nameItemInshowModalBottomSheet(siz, model),
                      modelItemInshowModalBottomSheet(siz, model),
                      const Divider(),
                      /////////////////////////////////////////
                      ////////////////////////////////////////
                      ///////////////////////////////////////
                      itemDescriptionInModelBottomSheet(model),
                      colorsAvailableInshowModalBottomSheet(
                          model, sizedBoxBewtweenTriggers, model.selectedColor,
                          (Color select) {
                        modalSetState(() => context
                            .read<DropNewItemsIntoHomeScreenIntegration>()
                            .add(SelectNewItemsColorEvent(model.id, select)));
                      }),
                      const SizedBox(
                        height: 6,
                      ),
                      ///////////////////////////////////////
                      ////////////[Sizes of item]////////////
                      ///////////////////////////////////////
                      if ((model.type ?? '').trim().toLowerCase() == 'bags' ||
                          (model.type ?? '').trim().toLowerCase() == 'headsets')
                        Container()
                      else
                        sizeItemInshowModalBottomSheet(
                            isSizedSelected, siz, model, (size) {
                          modalSetState(
                            () {
                              model.selectedSize = size;
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
                          siz, state, index)
                    ],
                  ),
                );
              },
              itemBuilder: (model, idx) =>
                  ContainerOfFetchingNewItemsInRevenueItems(
                    imgAdress: model.imgAdress,
                    name: model.name,
                    model: model.model,
                    itemColor: model.itemColor,
                    price: model.price,
                    liked: model.liked,
                    idx: idx,
                  ));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget featuresItems(Size siz) {
    Alerts alerts = Alerts();
    return buildItemsSection(
      context: context,
      size: siz,
      blocCreator: () =>
          DropFeatureItemIntoHomeScreenIntegration(ShowFeatureItems()),
      loadingEvent: DropFeatureItemIntoHomeScreenEventLoading(),
      builder: (context, state, size) {
        if (state is DropFeatureItemIntoHomeScreenStateLoading) {
          return loadingStateBlocMethod(siz);
        } else if (state is DropFeatureItemIntoHomeScreenStateError) {
          alerts.ifErrors(state.err);
        } else if (state is DropFeatureItemIntoHomeScreenStateLoaded) {
          List<RevenueIemsModel> revItems = state.items;
          return listItemsAtBLOC(
            siz: siz,
            revItems: revItems,
            isSelectedItem: false,
            context: context,
            buildBottomSheetContent: (index, model, modalSetState) {
              selectedIndex = index;
              bool isSizedSelected = false;
              return Center(
                child: Column(
                  children: [
                    imageItemInshowModalBottomSheet(siz, model),
                    ///////////////////////////////////////
                    ////////////[Name of item]////////////
                    ///////////////////////////////////////
                    nameItemInshowModalBottomSheet(siz, model),

                    modelItemInshowModalBottomSheet(siz, model),
                    const Divider(),
                    /////////////////////////////////////////
                    ////////////////////////////////////////
                    ///////////////////////////////////////
                    itemDescriptionInModelBottomSheet(model),
                    colorsAvailableInshowModalBottomSheet(
                        model, sizedBoxBewtweenTriggers, model.selectedColor,
                        (Color select) {
                      modalSetState(() => context
                          .read<DropFeatureItemIntoHomeScreenIntegration>()
                          .add(SelectColorFeatureItemEvent(model.id, select)));
                    }),
                    const SizedBox(
                      height: 6,
                    ),
                    ///////////////////////////////////////
                    ////////////[Sizes of item]////////////
                    ///////////////////////////////////////
                    (model.type ?? '').trim().toLowerCase() == 'bags'
                        ? Container()
                        : sizeItemInshowModalBottomSheet(
                            isSizedSelected, siz, model, (size) {
                            modalSetState(
                              () {
                                model.selectedSize = size;
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
                        siz, state, index)
                  ],
                ),
              );
            },
            itemBuilder: (model, idx) => ContainerOfFetchingFeaturesItems(
              imgAdress: model.imgAdress,
              name: model.name,
              model: model.model,
              itemColor: model.itemColor,
              price: model.price,
              liked: model.liked,
              idx: idx,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget mostTrindingItems(Size siz) {
    final Alerts alerts = Alerts();
    return buildItemsSection<DropItemsIntoHomeScreenEvent,
        DropItemsIntoHomeScreenState, DropItemsIntoHomeScreenIntegration>(
      context: context,
      size: siz,
      blocCreator: () =>
          DropItemsIntoHomeScreenIntegration(ShowAllItemsMostOfTrinding()),
      loadingEvent: DropItemsIntoHomeScreenEventLoading(),
      builder: (context, state, size) {
        if (state is DropItemsIntoHomeScreenStateLoading) {
          return loadingStateBlocMethod(siz);
        } else if (state is DropItemsIntoHomeScreenStateError) {
          alerts.ifErrors(state.toString());
        } else if (state is DropItemsIntoHomeScreenStateLoaded) {
          List<RevenueIemsModel> revItems = state.items;
          return listItemsAtBLOC(
              siz: siz,
              revItems: revItems,
              isSelectedItem: false,
              context: context,
              buildBottomSheetContent: (index, model, modalSetState) {
                final itemsbag = model;
                bool isSizedSelected = false;
                return Center(
                    child: Column(
                  children: [
                    imageItemInshowModalBottomSheet(siz, model),
                    ///////////////////////////////////////
                    ////////////[Name of item]////////////
                    ///////////////////////////////////////
                    nameItemInshowModalBottomSheet(siz, model),
                    modelItemInshowModalBottomSheet(siz, model),
                    const Divider(),
                    //Description
                    itemDescriptionInModelBottomSheet(model),
                    /////////////////////////////////////////
                    ////////////////////////////////////////
                    ///////////////////////////////////////
                    colorsAvailableInshowModalBottomSheet(
                        model, sizedBoxBewtweenTriggers, model.selectedColor,
                        (Color selected) {
                      modalSetState(() => context
                          .read<DropItemsIntoHomeScreenIntegration>()
                          .add(SelectColorEvent(model.id, selected)));
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                    ///////////////////////////////////////
                    ////////////[Sizes of item]////////////
                    ///////////////////////////////////////
                    sizeItemInshowModalBottomSheet(
                        isSizedSelected, siz, itemsbag, (size) {
                      modalSetState(() {
                        model.selectedSize = size;
                      });
                    }),
                    const SizedBox(
                      height: 6,
                    ),
                    /////////////////////////////////////////////////////
                    ////////////[Count of item & Add to cart]////////////
                    ////////////////////////////////////////////////////
                    countOfItemAndAddToCartOfMostTrindingItemsInshowModalBottomSheet(
                        siz, state, index)
                  ],
                ));
              },
              itemBuilder: (model, idx) => ContainerOfFetchingMostTrindingItems(
                    imgAdress: model.imgAdress,
                    name: model.name,
                    model: model.model,
                    itemColor: model.itemColor,
                    price: model.price,
                    liked: model.liked,
                    idx: idx,
                  ));
        }
        return const SizedBox.shrink();
      },
    );
  }

  SizedBox sizedBoxBewtweenInfos = const SizedBox(height: 15);
  SizedBox sizedBoxBewtweenTriggers = const SizedBox(width: 5);
  Widget listItemsAtBLOC(
      {required Size siz,
      required List<RevenueIemsModel> revItems,
      required bool isSelectedItem,
      required BuildContext context,
      required Function(int index, RevenueIemsModel model,
              void Function(void Function()) modalSetState)
          buildBottomSheetContent,
      required Widget Function(RevenueIemsModel model, int idx) itemBuilder}) {
    return SizedBox(
      height: siz.height / 2.3,
      child: ListView.builder(
        itemCount: revItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final model = revItems[index];
          return GestureDetector(
            onTap: () {
              selectedIndex = index;
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: white,
                  enableDrag: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  context: context,
                  builder: (context) {
                    // String? selectedSize;
                    return StatefulBuilder(builder: (context, modalSetState) {
                      return SizedBox(
                        height: siz.height / 1.6,
                        child: SingleChildScrollView(
                          child: Center(
                            child: buildBottomSheetContent(
                                index, model, modalSetState),
                          ),
                        ),
                      );
                    });
                  });
            },
            child: itemBuilder(model, index),
          );
        },
      ),
    );
  }

  Widget buildItemsSection<TEvent, TState, TBloc extends Bloc<TEvent, TState>>({
    required BuildContext context,
    required Size size,
    required TBloc Function() blocCreator,
    required dynamic loadingEvent,
    required Widget Function(BuildContext context, TState state, Size size)
        builder,
  }) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TBloc>(
              create: (context) => blocCreator()..add(loadingEvent))
        ],
        child: BlocBuilder<TBloc, TState>(
          builder: (context, state) {
            return builder(context, state, size);
          },
        ));
  }

  GridView loadingStateBlocMethod(Size siz) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemCount: 2,
      itemBuilder: (context, index) => CardLoading(
        height: siz.height,
        margin: EdgeInsets.symmetric(
          horizontal: siz.height * 0.005,
        ),
        width: siz.width / 1.81,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
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

  SizedBox colorsAvailableInshowModalBottomSheet(
      RevenueIemsModel model,
      SizedBox sizedBoxBewtweenTriggers,
      Color? selectedColor,
      Function(Color) onColorSelected) {
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
                        onPressed: () => onColorSelected(color),
                        child: const Text(
                          '',
                        )),
                  );
                },
              ).toList()),
        ));
  }

  SizedBox rateItemInshowModalBottomSheet(Size siz, RevenueIemsModel model) {
    print("Rate for item in Home screen: ${model.rate}");
    int fullStars = model.rate.floor();
    bool hasHalfStar = (model.rate - fullStars) >= 0.5;
    return SizedBox(
        width: siz.width / 1.4,
        height: 10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) {
              if (index < fullStars) {
                return const Icon(Icons.star, color: Colors.amber, size: 17);
              } else if (index == hasHalfStar && hasHalfStar) {
                return const Icon(Icons.star_half,
                    color: Colors.amber, size: 17);
              } else {
                return const Icon(Icons.star_border,
                    color: Colors.amber, size: 17);
              }
            },
          ),
        ));
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.price} JOD',
                  style: GoogleFonts.aleo(
                      color: black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.2),
                ),
                const SizedBox(width: 10),
                rateItemInshowModalBottomSheet(siz, model),
              ],
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

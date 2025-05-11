import 'package:css/Backend/Blocs/FetchCartItemsBloc/FetchNameAndPictureEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/FetchNameAndPictureIntegration.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/FetchNameAndPictureState.dart';
import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/SignOutController.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Front/Functions/AppMethods.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:card_loading/card_loading.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:css/Backend/RevenueItems/RevData.dart';
import 'package:flutter/cupertino.dart';

final controller = Get.put(ProfileController());
final control = Get.put(SignOutCopntroller());
final cartController = Get.put(AppMethods());

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedFeature = 0;
  int selectItems = 1;

  // Add to fav
  void _toggleLikeFrommostTrending(int indeex) {
    setState(() {
      mostTrending[indeex].liked = !mostTrending[indeex].liked;
    });
  }

  void _toggleLikeFromFeaturesItems(int indeex) {
    setState(() {
      itemsFeatures[indeex].liked = !itemsFeatures[indeex].liked;
    });
  }

  void _toggleLikeFromNewItems(int indeex) {
    setState(() {
      newItemsOfRev[indeex].liked = !newItemsOfRev[indeex].liked;
    });
  }

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final siz = MediaQuery.of(context).size;
    SizedBox sizedBoxBewtweenTriggers = const SizedBox(width: 40);
    return Scaffold(
      appBar: searchBarForItems(),
      backgroundColor: white,
      body: SafeArea(
          child: SingleChildScrollView(
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
                UpcomingItems(siz: siz),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      )),
    );
  }

  AppBar searchBarForItems() {
    return AppBar(
      surfaceTintColor: white,
      shadowColor: white,
      backgroundColor: white,
      toolbarHeight: 45,
      elevation: 0,
      title: const CupertinoSearchTextField(
        cursorWidth: 34,
      ),
    );
  }

  MultiBlocProvider newItemsInRevenue(Size siz) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => FetchCartItemsIntegration(AppMethods())
              ..add(
                FetchCartitemsEventLoading(),
              )),
      ],
      child: BlocBuilder<FetchCartItemsIntegration, FetchCartItemsState>(
        builder: (context, newItemsInRevenueState) {
          final Alerts alerts = Alerts();
          if (newItemsInRevenueState is FetchCartItemsStateLoading) {
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
          } else if (newItemsInRevenueState is FetchCartItemsStateError) {
            return alerts.ifErrors(newItemsInRevenueState.err);
          } else if (newItemsInRevenueState is FetchCartItemsStateLoaded) {
            return SizedBox(
              height: siz.height / 2.3,
              child: ListView.builder(
                itemCount: newItemsOfRev.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) {
                  RevenueIemsModel model = newItemsOfRev[idx];
                  final itemsBag = model;
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
                                    BorderRadius.all(Radius.circular(5))),
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: siz.height / 1.6,
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        nameItemInshowModalBottomSheet(
                                            itemsBag),
                                        imageItemInshowModalBottomSheet(
                                            siz, itemsBag),
                                        ///////////////////////////////////////
                                        ////////////[Name of item]////////////
                                        ///////////////////////////////////////
                                        modelItemInshowModalBottomSheet(
                                            itemsBag),

                                        rateItemInshowModalBottomSheet(
                                            siz, itemsBag),
                                        sizedBoxBewtweenInfos,
                                        /////////////////////////////////////////
                                        ////////////////////////////////////////
                                        ///////////////////////////////////////
                                        colorsAvailableInshowModalBottomSheet(
                                            itemsBag, sizedBoxBewtweenTriggers),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        ///////////////////////////////////////
                                        ////////////[Sizes of item]////////////
                                        ///////////////////////////////////////
                                        sizeItemInshowModalBottomSheet(
                                            isSizedSelected, siz, itemsBag),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        /////////////////////////////////////////////////////
                                        ////////////[Count of item & Add to cart]////////////
                                        ////////////////////////////////////////////////////
                                        countOfItemAndAddToCartOfNewItemsInRevenueInshowModalBottomSheet(
                                            siz, sizedBoxBewtweenTriggers, idx)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: siz.height * 0.005,
                          vertical: siz.height * 0.01),
                      width: siz.width / 1.5,
                      child: Stack(
                        children: [
                          Container(
                            width: siz.width / 1.81,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: model.itemColor,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Positioned(
                            top: 5,
                            left: 20,
                            child: Column(
                              children: [
                                Text(
                                  model.name,
                                  style: GoogleFonts.aleo(
                                      color: black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text('${model.price} JOD',
                                    style: GoogleFonts.aleo(
                                        fontSize: 15, color: black)),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 60,
                            top: 50,
                            child: SizedBox(
                              width: 200,
                              height: 230,
                              child: Image(image: AssetImage(model.imgAdress)),
                            ),
                          ),
                          Positioned(
                              top: 300,
                              left: 10,
                              child: Text(
                                model.model,
                                style: GoogleFonts.aleo(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: black),
                              )),
                          Positioned(
                            top: 330,
                            left: 180,
                            child: IconButton(
                                onPressed: () => _toggleLikeFromNewItems(idx),
                                icon: Icon(Iconsax.heart,
                                    size: 40,
                                    color: newItemsOfRev[idx].liked
                                        ? redColor
                                        : black)),
                          ),
                        ],
                      ),
                    ),
                  );
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
            create: (context) => FetchCartItemsIntegration(AppMethods())
              ..add(
                FetchCartitemsEventLoading(),
              )),
      ],
      child: BlocBuilder<FetchCartItemsIntegration, FetchCartItemsState>(
          builder: (context, featureItemsState) {
        final Alerts alerts = Alerts();
        if (featureItemsState is FetchCartItemsStateLoading) {
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
        } else if (featureItemsState is FetchCartItemsStateError) {
          return alerts.ifErrors(featureItemsState.err);
        } else if (featureItemsState is FetchCartItemsStateLoaded) {
          return SizedBox(
            height: siz.height / 2.3,
            child: ListView.builder(
              itemCount: itemsFeatures.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, idx) {
                bool isSizedSelected = false;
                RevenueIemsModel model = itemsFeatures[idx];
                final itemsBag = model;

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
                                  BorderRadius.all(Radius.circular(5))),
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: siz.height / 1.6,
                              child: SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    children: [
                                      nameItemInshowModalBottomSheet(model),
                                      imageItemInshowModalBottomSheet(
                                          siz, model),
                                      ///////////////////////////////////////
                                      ////////////[Name of item]////////////
                                      ///////////////////////////////////////
                                      modelItemInshowModalBottomSheet(model),

                                      rateItemInshowModalBottomSheet(
                                          siz, model),
                                      sizedBoxBewtweenInfos,
                                      /////////////////////////////////////////
                                      ////////////////////////////////////////
                                      ///////////////////////////////////////
                                      colorsAvailableInshowModalBottomSheet(
                                          model, sizedBoxBewtweenTriggers),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      ///////////////////////////////////////
                                      ////////////[Sizes of item]////////////
                                      ///////////////////////////////////////
                                      sizeItemInshowModalBottomSheet(
                                          isSizedSelected, siz, itemsBag),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      /////////////////////////////////////////////////////
                                      ////////////[Count of item & Add to cart]////////////
                                      ////////////////////////////////////////////////////
                                      countOfItemAndAddToCartOfFeaturesItemsInshowModalBottomSheet(
                                          siz, sizedBoxBewtweenTriggers, idx)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: siz.height * 0.005,
                        vertical: siz.height * 0.01),
                    width: siz.width / 1.5,
                    child: Stack(
                      children: [
                        Container(
                          width: siz.width / 1.81,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: model.itemColor,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Positioned(
                          top: 5,
                          left: 20,
                          child: Column(
                            children: [
                              Text(
                                model.name,
                                style: GoogleFonts.aleo(
                                    color: black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text('${model.price} JOD',
                                  style: GoogleFonts.aleo(
                                      fontSize: 15, color: black)),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 60,
                          top: 50,
                          child: SizedBox(
                            width: 200,
                            height: 230,
                            child: Image(image: AssetImage(model.imgAdress)),
                          ),
                        ),
                        Positioned(
                            top: 300,
                            left: 10,
                            child: Text(
                              model.model,
                              style: GoogleFonts.aleo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: black),
                            )),
                        Positioned(
                          top: 330,
                          left: 180,
                          child: IconButton(
                              onPressed: () =>
                                  _toggleLikeFromFeaturesItems(idx),
                              icon: Icon(Iconsax.heart,
                                  size: 40,
                                  color: itemsFeatures[idx].liked
                                      ? redColor
                                      : black)),
                        ),
                      ],
                    ),
                  ),
                );
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
              create: (context) => FetchCartItemsIntegration(AppMethods())
                ..add(
                  FetchCartitemsEventLoading(),
                )),
        ],
        child: BlocBuilder<FetchCartItemsIntegration, FetchCartItemsState>(
          builder: (context, addToCartstate) {
            if (addToCartstate is FetchCartItemsStateLoading) {
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
            if (addToCartstate is FetchCartItemsStateError) {
              return alerts.ifErrors(addToCartstate.err);
            } else if (addToCartstate is FetchCartItemsStateLoaded) {
              List<RevenueIemsModel> revItems = mostTrending;
              return SizedBox(
                height: siz.height / 2.3,
                child: ListView.builder(
                  itemCount: revItems.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, idx) {
                    final item = mostTrending[idx];
                    final RevenueIemsModel itemsbag = item;

                    final model = mostTrending[idx];
                    bool isSizedSelected = false;
                    // Show item in  bottom sheet
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
                                      BorderRadius.all(Radius.circular(5))),
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: siz.height / 1.6,
                                  child: SingleChildScrollView(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          nameItemInshowModalBottomSheet(model),
                                          imageItemInshowModalBottomSheet(
                                              siz, model),
                                          ///////////////////////////////////////
                                          ////////////[Name of item]////////////
                                          ///////////////////////////////////////
                                          modelItemInshowModalBottomSheet(
                                              model),

                                          rateItemInshowModalBottomSheet(
                                              siz, model),
                                          sizedBoxBewtweenInfos,
                                          /////////////////////////////////////////
                                          ////////////////////////////////////////
                                          ///////////////////////////////////////
                                          colorsAvailableInshowModalBottomSheet(
                                              model, sizedBoxBewtweenTriggers),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          ///////////////////////////////////////
                                          ////////////[Sizes of item]////////////
                                          ///////////////////////////////////////
                                          sizeItemInshowModalBottomSheet(
                                              isSizedSelected, siz, itemsbag),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          /////////////////////////////////////////////////////
                                          ////////////[Count of item & Add to cart]////////////
                                          ////////////////////////////////////////////////////
                                          countOfItemAndAddToCartOfMostTrindingItemsInshowModalBottomSheet(
                                              siz,
                                              sizedBoxBewtweenTriggers,
                                              idx)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        });
                      },
                      ///////////////////////////////////////
                      ////////////[items]////////////////////
                      ///////////////////////////////////////
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: siz.height * 0.005,
                            vertical: siz.height * 0.01),
                        width: siz.width / 1.5,
                        child: Stack(
                          children: [
                            Container(
                              width: siz.width / 1.81,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: model.itemColor,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            Positioned(
                              top: 5,
                              left: 20,
                              child: Column(
                                children: [
                                  Text(
                                    model.name,
                                    style: GoogleFonts.aleo(
                                        color: black,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text('${model.price} JOD',
                                      style: GoogleFonts.aleo(
                                          fontSize: 15, color: black)),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 60,
                              top: 50,
                              child: SizedBox(
                                width: 200,
                                height: 230,
                                child:
                                    Image(image: AssetImage(model.imgAdress)),
                              ),
                            ),
                            Positioned(
                                top: 300,
                                child: Text(
                                  model.model,
                                  style: GoogleFonts.aleo(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: black),
                                )),
                            Positioned(
                              top: 330,
                              left: 180,
                              child: IconButton(
                                  onPressed: () =>
                                      _toggleLikeFrommostTrending(idx),
                                  icon: Icon(Iconsax.heart,
                                      size: 40,
                                      color: mostTrending[idx].liked
                                          ? redColor
                                          : black)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ));
  }

  Container sizeItemInshowModalBottomSheet(
      bool isSizedSelected, Size siz, RevenueIemsModel itemsbag) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: grey, width: 0.5),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(left: 240),
        height: siz.height * 0.04,
        width: siz.width / 4,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: itemsbag.sizes.length,
          itemBuilder: (context, sizeIndex) {
            return SizedBox(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Choose:",
                    style: GoogleFonts.aleo(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: itemsbag.sizes.map<Widget>((size) {
                    return SizedBox(
                      height: siz.height / 10,
                      width: siz.width / 5,
                      child: SizedBox(
                        width: siz.width / 13,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: itemsbag.selectedSize,
                            hint: Text(
                              "Size",
                              style: GoogleFonts.aleo(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.w600),
                            ),
                            isExpanded: true,
                            items: itemsbag.sizes
                                .map<DropdownMenuItem<String>>((size) {
                              return DropdownMenuItem<String>(
                                value: size,
                                child: Text(size.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                itemsbag.selectedSize = size;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ));
          },
        ));
  }

  Padding countOfItemAndAddToCartOfMostTrindingItemsInshowModalBottomSheet(
      Size siz, SizedBox sizedBoxBewtweenTriggers, int idx) {
    void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
      await cartController.saveItemsToTheCart(mostTrending[idx]);
    }

    RevenueIemsModel model = mostTrending[idx];
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
      Size siz, SizedBox sizedBoxBewtweenTriggers, int idx) {
    void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
      await cartController.saveItemsToTheCart(newItemsOfRev[idx]);
    }

    RevenueIemsModel model = newItemsOfRev[idx];
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

  Padding countOfItemAndAddToCartOfFeaturesItemsInshowModalBottomSheet(
      Size siz, SizedBox sizedBoxBewtweenTriggers, int idx) {
    void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
      await cartController.saveItemsToTheCart(itemsFeatures[idx]);
    }

    RevenueIemsModel model = itemsFeatures[idx];
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

  Container colorsAvailableInshowModalBottomSheet(
      RevenueIemsModel model, SizedBox sizedBoxBewtweenTriggers) {
    final size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(left: 240),
        height: size.height * 0.03,
        width: size.width / 3.2,
        child: SizedBox(
            width: sizedBoxBewtweenTriggers.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: model.colorsAvailable.map(
                  (color) {
                    final isSelected = model.selectedColor == color;
                    return GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          model.selectedColor = color;
                          print("Color Choosen:${model.selectedColor}");
                        } else if (!isSelected) {
                          setState(() {
                            print(
                                "Color not Choosen:${model.selectedColor = model.itemColor}");
                            model.selectedColor = model.itemColor;
                          });
                        }
                      },
                      child: Container(
                        width: size.width / 14,
                        decoration: BoxDecoration(
                            color: isSelected ? grey : black,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1)),
                        child: CircleAvatar(
                          backgroundColor: color,
                        ),
                      ),
                    );
                  },
                ).toList())));
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

  Padding modelItemInshowModalBottomSheet(RevenueIemsModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  Center nameItemInshowModalBottomSheet(RevenueIemsModel model) {
    return Center(
      child: Text(
        model.name,
        style: GoogleFonts.aleo(
            color: black, fontSize: 31, fontWeight: FontWeight.w600),
      ),
    );
  }

  SizedBox imageItemInshowModalBottomSheet(Size siz, RevenueIemsModel model) {
    return SizedBox(
      ///////////////////////////////////////
      ////////////[Image of item]////////////
      ///////////////////////////////////////
      height: siz.height / 2,
      width: siz.width / 1.2 + 0.72,
      child: Image(image: AssetImage(model.imgAdress)),
    );
  }
}

class UpcomingItems extends StatelessWidget {
  const UpcomingItems({
    super.key,
    required this.siz,
  });

  final Size siz;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: siz.width / 1.1,
      child: Text(
        'Upcoming',
        style: GoogleFonts.aleo(
            color: grey, fontSize: 21, fontWeight: FontWeight.w400),
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
        'News',
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

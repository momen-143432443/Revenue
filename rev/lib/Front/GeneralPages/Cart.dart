import 'package:css/Backend/AuthenticationControls/AuthenticationRepo.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/FetchNameAndPictureEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/FetchNameAndPictureIntegration.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/FetchNameAndPictureState.dart';
import 'package:css/Backend/Controllers/ForProductControllers/InsertInfoOfPurchaseProduct.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Tools/Alerts.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:css/Front/Functions/AppMethods.dart';
import 'package:animate_do/animate_do.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:math' as math;

final cartController = Get.put(AppMethods());
final insertItemInfo = Get.put(InsertInfoOfPurchaseProduct());

class Cart extends StatefulWidget {
  const Cart({
    super.key,
  });

  @override
  State<Cart> createState() => _CommunityState();
}

class _CommunityState extends State<Cart> {
  final ScrollController controller = ScrollController();
  bool _isButtonVisible = true;
  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          children: [
            bagAppBar(size),
            Column(
              children: [itemsOfBagList(size)],
            )
          ],
        ),
      ),
    );
  }

  MultiBlocProvider itemsOfBagList(Size size) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => FetchCartItemsIntegration(AppMethods())
                ..add(
                  FetchCartitemsEventLoading(),
                )),
        ],
        child: BlocBuilder<FetchCartItemsIntegration, FetchCartItemsState>(
          builder: (context, state) {
            final alerts = Alerts();
            if (state is FetchCartItemsStateError) {
              return alerts.ifErrors(state.err);
            } else if (state is FetchCartItemsStateLoaded) {
              return SizedBox(
                width: size.width,
                height: size.height / 1.11,
                child:
                    (state.cart.isEmpty && insertItemInfo.purchaseSuccess.value)
                        ? const EmptyState()
                        : Stack(children: [
                            itemsInfo(size),
                            confirmAndPurchaseAndTotalPrice(size)
                          ]),
              );
            }

            return Container();
          },
        ));
  }

  MultiBlocProvider itemsInfo(Size size) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => FetchCartItemsIntegration(AppMethods())
              ..add(
                FetchCartitemsEventLoading(),
              )),
      ],
      child: BlocBuilder<FetchCartItemsIntegration, FetchCartItemsState>(
        builder: (context, cartState) {
          final alerts = Alerts();
          if (cartState is FetchCartItemsStateError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              alerts.ifErrors(cartState.err);
            });
          } else if (cartState is FetchCartItemsStateLoaded) {
            List<RevenueIemsModel> revItems = cartState.cart;
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: revItems.length,
              itemBuilder: (context, bagIndex) {
                final item = cartState.cart[bagIndex];
                print("Loading image: ${item.imgAdress}");
                print(item.itemColor.toString());
                void countPlus(int index) {
                  setState(() {
                    cartState.cart[index].countOfItem++;
                  });
                }

                void countMinus(int index) {
                  setState(() {
                    if (cartState.cart[index].countOfItem > 1) {
                      cartState.cart[index].countOfItem--;
                    }
                  });
                }

                SizedBox sizedBoxBewtweenTriggers = const SizedBox(width: 4);
                final RevenueIemsModel itemsbag = item;
                return SizedBox(
                  width: size.width,
                  height: size.height / 5.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                imageOfItemFromBloc(size, cartState, bagIndex),
                                ////////////////
                                ///////////////
                                const SizedBox(
                                  width: 10,
                                ),

                                /////////////
                                ////////////
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 1),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          nameAndModelOfTheItems(
                                              cartState, bagIndex),
                                          priceOfTheItemWithIncreaseAndDecreaseItemCount(
                                              item,
                                              sizedBoxBewtweenTriggers,
                                              cartState,
                                              bagIndex,
                                              size,
                                              countPlus,
                                              countMinus)
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        colorsAvailableInshowModalBottomSheet(
                                            size, itemsbag),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        isEdited
                                            ? editSizeItemInshowModalBottomSheet(
                                                itemsbag,
                                                sizedBoxBewtweenTriggers)
                                            : showSizeOfItem(itemsbag,
                                                sizedBoxBewtweenTriggers)
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 23,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isEdited = !isEdited;
                                          });
                                        },
                                        icon: const Icon(Iconsax.edit),
                                        color: black,
                                      ),
                                    ),
                                    SizedBox(
                                      child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<FetchCartItemsIntegration>()
                                              .add(
                                                  DeleteExistSpecificItemFromCart(
                                                      cartState
                                                          .cart[bagIndex].id));
                                          setState(() {
                                            revItems.removeWhere((element) =>
                                                element.id == itemsbag.id);
                                          });
                                        },
                                        icon: const Icon(Iconsax.trash),
                                        color: redColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  SizedBox priceOfTheItemWithIncreaseAndDecreaseItemCount(
      RevenueIemsModel item,
      SizedBox sizedBoxBewtweenTriggers,
      FetchCartItemsStateLoaded cartState,
      int bagIndex,
      Size size,
      void Function(int index) countPlus,
      void Function(int index) countMinus) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Text(
              '${item.price}JOD',
              style: GoogleFonts.aleo(
                  fontSize: 15, color: black, fontWeight: FontWeight.w500),
            ),
          ),
          sizedBoxBewtweenTriggers,
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                //////////////////////////////////////
                /// Added Count Of Item/////////////
                /// ///////////////////////////////
                cartState.cart[bagIndex].countOfItem >= 30
                    ? Container(
                        height: size.height / 23,
                        width: size.width / 11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: grey),
                        child: const Icon(
                          Icons.add,
                          color: black,
                        ))
                    : Container(
                        height: size.height / 23,
                        width: size.width / 11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: grey),
                        child: IconButton(
                            onPressed: () {
                              setState(() => countPlus(bagIndex));
                            },
                            icon: const Icon(
                              Icons.add,
                              color: black,
                            )),
                      ),
                sizedBoxBewtweenTriggers,
                Text('${cartState.cart[bagIndex].countOfItem}'),
                sizedBoxBewtweenTriggers,
                //////////////////////////////////////
                /// Remove Count Of Item/////////////
                /// ///////////////////////////////
                cartState.cart[bagIndex].countOfItem <= 1
                    ? Container(
                        height: size.height / 23,
                        width: size.width / 11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: grey),
                        child: const Icon(Icons.remove),
                      )
                    : Container(
                        height: size.height / 23,
                        width: size.width / 11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: grey),
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() => countMinus(bagIndex));
                          },
                          color: black,
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox imageOfItemFromBloc(
      Size size, FetchCartItemsStateLoaded cartState, int bagIndex) {
    return SizedBox(
        width: size.width * 0.4,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: cartState.cart[bagIndex].itemColor),
              borderRadius: BorderRadius.circular(20)),
          width: 140,
          height: 140,
          child: Image(image: AssetImage(cartState.cart[bagIndex].imgAdress)),
        ));
  }

  Column nameAndModelOfTheItems(
      FetchCartItemsStateLoaded cartState, int bagIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cartState.cart[bagIndex].name,
          style: GoogleFonts.aleo(
              fontSize: 15, color: black, fontWeight: FontWeight.w600),
        ),
        Text(
          cartState.cart[bagIndex].model,
          style: GoogleFonts.aleo(
              fontSize: 10, color: black, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Container colorsAvailableInshowModalBottomSheet(
      Size size, RevenueIemsModel itemsbag) {
    return Container(
        margin: const EdgeInsets.only(right: 34),
        height: size.height * 0.03,
        width: size.width / 3.2,
        child: SizedBox(
            width: size.width,
            child: Row(
                children: itemsbag.colorsAvailable.map(
              (color) {
                final isSelected = itemsbag.selectedColor == color;
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      itemsbag.selectedColor = color;
                      print("Color Choosen:${itemsbag.selectedColor}");
                    } else if (!isSelected) {
                      setState(() {
                        print(
                            "Color not Choosen:${itemsbag.selectedColor = itemsbag.itemColor}");
                        itemsbag.selectedColor = itemsbag.itemColor;
                      });
                    }
                  },
                  child: Container(
                    width: size.width / 14,
                    decoration: BoxDecoration(
                        color: isSelected ? color : itemsbag.itemColor,
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

  Container showSizeOfItem(
      RevenueIemsModel itemsbag, SizedBox sizedBoxBewtweenTriggers) {
    final aSize = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(right: 90),
        height: aSize.height * 0.04,
        width: aSize.width / 6.1,
        child: Row(
          children: [
            Text("Size:",
                style: GoogleFonts.aleo(
                    fontSize: 14, color: black, fontWeight: FontWeight.w600)),
            Text("${itemsbag.selectedSize}",
                style: GoogleFonts.aleo(
                    fontSize: 14, color: black, fontWeight: FontWeight.w600))
          ],
        ));
  }

  Container editSizeItemInshowModalBottomSheet(
      RevenueIemsModel itemsbag, SizedBox sizedBoxBewtweenTriggers) {
    final aSize = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
            color: grey,
            border: Border.all(color: black, width: 0.5),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(right: 90),
        height: aSize.height * 0.04,
        width: aSize.width / 6.1,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: itemsbag.sizes.length,
          itemBuilder: (context, sizeIndex) {
            return SizedBox(
                width: aSize.width / 2.2,
                child: Row(
                  children: [
                    Text("Choose:",
                        style: GoogleFonts.aleo(
                            fontSize: 12,
                            color: black,
                            fontWeight: FontWeight.w600)),
                    Row(
                      children: itemsbag.sizes.map<Widget>((size) {
                        return SizedBox(
                          height: aSize.height / 10,
                          width: aSize.width / 5,
                          child: SizedBox(
                            width: aSize.width / 13,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: itemsbag.selectedSize,
                                hint: Text(
                                  "Size",
                                  style: GoogleFonts.aleo(
                                      fontSize: 11,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                                isExpanded: true,
                                items: itemsbag.sizes
                                    .map<DropdownMenuItem<String>>((size) {
                                  return DropdownMenuItem<String>(
                                    value: size,
                                    child: Text(size),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    itemsbag.selectedSize = value;
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

  MultiBlocProvider confirmAndPurchaseAndTotalPrice(Size size) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchCartItemsIntegration(AppMethods())
            ..add(FetchCartitemsEventLoading()),
        )
      ],
      child: BlocBuilder<FetchCartItemsIntegration, FetchCartItemsState>(
        builder: (context, cartState) {
          if (cartState is FetchCartItemsStateLoading) {
            return Center(
                child: LoadingAnimationWidget.progressiveDots(
                    color: lime, size: 55));
          } else if (cartState is FetchCartItemsStateLoaded) {
            double showTotalPriceInButton() {
              double total = 0;
              for (var item in cartState.cart) {
                total += item.price * item.countOfItem;
              }
              return total;
            }

            double totalPrice() {
              double total = 0.0;
              for (var item in cartState.cart) {
                total += item.price * item.countOfItem;
              }
              return total + 16;
            }

            Future<void> cartCheckOut() async {
              final List<Map<String, dynamic>> itemsJson = cartState.cart
                  .map((e) => e.fromCartJsonToMongoDbDatabase())
                  .toList();
              final user = AuthenticationRepo.instance.auth.currentUser;
              final userId = user?.uid ?? '';
              await insertItemInfo.purchaseProductToDataBase(
                  userId, itemsJson, totalPrice());
            }

            print('!!!!!!!!!!!!!!!!!!!!!!!!!!!');
            print(insertItemInfo.purchaseSuccess.value);
            // List<RevenueIemsModel> revItems = cartState.cart;
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, bagIndex) {
                  final item = cartState.cart[bagIndex];
                  final RevenueIemsModel itemsbag = item;
                  return SizedBox(
                    height: 850,
                    child: Stack(
                      children: [
                        Positioned(
                            left: 20,
                            top: 750,
                            child: FadeInUp(
                              delay: const Duration(milliseconds: 100),
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  if (details.delta.dy > 10) {
                                    setState(() {
                                      _isButtonVisible = false;
                                    });
                                  } else {
                                    setState(() {
                                      _isButtonVisible = true;
                                    });
                                  }
                                },
                                onTap: () =>
                                    insertItemInfo.purchaseSuccess.value
                                        ? null
                                        : showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: white,
                                            enableDrag: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14))),
                                            context: context,
                                            builder: (context) {
                                              return SizedBox(
                                                height: size.height / 3,
                                                child: SingleChildScrollView(
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        howDoYouLikeToPayText(),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        waysToPay(),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        total(size,
                                                            showTotalPriceInButton),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        deliverCompanies(
                                                            size, item),
                                                        const SizedBox(
                                                          height: 14,
                                                        ),
                                                        confirmPurchase(
                                                            size, cartCheckOut)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: _isButtonVisible ? 1.0 : 0.0,
                                  child: Container(
                                    height: size.height / 23,
                                    width: size.width / 1.1,
                                    decoration: BoxDecoration(
                                      color: blueColor,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Obx(() =>
                                          insertItemInfo.purchaseSuccess.value
                                              ? GestureDetector(
                                                  onTap: () => setState(() {
                                                        showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              white,
                                                          enableDrag: true,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          14))),
                                                          context: context,
                                                          builder: (context) {
                                                            return SizedBox(
                                                              height:
                                                                  size.height /
                                                                      4,
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              10,
                                                                          vertical:
                                                                              3),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Estimated time of delivery : 20/May/2025",
                                                                            style:
                                                                                GoogleFonts.aleo(
                                                                              fontSize: 14,
                                                                              color: black,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              // It will take us to customer service
                                                                            },
                                                                            child:
                                                                                const Stack(
                                                                              children: [
                                                                                Positioned(
                                                                                  right: 3.1,
                                                                                  bottom: 7,
                                                                                  child: Icon(
                                                                                    Icons.headset_mic_rounded,
                                                                                    size: 18,
                                                                                  ),
                                                                                ),
                                                                                Icon(Iconsax.user, size: 24)
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Purchase Successfully',
                                                        style: GoogleFonts.aleo(
                                                          fontSize: 20,
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Iconsax.more,
                                                        color: white,
                                                      )
                                                    ],
                                                  ))
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Confirm & purchase',
                                                      style: GoogleFonts.aleo(
                                                        fontSize: 20,
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Total:${showTotalPriceInButton()}',
                                                      style: GoogleFonts.aleo(
                                                        fontSize: 14,
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }

  FadeInUp confirmPurchase(Size size, Future<void> Function() cartCheckOut) {
    return FadeInUp(
      duration: const Duration(milliseconds: 200),
      delay: const Duration(seconds: 4),
      child: Container(
          width: size.width / 1.5,
          margin: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(blueColor)),
            /////////////////////
            ////////////////////
            onPressed: () async => await cartCheckOut(),
            ////////////////////
            child: Text(
              "Purchase & Confirm ",
              style: GoogleFonts.aleo(
                  fontSize: 20, color: white, fontWeight: FontWeight.w600),
            ),
          )),
    );
  }

  FadeInLeft deliverCompanies(Size size, RevenueIemsModel itemsBag) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 200),
      delay: const Duration(seconds: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver company",
            style: GoogleFonts.aleo(
                fontSize: 24, color: black, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: itemsBag.deliverCompanies.map((deliver) {
                final isSelected = itemsBag.selectedDeliverCompany == deliver;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      itemsBag.selectedDeliverCompany = deliver;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: size.width / 4,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 2,
                          color: isSelected ? Colors.blue : Colors.grey),
                    ),
                    child: Image.asset(deliver, fit: BoxFit.contain),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  FadeInLeft total(Size size, Function() totalPrice) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 200),
      delay: const Duration(seconds: 2),
      child: SizedBox(
        width: size.width / 1.04,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Total price of items: ",
                  style: GoogleFonts.aleo(
                      fontSize: 16, color: black, fontWeight: FontWeight.w500),
                ),
                Text(
                  "${totalPrice()}",
                  style: GoogleFonts.aleo(
                      fontSize: 13, color: black, fontWeight: FontWeight.w700),
                )
              ],
            ),
            Row(
              children: [
                Text("Tax: ",
                    style: GoogleFonts.aleo(
                        fontSize: 16,
                        color: black,
                        fontWeight: FontWeight.w500)),
                Text(
                  "16 JOD",
                  style: GoogleFonts.aleo(
                      fontSize: 13, color: black, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Text("Total: ",
                    style: GoogleFonts.aleo(
                        fontSize: 16,
                        color: black,
                        fontWeight: FontWeight.w500)),
                Text(
                  "${totalPrice() + 16} JOD",
                  style: GoogleFonts.aleo(
                      fontSize: 13, color: black, fontWeight: FontWeight.w700),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  FadeInLeft waysToPay() {
    return FadeInLeft(
      duration: const Duration(milliseconds: 200),
      delay: const Duration(seconds: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(grey)),
              icon: const Icon(
                Icons.credit_card,
                color: black,
              ),
              onPressed: () {},
              label: Text(
                'Visa',
                style:
                    GoogleFonts.aleo(color: black, fontWeight: FontWeight.w600),
              )),
          ElevatedButton.icon(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(grey)),
            onPressed: () {},
            label: Text(
              "Paypal",
              style:
                  GoogleFonts.aleo(color: black, fontWeight: FontWeight.w600),
            ),
            icon: const Icon(
              Icons.paypal,
              color: black,
            ),
          ),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(grey)),
              onPressed: () {},
              child: Text(
                "Cash On Delivery(COD)",
                style:
                    GoogleFonts.aleo(color: black, fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }

  FadeInLeft howDoYouLikeToPayText() {
    return FadeInLeft(
        duration: const Duration(milliseconds: 200),
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Transform.rotate(
                  angle: math.pi / 9,
                  child: const Icon(
                    Icons.payments_rounded,
                    color: greenColor,
                    size: 30,
                  )),
              Text(
                "How do you like to pay",
                style: GoogleFonts.aleo(
                    fontSize: 24, color: black, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }

  MultiBlocProvider bagAppBar(Size size) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => FetchCartItemsIntegration(AppMethods())
                ..add(
                  FetchCartitemsEventLoading(),
                )),
        ],
        child: BlocBuilder<FetchCartItemsIntegration, FetchCartItemsState>(
            builder: (context, cartState) {
          final Alerts alerts = Alerts();
          if (cartState is FetchCartItemsStateLoading) {
            return Container(
                margin: const EdgeInsets.only(top: 20, right: 300),
                child: Text(
                  "Loading...",
                  style: GoogleFonts.aleo(
                      fontSize: 15, color: black, fontWeight: FontWeight.w600),
                ));
          } else if (cartState is FetchCartItemsStateLoaded) {
            //To show of total of items in the bag, based on  firestore
            final totalItems =
                cartState.cart.fold(0, (sum, item) => sum + item.countOfItem);
            return SizedBox(
                width: size.width,
                height: size.height * 0.05,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Cart',
                        style: GoogleFonts.aleo(
                            fontSize: 20,
                            color: black,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Total Items $totalItems',
                        style: GoogleFonts.aleo(
                            fontSize: 15,
                            color: black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ));
          } else if (cartState is FetchCartItemsStateEmpty) {
            return const EmptyState();
          } else if (cartState is FetchCartItemsStateError) {
            return alerts.ifErrors(cartState.err);
          }
          return Container();
        }));
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 300),
      child: Column(
        children: [
          Text(
            "No Products added",
            style: GoogleFonts.aleo(
                fontSize: 30, color: black, fontWeight: FontWeight.w300),
          ),
          const Icon(
            Iconsax.bag_2,
            size: 40,
          )
        ],
      ),
    );
  }
}

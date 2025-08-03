import 'dart:convert';
import 'package:css/Backend/Controllers/ForProductControllers/MoreSectionController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Backend/RevenueItems/RevData.dart';
import 'package:css/Front/Functions/AppMethods.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart' as getx;
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  Color? selectedColor;
  String? selectedSize;
  final offers = getx.Get.put(OfferItems());
  final offerAddToCart = getx.Get.put(AppMethods());
  @override
  Widget build(BuildContext context) {
    final userData = getx.Get.put(ProfileController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        title: Text(
          "Offers",
          style: GoogleFonts.aleo(
              color: black, fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
          child: Center(
              child: SizedBox(
                  height: size.height / 1.140,
                  child: getx.Obx(
                    () => GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: offers.offerItems.length,
                      itemBuilder: (context, index) {
                        final item = offers.items[index];
                        final user = userData.user.value;
                        if (user.email == null || user.email!.isEmpty) {
                          return Center(
                              child: LoadingAnimationWidget.progressiveDots(
                                  color: lime, size: 55));
                        }
                        return offerProducts(item, context, size, index);
                      },
                    ),
                  )))),
    );
  }

  Widget offerProducts(
      RevenueIemsModel item, BuildContext context, Size size, int index) {
    bool isSizedSelected = false;
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, modalSetState) => SizedBox(
                height: size.height / 1.6,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        imageItemInshowModalBottomSheet(size, item),
                        nameItemInshowModalBottomSheet(size, item),
                        modelItemInshowModalBottomSheet(size, item),
                        const Divider(),
                        itemDescriptionInModelBottomSheet(item),
                        colorsAvailableInshowModalBottomSheet(size, item,
                            (Color select) {
                          modalSetState(
                            () {
                              item.selectedColor = select;
                              selectedColor = select;
                            },
                          );
                        }),
                        const SizedBox(height: 3),
                        if ((item.type ?? '').trim().toLowerCase() == 'bags' ||
                            (item.type ?? '').trim().toLowerCase() ==
                                'headsets')
                          Container()
                        else
                          sizeItemInshowModalBottomSheet(
                              isSizedSelected, size, item, (sizee) {
                            modalSetState(
                              () {
                                item.selectedSize = sizee;
                              },
                            );
                          }),
                        const SizedBox(height: 5),
                        countOfItemAndAddToCartOfShoesSectionInRevenueInshowModalBottomSheet(
                            size, offers.offerItems, index)
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Stack(
          children: [
            offerImage(item),
            nameAndModelOfferItem(item),
            rateAndDiscountItem(size, item),
            disIcon(size),
            if ((item.type ?? '').trim().toLowerCase() == 'bags' ||
                (item.type ?? '').trim().toLowerCase() == 't-shirts' ||
                (item.type ?? '').trim().toLowerCase() == 'pants' ||
                (item.type ?? '').trim().toLowerCase() == 'jacket' ||
                (item.type ?? '').trim().toLowerCase() == 'makeups')
              Positioned(
                  left: 6,
                  bottom: 0.1,
                  child: SizedBox(
                      child: Text('Offer Ends',
                          style: GoogleFonts.aleo(
                              color: redColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w700))))
            else
              Positioned(
                  left: 6,
                  bottom: 1,
                  child: SizedBox(
                      child: Text(
                    '${item.discount} JOD',
                  )))
          ],
        ),
      ),
    );
  }

  Padding countOfItemAndAddToCartOfShoesSectionInRevenueInshowModalBottomSheet(
      Size siz, List<RevenueIemsModel> item, int idx) {
    void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
      await offerAddToCart.saveItemsToTheCart(item[idx]);
    }

    RevenueIemsModel model = item[idx];
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

  SizedBox imageItemInshowModalBottomSheet(Size size, RevenueIemsModel item) {
    return SizedBox(
        height: size.height / 3,
        width: size.width / 1.2 + 0.72,
        child: Image.memory(fit: BoxFit.contain, base64Decode(item.imgAdress)));
  }

  SizedBox sizeItemInshowModalBottomSheet(bool isSizedSelected, Size size,
      RevenueIemsModel item, Function(String) onSizeSelected) {
    return SizedBox(
        height: size.height * 0.04,
        width: size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: item.sizes.map(
                (sizeo) {
                  final bool isSelected = sizeo == selectedSize;
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
                        onPressed: () => (sizeItem) {
                              setState(() => selectedSize = sizeItem);
                            },
                        child: Text(
                          sizeo,
                        )),
                  );
                },
              ).toList()),
        ));
  }

  SizedBox colorsAvailableInshowModalBottomSheet(
      Size size, RevenueIemsModel item, Function(Color) onColorSelected) {
    return SizedBox(
        height: size.height * 0.04,
        width: size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: item.colorsAvailable.map(
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
                        onPressed: () => (color) {
                              setState(() => selectedColor = color);
                            },
                        child: const Text(
                          '',
                        )),
                  );
                },
              ).toList()),
        ));
  }

  Padding itemDescriptionInModelBottomSheet(RevenueIemsModel item) {
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
            '${item.description}',
            style: GoogleFonts.aleo(
                color: black,
                // fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Container modelItemInshowModalBottomSheet(Size size, RevenueIemsModel item) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              item.model,
              style: GoogleFonts.aleo(
                  color: black, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                if (item.discount != null &&
                    (item.type ?? '').trim().toLowerCase() == 'headsets')
                  Row(
                    children: [
                      Stack(children: [
                        const Positioned(
                            bottom: 5,
                            left: 1,
                            child: SizedBox(child: Text('___'))),
                        Text('${item.price} JOD',
                            style: GoogleFonts.aleo(
                                color: black,
                                fontSize: 11,
                                fontWeight: FontWeight.w700)),
                      ]),
                      const SizedBox(width: 5),
                      SizedBox(
                        child: Text('${item.discount} JOD',
                            style: GoogleFonts.aleo(
                                color: redColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w900)),
                      ),
                    ],
                  )
                else
                  Text('${item.price} JOD',
                      style: GoogleFonts.aleo(
                          color: black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    5,
                    (index) {
                      int fullStars = item.rate.floor();
                      bool hasHalfStar = (item.rate - fullStars) >= 0.5;
                      if (index < fullStars) {
                        return const Icon(Icons.star,
                            color: Colors.amber, size: 18);
                      } else if (index == hasHalfStar && hasHalfStar) {
                        return const Icon(Icons.star_half,
                            color: Colors.amber, size: 18);
                      } else {
                        return const Icon(Icons.star_border,
                            color: Colors.amber, size: 18);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container nameItemInshowModalBottomSheet(Size size, RevenueIemsModel item) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      width: size.width / 1,
      child: Text(
        item.name,
        style: GoogleFonts.aleo(
            color: black, fontSize: 28, fontWeight: FontWeight.w600),
      ),
    );
  }

  /* SizedBox imageItemInshowModalBottomSheet(Size size, RevenueIemsModel item) {
    return SizedBox(
        height: size.height / 3,
        width: size.width / 1.2 + 0.72,
        child: Image.memory(fit: BoxFit.contain, base64Decode(item.imgAdress)));
  } */

  Positioned disIcon(Size size) {
    return Positioned(
      left: size.width / 2.64,
      top: 1,
      child: const SizedBox(
        child: Icon(
          Iconsax.receipt_disscount5,
          color: redColor,
          size: 30,
        ),
      ),
    );
  }

  Widget rateAndDiscountItem(Size size, RevenueIemsModel model) {
    // print("Rate for item: ${model.model}");
    int fullStars = model.rate.floor();
    bool hasHalfStar = (model.rate - fullStars) >= 0.5;
    return Positioned(
        top: size.height / 4.27,
        left: size.width * 0.01,
        child: Row(
          children: [
            Stack(
              children: [
                if ((model.type ?? '').trim().toLowerCase() == 'bags' ||
                    (model.type ?? '').trim().toLowerCase() == 't-shirts' ||
                    (model.type ?? '').trim().toLowerCase() == 'pants' ||
                    (model.type ?? '').trim().toLowerCase() == 'jacket' ||
                    (model.type ?? '').trim().toLowerCase() == 'makeups')
                  Text('${model.price} JOD',
                      style: GoogleFonts.aleo(
                          color: black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700))
                else
                  const Positioned(
                      bottom: 6, left: 1, child: SizedBox(child: Text('___'))),
                Text('${model.price} JOD',
                    style: GoogleFonts.aleo(
                        color: black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) {
                  if (index < fullStars) {
                    return const Icon(Icons.star,
                        color: Colors.amber, size: 18);
                  } else if (index == hasHalfStar && hasHalfStar) {
                    return const Icon(Icons.star_half,
                        color: Colors.amber, size: 18);
                  } else {
                    return const Icon(Icons.star_border,
                        color: Colors.amber, size: 18);
                  }
                },
              ),
            ),
          ],
        ));
  }

  Positioned nameAndModelOfferItem(RevenueIemsModel item) {
    return Positioned(
      top: 200,
      left: 10,
      child: Row(
        children: [
          Text(item.name,
              style: GoogleFonts.aleo(
                  color: black, fontSize: 15, fontWeight: FontWeight.w800)),
          const SizedBox(width: 2),
          Text(item.model,
              style: GoogleFonts.aleo(
                  color: black, fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Center offerImage(RevenueIemsModel item) {
    return Center(
        child: Image.memory(base64Decode(item.imgAdress), fit: BoxFit.cover));
  }
}

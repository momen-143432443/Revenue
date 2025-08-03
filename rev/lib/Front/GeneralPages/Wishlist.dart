import 'dart:convert';
import 'package:css/Backend/Controllers/ForProductControllers/MoreSectionController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart' as getX;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moreSec = getX.Get.put(MoreSectionController());
    final userData = getX.Get.put(ProfileController());

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 20,
        animSpeedFactor: 20,
        height: 35,
        showChildOpacityTransition: false,
        backgroundColor: white,
        color: greenColor,
        onRefresh: () async => moreSec.moreItems,
        child: Center(
          child:
              WsihListWidget(size: size, moreSec: moreSec, userData: userData),
        ),
      )),
    );
  }
}

class WsihListWidget extends StatelessWidget {
  const WsihListWidget({
    super.key,
    required this.size,
    required this.moreSec,
    required this.userData,
  });

  final Size size;
  final MoreSectionController moreSec;
  final ProfileController userData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        wishlistAndEmptyWishlistTexts(),
        moreSectionMethod(size),
      ],
    );
  }

  Expanded moreSectionMethod(Size size) {
    return Expanded(
      child: SizedBox(
        child: getX.Obx(() => GridView.builder(
              itemCount: moreSec.moreItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = moreSec.items[index];
                final user = userData.user.value;
                if (user.email == null || user.email!.isEmpty) {
                  return Center(
                      child: LoadingAnimationWidget.progressiveDots(
                          color: lime, size: 55));
                }
                return Container(
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
                      imageMethod(item),
                      itemNameAndModelMethod(item),
                      itemPriceMethod(item),
                      rateItemInshowModalBottomSheet(size, item)
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }

  Widget rateItemInshowModalBottomSheet(Size size, RevenueIemsModel model) {
    // print("Rate for item: ${model.model}");
    int fullStars = model.rate.floor();
    bool hasHalfStar = (model.rate - fullStars) >= 0.5;
    return Positioned(
      top: size.height / 3.97,
      right: size.width * 0.21,
      child: SizedBox(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          5,
          (index) {
            if (index < fullStars) {
              return const Icon(Icons.star, color: Colors.amber, size: 18);
            } else if (index == hasHalfStar && hasHalfStar) {
              return const Icon(Icons.star_half, color: Colors.amber, size: 18);
            } else {
              return const Icon(Icons.star_border,
                  color: Colors.amber, size: 18);
            }
          },
        ),
      )),
    );
  }

  Positioned itemPriceMethod(RevenueIemsModel item) {
    return Positioned(
      top: 220,
      left: 10,
      child: Text('${item.price} JOD',
          style: GoogleFonts.aleo(
              color: black, fontSize: 13, fontWeight: FontWeight.w700)),
    );
  }

  Positioned itemNameAndModelMethod(RevenueIemsModel item) {
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

  Image imageMethod(RevenueIemsModel item) {
    return Image.memory(base64Decode(item.imgAdress), fit: BoxFit.contain);
  }

  Column wishlistAndEmptyWishlistTexts() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(right: size.width / 1.7),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Text(
              "Wishlist",
              style: GoogleFonts.aleo(
                  color: black, fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => getX.Get.back(result: getX.Transition.rightToLeft),
          child: SizedBox(
            height: size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Iconsax.heart,
                  size: 55,
                ),
                Text(
                  "Wishlist Empty.",
                  style: GoogleFonts.aleo(
                      color: black,
                      // fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 43,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: size.width / 1.50),
          child: Text(
            "Shop Now!",
            style: GoogleFonts.aleo(color: black, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

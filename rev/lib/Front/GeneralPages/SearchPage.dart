import 'dart:convert';

import 'package:css/Backend/Controllers/ForProductControllers/SearchBarController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final SearchbarController searchControl = Get.put(SearchbarController());
final userData = Get.put(ProfileController());

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = userData.user.value;
      if (user.email == null || user.email!.isEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 400),
          child: Center(
              child: LoadingAnimationWidget.progressiveDots(
                  color: lime, size: 55)),
        );
      }
      return Scaffold(
        backgroundColor: white,
        appBar: searchForItems(),
        body: SafeArea(child: SingleChildScrollView(
          child: Center(child: Obx(() {
            final query = searchControl.searchController.value.text;
            final results = searchControl.filteredItems;
            // if (query.isEmpty) {
            //   return const EmptyState();
            // }
            // if (results.isEmpty) {
            //   // You can return a “No results found” widget, or just empty Container
            //   return const Center(child: Text("No results"));
            // }

            return query.isEmpty
                ? const EmptyState()
                : SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(lightGrey)),
                                  onPressed: () {},
                                  child: Text(
                                    'Shoes',
                                    style: GoogleFonts.aleo(
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  )),
                              TextButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(lightGrey)),
                                  onPressed: () {},
                                  child: Text(
                                    'T-Shirts',
                                    style: GoogleFonts.aleo(
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  )),
                              TextButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(lightGrey)),
                                  onPressed: () {},
                                  child: Text(
                                    'Pants',
                                    style: GoogleFonts.aleo(
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  )),
                              TextButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(lightGrey)),
                                  onPressed: () {},
                                  child: Text(
                                    'Mouses',
                                    style: GoogleFonts.aleo(
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(lightGrey)),
                                  onPressed: () {},
                                  child: Text(
                                    'Dresses',
                                    style: GoogleFonts.aleo(
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  )),
                              TextButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(lightGrey)),
                                  onPressed: () {},
                                  child: Text(
                                    'Hats',
                                    style: GoogleFonts.aleo(
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  )),
                              TextButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(lightGrey)),
                                  onPressed: () {},
                                  child: Text(
                                    'Monitors',
                                    style: GoogleFonts.aleo(
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ],
                          ),
                        ),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final item = results[index];
                            return fetchingItems(item);
                          },
                        ),
                      ],
                    ),
                  );
          })),
        )),
      );
    });
  }

  SizedBox fetchingItems(SearchItemModel item) {
    final siz = MediaQuery.of(context).size;
    return SizedBox(
      child: ListTile(
        leading: item.imgAdress.isNotEmpty
            ? Image.memory(
                base64Decode(item.imgAdress),
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image_not_supported),
        title: Text(item.name),
        subtitle: Text(item.model),
        trailing: Text('${item.price} JOD'),
      ),
    );
    // return GestureDetector(
    //   onTap: () => setState(() {
    //     SizedBox sizedBoxBewtweenTriggers = const SizedBox(width: 5);
    //     bool isInCart = itemsInBag.contains(item);
    //     showModalBottomSheet(
    //       isScrollControlled: true,
    //       backgroundColor: white,
    //       enableDrag: true,
    //       context: context,
    //       builder: (context) {
    //         return SizedBox(
    //           height: siz.height / 1.2,
    //           child: Column(
    //             children: [
    //               nameItemInshowModalBottomSheet(item),
    //               imageItemInshowModalBottomSheet(siz, item),
    //               modelItemInshowModalBottomSheet(item),
    //               rateItemInshowModalBottomSheet(siz, item),
    //               colorsAvailableInshowModalBottomSheet(
    //                   sizedBoxBewtweenTriggers, item),
    //               sizeItemInshowModalBottomSheet(siz, item),
    //               countOfItemAndAddToCartOfMostTrindingItemsInshowModalBottomSheet(
    //                   isInCart, siz, index)
    //             ],
    //           ),
    //         );
    //       },
    //     );
    //   }),
    //   child: ListTile(
    //     leading: Image(image: AssetImage(item.imgAdress)),
    //     title: Text(item.name),
    //     subtitle: Text(item.model),
    //     trailing: Text('${item.price} JOD'),
    //   ),
    // );
  }

  // Padding countOfItemAndAddToCartOfMostTrindingItemsInshowModalBottomSheet(
  //     bool isInCart, Size siz, int idx) {
  //   void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
  //     await cartController.saveItemsToTheCart(searchControl.filteredItems[idx]);
  //   }

  //   return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 40),
  //       child: Center(
  //         child: isInCart
  //             ? Container(
  //                 margin: const EdgeInsets.only(bottom: 5),
  //                 width: siz.width / 4,
  //                 height: siz.height / 23,
  //                 decoration: BoxDecoration(
  //                     color: greenColor,
  //                     borderRadius: BorderRadius.circular(10)),
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 10),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         'Added !',
  //                         style: GoogleFonts.aleo(
  //                             color: white,
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       Text(
  //                         '✔️',
  //                         style: GoogleFonts.aleo(
  //                             color: white,
  //                             fontSize: 13,
  //                             fontWeight: FontWeight.w600),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             : Container(
  //                 decoration: BoxDecoration(
  //                     color: blueColor,
  //                     borderRadius: BorderRadius.circular(10)),
  //                 child: ElevatedButton.icon(
  //                   style: const ButtonStyle(
  //                       backgroundColor:
  //                           WidgetStatePropertyAll(Colors.transparent),
  //                       shadowColor:
  //                           WidgetStatePropertyAll(Colors.transparent)),
  //                   onPressed: () async =>
  //                       toggleAddToCartFrommostTrendingInShowModalBottomSheet(),
  //                   label: Text(
  //                     'Add to your cart',
  //                     style: GoogleFonts.aleo(
  //                         color: white,
  //                         fontSize: 13,
  //                         fontWeight: FontWeight.w600),
  //                   ),
  //                   icon: const Icon(
  //                     Iconsax.shopping_cart,
  //                     color: white,
  //                   ),
  //                 ),
  //               ),
  //       ));
  // }

  Container sizeItemInshowModalBottomSheet(Size siz, RevenueIemsModel item) {
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
          itemCount: item.sizes.length,
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
                  children: item.sizes.map<Widget>((size) {
                    return SizedBox(
                      height: siz.height / 10,
                      width: siz.width / 5,
                      child: SizedBox(
                        width: siz.width / 13,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: item.selectedSize,
                            hint: Text(
                              "Size",
                              style: GoogleFonts.aleo(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.w600),
                            ),
                            isExpanded: true,
                            items: item.sizes
                                .map<DropdownMenuItem<String>>((size) {
                              return DropdownMenuItem<String>(
                                value: size,
                                child: Text(size.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                item.selectedSize = size;
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

  Container colorsAvailableInshowModalBottomSheet(
      SizedBox sizedBoxBewtweenTriggers, RevenueIemsModel item) {
    final siz = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(left: 240),
        height: siz.height * 0.03,
        width: siz.width / 3.2,
        child: SizedBox(
            width: sizedBoxBewtweenTriggers.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: item.colorsAvailable.map(
                  (color) {
                    final isSelected = item.selectedColor == color;
                    return GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          item.selectedColor = color;
                          print("Color Choosen:${item.selectedColor}");
                        } else if (!isSelected) {
                          setState(() {
                            print(
                                "Color not Choosen:${item.selectedColor = item.itemColor}");
                            item.selectedColor = item.itemColor;
                          });
                        }
                      },
                      child: Container(
                        width: siz.width / 14,
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

  SizedBox rateItemInshowModalBottomSheet(Size siz, RevenueIemsModel item) {
    return SizedBox(
      width: siz.width / 1.2,
      height: 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: item.rate?.length,
        itemBuilder: (context, rateIndex) {
          return Container(child: item.rate?[rateIndex]);
        },
      ),
    );
  }

  Padding modelItemInshowModalBottomSheet(RevenueIemsModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Text(
              item.model,
              style: GoogleFonts.aleo(
                  color: black, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          ///////////////////////////////////////
          ////////////[Price of item]////////////
          ///////////////////////////////////////
          SizedBox(
            child: Text(
              '${item.price} JOD',
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

  SizedBox imageItemInshowModalBottomSheet(Size siz, RevenueIemsModel item) {
    return SizedBox(
      ///////////////////////////////////////
      ////////////[Image of item]////////////
      ///////////////////////////////////////
      height: siz.height / 2,
      width: siz.width / 1.2 + 0.72,
      child: Image(image: AssetImage(item.imgAdress)),
    );
  }

  Center nameItemInshowModalBottomSheet(RevenueIemsModel item) {
    return Center(
      child: Text(
        item.name,
        style: GoogleFonts.aleo(
            color: black, fontSize: 31, fontWeight: FontWeight.w600),
      ),
    );
  }

  AppBar searchForItems() {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: white,
      shadowColor: white,
      backgroundColor: white,
      toolbarHeight: 45,
      elevation: 0,
      title: CupertinoSearchTextField(
        controller: searchControl.searchController.value,
        // onChanged: (value) => searchControl.filtersItems(value),
        cursorColor: black,
      ),
    );
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
            "No Product Search",
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

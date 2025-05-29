import 'package:css/Backend/Controllers/ForProductControllers/SearchBarController.dart';
import 'package:css/Backend/Controllers/ForUserControllers/ProfileController.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Backend/RevenueItems/RevData.dart';
import 'package:css/Front/Functions/AppMethods.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final searchControl = Get.put(SearchbarController());
final userData = Get.put(ProfileController());
final cartController = Get.put(AppMethods());

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: searchForItems(),
      body: SafeArea(child: SingleChildScrollView(
        child: Center(child: Obx(() {
          final user = userData.user.value;
          final isEmpty = searchControl.searchController.value.text.isEmpty;
          if (user.email == null || user.email!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 400),
              child: Center(
                  child: LoadingAnimationWidget.progressiveDots(
                      color: lime, size: 55)),
            );
          }
          return isEmpty
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchControl.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = searchControl.filteredItems[index];
                    return fetchingItems(item, index);
                  },
                );
        })),
      )),
    );
  }

  GestureDetector fetchingItems(RevenueIemsModel item, int index) {
    final siz = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => setState(() {
        SizedBox sizedBoxBewtweenTriggers = const SizedBox(width: 5);
        bool isInCart = itemsInBag.contains(item);
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: white,
          enableDrag: true,
          context: context,
          builder: (context) {
            return SizedBox(
              height: siz.height / 1.2,
              child: Column(
                children: [
                  nameItemInshowModalBottomSheet(item),
                  imageItemInshowModalBottomSheet(siz, item),
                  modelItemInshowModalBottomSheet(item),
                  rateItemInshowModalBottomSheet(siz, item),
                  colorsAvailableInshowModalBottomSheet(
                      sizedBoxBewtweenTriggers, item),
                  sizeItemInshowModalBottomSheet(siz, item),
                  countOfItemAndAddToCartOfMostTrindingItemsInshowModalBottomSheet(
                      isInCart, siz, index)
                ],
              ),
            );
          },
        );
      }),
      child: ListTile(
        leading: Image(image: AssetImage(item.imgAdress)),
        title: Text(item.name),
        subtitle: Text(item.model),
        trailing: Text('${item.price} JOD'),
      ),
    );
  }

  Padding countOfItemAndAddToCartOfMostTrindingItemsInshowModalBottomSheet(
      bool isInCart, Size siz, int idx) {
    void toggleAddToCartFrommostTrendingInShowModalBottomSheet() async {
      await cartController.saveItemsToTheCart(searchControl.allItems[idx]);
    }

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
                    onPressed: () async =>
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
        itemCount: item.rate.length,
        itemBuilder: (context, rateIndex) {
          return Container(child: item.rate[rateIndex]);
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
        onChanged: (value) => setState(() {
          searchControl.filtersItems(value);
        }),
        cursorColor: black,
      ),
    );
  }
}

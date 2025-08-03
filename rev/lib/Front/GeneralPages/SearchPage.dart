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
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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
    final query = searchControl.searchController.value.text;
    return Scaffold(
      backgroundColor: white,
      appBar: searchForItems(),
      body: SafeArea(
        child: LiquidPullToRefresh(
          springAnimationDurationInMilliseconds: 20,
          animSpeedFactor: 20,
          height: 35,
          showChildOpacityTransition: false,
          backgroundColor: white,
          color: greenColor,
          onRefresh: () async {
            await searchControl.filtersItems(searchControl.query.value);
          },
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Center(
                child: Column(
              children: [
                Column(
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
                                    fontSize: 12,
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
                                    fontSize: 12,
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
                                    fontSize: 12,
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
                                    fontSize: 12,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(),
                query.isEmpty
                    ? const EmptyState()
                    : Obx(() => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchControl.filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = searchControl.filteredItems[index];
                            return fetchingItems(item);
                          },
                        ))
              ],
            )),
          ),
        ),
      ),
    );
  }

  SizedBox fetchingItems(SearchItemModel item) {
    // final siz = MediaQuery.of(context).size;
    return SizedBox(
      child: ListTile(
        leading: item.imgAdress.isNotEmpty
            ? Image.memory(
                base64Decode(item.imgAdress),
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image_not_supported),
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(item.model), rateItemInshowModalBottomSheet(item)],
        ),
        trailing: Text('${item.price} JOD'),
      ),
    );
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

  Widget rateItemInshowModalBottomSheet(SearchItemModel model) {
    print("Rate for item: ${model.rate}");
    int fullStars = model.rate.floor();
    bool hasHalfStar = (model.rate - fullStars) >= 0.5;
    return SizedBox(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          if (index < fullStars) {
            return const Icon(Icons.star, color: Colors.amber, size: 10);
          } else if (index == hasHalfStar && hasHalfStar) {
            return const Icon(Icons.star_half, color: Colors.amber, size: 10);
          } else {
            return const Icon(Icons.star_border, color: Colors.amber, size: 10);
          }
        },
      ),
    ));
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
        controller: searchControl.searchController,
        onChanged: (value) {
          setState(() {
            print('Item Searched : $value');
            searchControl.onQueryChanged(value);
          });
        },
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
          const Stack(children: [
            Positioned(
              top: 9,
              left: 9.5,
              child: Icon(
                Iconsax.bag_2,
                size: 13,
              ),
            ),
            Icon(
              Icons.search,
              size: 40,
            ),
          ])
        ],
      ),
    );
  }
}

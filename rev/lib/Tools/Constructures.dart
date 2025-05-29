import 'dart:convert';
import 'dart:typed_data';

import 'package:css/Backend/Blocs/FetchCartItemsBloc/FetchNameAndPictureEvent.dart';
import 'package:css/Backend/Controllers/ForProductControllers/ShowAllItems.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:css/Backend/RevenueItems/RevData.dart';
import 'package:css/Tools/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ItemImageList extends StatelessWidget {
  final double width, height, top, right;
  final String imgAdress;
  final Color? overLayout;
  final Color? backgroundColor;
  const ItemImageList(
      {super.key,
      this.overLayout,
      this.backgroundColor,
      this.height = 230,
      this.width = 200,
      this.right = 60,
      this.top = 60,
      required this.imgAdress});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Image(image: AssetImage(imgAdress)),
        ),
      ),
    );
  }
}

class ItemImageMemory extends StatelessWidget {
  final double width, height, top, right;
  final String imgAdress;
  final Color? overLayout;
  final Color? backgroundColor;
  const ItemImageMemory(
      {super.key,
      this.overLayout,
      this.backgroundColor,
      this.height = 230,
      this.width = 200,
      this.right = 60,
      this.top = 60,
      required this.imgAdress});
  @override
  Widget build(BuildContext con) {
    print("Rendering image, base64: ${imgAdress.substring(0, 30)}...");

    if (imgAdress.isEmpty || imgAdress.length < 100) {
      return const Icon(Icons.image_not_supported);
    }

    try {
      Uint8List imageBytes = base64Decode(
        imgAdress.contains(',') ? imgAdress.split(',').last : imgAdress,
      );
      return Positioned(
        top: top,
        right: right,
        child: SizedBox(
            width: width,
            height: height,
            child: Image.memory(base64Decode(imgAdress))),
      );
    } catch (e) {
      print("Base64 decode failed: $e");
      return const Icon(Icons.error);
    }
  }
}

class ContainerOfFetchingMostTrindingItems extends StatelessWidget {
  final double? horizontal, vertical, decoration;
  final int? price, idx;
  final Color itemColor;
  final String imgAdress, name, model;
  final TextStyle? textStyle;
  final bool liked;
  const ContainerOfFetchingMostTrindingItems({
    this.horizontal,
    this.vertical,
    this.textStyle,
    this.decoration,
    required this.imgAdress,
    required this.name,
    required this.model,
    required this.itemColor,
    required this.price,
    this.idx,
    required this.liked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = Get.put(ShowAllItems());

    // Uint8List imageBytes = base64Decode(imgAdress);
    final siz = MediaQuery.of(context).size;
    final effectiveHoriaontal = horizontal ?? siz.height * 0.005;
    final effectVertical = vertical ?? siz.height * 0.01;
    final textStyleEffect = textStyle ??
        GoogleFonts.aleo(
            color: black, fontSize: 21, fontWeight: FontWeight.w600);
    final textStyleEffect2 = textStyle ??
        GoogleFonts.aleo(
            fontSize: 13, fontWeight: FontWeight.w600, color: black);
    return BlocProvider(
      create: (_) =>
          MostTrindingCubit()..setInitialMosttrindingItems(items.items),
      child: BlocBuilder<MostTrindingCubit, List<RevenueIemsModel>>(
          builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: effectiveHoriaontal, vertical: effectVertical),
          width: siz.width / 1.5,
          child: Stack(
            children: [
              Container(
                width: siz.width / 1.81,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: itemColor,
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Positioned(
                top: 5,
                left: 20,
                child: Column(
                  children: [
                    Text(name, style: textStyleEffect),
                    Text('$price JOD', style: textStyleEffect),
                  ],
                ),
              ),
              // Image.memory(imageBytes, fit: BoxFit.cover),
              ItemImageMemory(imgAdress: imgAdress),
              Positioned(
                  top: 300,
                  child: Text(
                    model,
                    style: textStyleEffect2,
                  )),
              Positioned(
                top: 330,
                left: 180,
                child: IconButton(
                    onPressed: () => context
                        .read<MostTrindingCubit>()
                        .toggleLikeFrommostTrending(idx!),
                    icon: Icon(Iconsax.heart,
                        size: 40, color: liked ? redColor : black)),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ContainerOfFetchingFeaturesItems extends StatelessWidget {
  final double? horizontal, vertical, decoration;
  final int? price, idx;
  final Color itemColor;
  final String imgAdress, name, model;
  final TextStyle? textStyle;
  final bool liked;
  const ContainerOfFetchingFeaturesItems({
    this.horizontal,
    this.vertical,
    this.textStyle,
    this.decoration,
    required this.imgAdress,
    required this.name,
    required this.model,
    required this.itemColor,
    required this.price,
    this.idx,
    required this.liked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final siz = MediaQuery.of(context).size;
    final effectiveHoriaontal = horizontal ?? siz.height * 0.005;
    final effectVertical = vertical ?? siz.height * 0.01;
    final textStyleEffect = textStyle ??
        GoogleFonts.aleo(
            color: black, fontSize: 21, fontWeight: FontWeight.w600);
    final textStyleEffect2 = textStyle ??
        GoogleFonts.aleo(
            fontSize: 13, fontWeight: FontWeight.w600, color: black);
    return BlocProvider(
      create: (_) =>
          MostTrindingCubit()..setInitialMosttrindingItems(itemsFeatures),
      child: BlocBuilder<MostTrindingCubit, List<RevenueIemsModel>>(
        builder: (context, state) => Container(
          margin: EdgeInsets.symmetric(
              horizontal: effectiveHoriaontal, vertical: effectVertical),
          width: siz.width / 1.5,
          child: Stack(
            children: [
              Container(
                width: siz.width / 1.81,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: itemColor,
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Positioned(
                top: 5,
                left: 20,
                child: Column(
                  children: [
                    Text(name, style: textStyleEffect),
                    Text('$price JOD', style: textStyleEffect),
                  ],
                ),
              ),
              ItemImageList(imgAdress: imgAdress),
              Positioned(
                  top: 300,
                  child: Text(
                    model,
                    style: textStyleEffect2,
                  )),
              Positioned(
                top: 330,
                left: 180,
                child: IconButton(
                    onPressed: () => context
                        .read<MostTrindingCubit>()
                        .toggleLikeFrommostTrending(idx!),
                    icon: Icon(Iconsax.heart,
                        size: 40, color: liked ? redColor : black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerOfFetchingNewItemsInRevenueItems extends StatelessWidget {
  final double? horizontal, vertical, decoration;
  final int? price, idx;
  final Color itemColor;
  final String imgAdress, name, model;
  final TextStyle? textStyle;
  final bool liked;
  const ContainerOfFetchingNewItemsInRevenueItems({
    this.horizontal,
    this.vertical,
    this.textStyle,
    this.decoration,
    required this.imgAdress,
    required this.name,
    required this.model,
    required this.itemColor,
    required this.price,
    this.idx,
    required this.liked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final siz = MediaQuery.of(context).size;
    final effectiveHoriaontal = horizontal ?? siz.height * 0.005;
    final effectVertical = vertical ?? siz.height * 0.01;
    final textStyleEffect = textStyle ??
        GoogleFonts.aleo(
            color: black, fontSize: 21, fontWeight: FontWeight.w600);
    final textStyleEffect2 = textStyle ??
        GoogleFonts.aleo(
            fontSize: 13, fontWeight: FontWeight.w600, color: black);
    return BlocProvider(
      create: (_) =>
          MostTrindingCubit()..setInitialMosttrindingItems(newItemsOfRev),
      child: BlocBuilder<MostTrindingCubit, List<RevenueIemsModel>>(
        builder: (context, state) => Container(
          margin: EdgeInsets.symmetric(
              horizontal: effectiveHoriaontal, vertical: effectVertical),
          width: siz.width / 1.5,
          child: Stack(
            children: [
              Container(
                width: siz.width / 1.81,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: itemColor,
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Positioned(
                top: 5,
                left: 20,
                child: Column(
                  children: [
                    Text(name, style: textStyleEffect),
                    Text('$price JOD', style: textStyleEffect),
                  ],
                ),
              ),
              ItemImageList(imgAdress: imgAdress),
              Positioned(
                  top: 300,
                  child: Text(
                    model,
                    style: textStyleEffect2,
                  )),
              Positioned(
                top: 330,
                left: 180,
                child: IconButton(
                    onPressed: () => context
                        .read<MostTrindingCubit>()
                        .toggleLikeFrommostTrending(idx!),
                    icon: Icon(Iconsax.heart,
                        size: 40, color: liked ? redColor : black)),
              ),
              Positioned(
                  left: 178,
                  top: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(3)),
                    width: siz.width * 0.12,
                    child: Text(
                      "  New",
                      style: GoogleFonts.aleo(
                          color: white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerOfFetchingShoeSectionInRevenueItems extends StatelessWidget {
  final double? horizontal, vertical, decoration;
  final int? price, idx;
  final Color itemColor;
  final String imgAdress, name, model;
  final TextStyle? textStyle;
  final bool liked;
  const ContainerOfFetchingShoeSectionInRevenueItems({
    this.horizontal,
    this.vertical,
    this.textStyle,
    this.decoration,
    required this.imgAdress,
    required this.name,
    required this.model,
    required this.itemColor,
    required this.price,
    this.idx,
    required this.liked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final siz = MediaQuery.of(context).size;
    final effectiveHoriaontal = horizontal ?? siz.height * 0.005;
    final effectVertical = vertical ?? siz.height * 0.01;
    final textStyleEffect = textStyle ??
        GoogleFonts.aleo(
            color: black, fontSize: 21, fontWeight: FontWeight.w600);
    final textStyleEffect2 = textStyle ??
        GoogleFonts.aleo(
            fontSize: 13, fontWeight: FontWeight.w600, color: black);
    return BlocProvider(
      create: (_) =>
          MostTrindingCubit()..setInitialMosttrindingItems(newItemsOfRev),
      child: BlocBuilder<MostTrindingCubit, List<RevenueIemsModel>>(
        builder: (context, state) => Container(
          margin: EdgeInsets.symmetric(
              horizontal: effectiveHoriaontal, vertical: effectVertical),
          width: siz.width / 1.5,
          child: Stack(
            children: [
              Container(
                width: siz.width / 1.81,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: itemColor,
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Positioned(
                top: 5,
                left: 20,
                child: Column(
                  children: [
                    Text(name, style: textStyleEffect),
                    Text('$price JOD', style: textStyleEffect),
                  ],
                ),
              ),
              ItemImageMemory(imgAdress: imgAdress),
              Positioned(
                  top: 300,
                  child: Text(
                    model,
                    style: textStyleEffect2,
                  )),
              Positioned(
                top: 330,
                left: 180,
                child: IconButton(
                    onPressed: () => context
                        .read<MostTrindingCubit>()
                        .toggleLikeFrommostTrending(idx!),
                    icon: Icon(Iconsax.heart,
                        size: 40, color: liked ? redColor : black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

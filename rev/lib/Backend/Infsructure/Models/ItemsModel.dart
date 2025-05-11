import 'package:css/Front/Functions/AppMethods.dart';
import 'package:flutter/material.dart';

class RevenueIemsModel {
  String id;
  String name;
  String model;
  int price;
  String imgAdress;
  Color itemColor;
  bool liked;
  bool addToCart;
  List<Color> colorsAvailable;
  List<Icon> rate;
  List sizes;
  int countOfItem;
  List deliverCompanies;
  Color? selectedColor;
  String? selectedSize;
  String? totalOfOrder;

  RevenueIemsModel({
    this.selectedSize,
    required this.id,
    required this.name,
    required this.addToCart,
    required this.model,
    required this.price,
    required this.imgAdress,
    required this.itemColor,
    required this.liked,
    required this.colorsAvailable,
    required this.rate,
    required this.sizes,
    required this.countOfItem,
    required this.deliverCompanies,
  });

  Map<String, dynamic> toCartJson() => {
        "itemId": id,
        "itemName": name,
        "itemModel": model,
        "itemPrice": price,
        "itemPicture": imgAdress,
        "itemColor": selectedColor != null ? [colorToHex(selectedColor!)] : '',
        "itemSize": sizes.isNotEmpty ? sizes.first : 'Out Of Stock',
        "itemColorAvailable":
            colorsAvailable.map((e) => colorToHex(e)).toList(),
        "itemCount": countOfItem
      };

  Map<String, dynamic> fromCartJsonToMongoDbDatabase() => {
        "itemId": id,
        "itemName": name,
        "itemModel": model,
        "itemPrice": price,
        "itemImageAddress": imgAdress,
        "itemColor": selectedColor != null ? [colorToHex(selectedColor!)] : '',
        "itemSize": selectedSize ?? 'Out Of Stock',
        "itemCount": countOfItem
      };

  static RevenueIemsModel cartEmpty() {
    return RevenueIemsModel(
        id: '',
        name: '',
        addToCart: false,
        model: '',
        price: 0,
        imgAdress: '',
        itemColor: Colors.transparent,
        liked: false,
        colorsAvailable: [],
        rate: [],
        sizes: [],
        countOfItem: 0,
        deliverCompanies: []);
  }

  factory RevenueIemsModel.fromMap(Map<String, dynamic> map) {
    // Parse color safely
    Color parseColor(String hex) {
      try {
        return Color(int.parse(hex.replaceFirst('#', '0xff')));
      } catch (_) {
        return Colors.grey;
      }
    }

    // Parse icons safely (you might want to use real ratings later)
    List<Icon> parseRate(dynamic rawList) {
      if (rawList is List) {
        return rawList.map<Icon>((e) => const Icon(Icons.star)).toList();
      }
      return [];
    }

    return RevenueIemsModel(
      id: map['itemId'] ?? '',
      name: map['itemName'] ?? '',
      model: map['itemModel'] ?? '',
      price: (map['itemPrice'] is int)
          ? map['itemPrice']
          : int.tryParse(map['itemPrice'].toString()) ?? '',
      imgAdress: map['itemPicture'] ?? '',
      itemColor: () {
        final rawColor = map['itemColor'];
        if (rawColor is List && rawColor.isNotEmpty && rawColor[0] is String) {
          return parseColor(rawColor[0]);
        }
        return Colors.grey;
      }(),
      sizes: map['itemSize'] is List ? map['itemSize'] : [],
      selectedSize: map["itemSize"] ?? 'N/A',
      colorsAvailable: (map['itemColorAvailable'] as List<dynamic>?)
              ?.map((hex) =>
                  Color(int.parse(hex.toString().replaceFirst('#', '0xff'))))
              .toList() ??
          [],
      countOfItem: map['itemCount'] is int
          ? map['itemCount']
          : int.tryParse(map['itemCount'].toString()) ?? 1,
      addToCart: map['itemAddToCart'] ?? false,
      liked: map['itemLikes'] ?? false,
      rate: parseRate(map['itemRate']),
      deliverCompanies:
          map["Deliver Companies"] is List ? map["Deliver Companies"] : [],
    );
  }
}

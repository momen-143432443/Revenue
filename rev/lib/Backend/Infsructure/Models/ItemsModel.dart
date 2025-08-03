import 'package:css/Front/Functions/AppMethods.dart';
import 'package:flutter/material.dart';

class RevenueIemsModel {
  final String id;
  final String name;
  final String model;
  final int price;
  final String imgAdress;
  final Color itemColor;
  final String? companies;
  final String? type;
  final String? description;
  bool liked;
  final bool addToCart;
  List<Color> colorsAvailable;
  double rate;
  final int? discount;
  final List<String> sizes;
  int countOfItem;
  List<String> deliverCompanies;
  Color? selectedColor;
  String? selectedSize;
  String? selectedDeliverCompany;
  String? totalOfOrder;

  RevenueIemsModel({
    this.selectedSize,
    required this.id,
    required this.name,
    required this.addToCart,
    required this.model,
    required this.price,
    required this.type,
    required this.description,
    this.companies,
    this.discount,
    required this.imgAdress,
    required this.itemColor,
    required this.liked,
    required this.colorsAvailable,
    required this.rate,
    required this.sizes,
    required this.countOfItem,
    required this.deliverCompanies,
  });
  RevenueIemsModel copyWith({
    String? selectedSize,
    Color? selectedColor,
  }) {
    return RevenueIemsModel(
      id: id,
      name: name,
      addToCart: addToCart,
      model: model,
      price: price,
      type: type,
      description: description,
      companies: companies,
      discount: discount,
      imgAdress: imgAdress,
      itemColor: itemColor,
      liked: liked,
      colorsAvailable: [...colorsAvailable],
      rate: rate,
      sizes: [...sizes],
      countOfItem: countOfItem,
      deliverCompanies: [...deliverCompanies],
    )
      ..selectedSize = selectedSize ?? this.selectedSize
      ..selectedColor = selectedColor ?? this.selectedColor;
  }

  Map<String, dynamic> toCartJson() => {
        "itemId": id,
        "itemName": name,
        "itemModel": model,
        "itemPrice": price,
        "itemPicture": imgAdress,
        "itemColor": selectedColor != null
            ? [colorToHex(selectedColor!)]
            : 'No Color Selected',
        "itemSize": selectedSize ?? '',
        // "itemColorAvailable":
        //     colorsAvailable.map((e) => colorToHex(e)).toList(),
        "itemCount": countOfItem
      };
  Map<String, dynamic> fromCartJsonToMongoDbDatabase() {
    /* print('Res Of Items Colors');
    print(colorToHex(itemColor)); */
    return {
      "itemId": id,
      "itemName": name,
      "itemModel": model,
      "itemPrice": price,
      "itemImageAddress": imgAdress,
      "itemColor": colorToHex(itemColor),
      "itemSize": selectedSize ?? '',
      "itemCount": countOfItem
    };
  }

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
        rate: 0,
        sizes: [],
        companies: '',
        countOfItem: 0,
        deliverCompanies: [],
        type: '',
        description: '');
  }
  ///////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  factory RevenueIemsModel.fromMap(Map<String, dynamic> map) {
    // print("FROM FIREBASE: ${map['itemColor']}");
    // Parse color safely

    List<Color> parsedColors = [];
    final colorList = map['itemColor'];
    if (colorList is List) {
      try {
        parsedColors = colorList.map((hex) {
          final cleanHex = hex.toString().replaceAll('#', '').padLeft(6, '0');
          return Color(int.parse('0xFF$cleanHex'));
        }).toList();
      } catch (e) {
        print("Color parsing failed: $e");
      }
    }

    return RevenueIemsModel(
        companies: map['deliverCompant'] ?? '',
        id: map['itemId'].toString(),
        name: map['itemName'] ?? '',
        model: map['itemModel'] ?? '',
        price: (map['itemPrice'] is int)
            ? map['itemPrice']
            : int.tryParse(map['itemPrice'].toString()) ?? 0,
        imgAdress: map['itemPicture'] ?? '',
        itemColor: parsedColors.isNotEmpty ? parsedColors.first : Colors.grey,
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
        rate: map['itemRate'] ?? 0,
        deliverCompanies:
            map["Deliver Companies"] is List ? map["Deliver Companies"] : [],
        type: map['itemType'] ?? '',
        description: map['itemdescription']);
  }
  ///////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  factory RevenueIemsModel.fromOracleMap(Map<String, dynamic> map) {
    // Parse color safely
    Color parseColor(String hex) {
      try {
        return Color(int.parse(hex.replaceFirst('#', '0xff')));
      } catch (_) {
        return Colors.grey;
      }
    }

    List<Color> parsedColors = [];
    // print('from oracle${map['colorsAvailable']}');
    final colorList = map['colorsAvailable'];
    if (colorList is List && colorList.isNotEmpty) {
      try {
        parsedColors = colorList.map((hex) {
          final cleanHex = hex.toString().replaceAll('#', '').padLeft(6, '0');
          return Color(int.parse('0xFF$cleanHex'));
        }).toList();
      } catch (e) {
        print("Color parsing failed: $e");
      }
    }

    return RevenueIemsModel(
      id: map['itemId'].toString(),
      name: map['itemName'] ?? '',
      model: map['itemModel'] ?? '',
      price: (map['itemPrice'] is int)
          ? map['itemPrice']
          : int.tryParse(map['itemPrice'].toString()) ?? 0,
      colorsAvailable: parsedColors,
      sizes: (map['itemSize'] is List)
          ? List<String>.from(map['itemSize'])
          : (map['itemSize'] is String)
              ? map['itemSize'].toString().split(',')
              : [],
      type: map['itemType'] ?? '',
      description: map['itemDescription'] ?? '',
      imgAdress: map['itemImageAddress'] ?? '',
      rate: double.tryParse(map['itemRate'].toString()) ?? 0.0,
      discount: (map['itemAfterDiscount'] is int)
          ? map['itemAfterDiscount']
          : int.tryParse(map['itemAfterDiscount'].toString()) ?? 0,
      ///////////////
      itemColor: () {
        final rawColor = map['itemColor'];
        if (rawColor is List && rawColor.isNotEmpty && rawColor[0] is String) {
          return parseColor(rawColor[0]);
        }
        return Colors.grey;
      }(),

      // This const use to selecting a specific size of item
      selectedSize: (map["itemSize"] is String)
          ? map["itemSize"]
          : (map["itemSize"] is List && map["itemSize"].isNotEmpty)
              ? map["itemSize"][0].toString()
              : 'N/A',

      countOfItem: map['itemCount'] is int
          ? map['itemCount']
          : int.tryParse(map['itemCount'].toString()) ?? 1,
      addToCart: map['itemAddToCart'] ?? false,
      liked: map['itemLikes'] ?? false,
      deliverCompanies:
          map["Deliver Companies"] is List ? map["Deliver Companies"] : [],
    );
  }
  ///////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  factory RevenueIemsModel.fromSearchJson(Map<String, dynamic> map) {
    // Parse color safely
    Color parseColor(String hex) {
      try {
        return Color(int.parse(hex.replaceFirst('#', '0xff')));
      } catch (_) {
        return Colors.grey;
      }
    }

    List<Color> parsedColors = [];
    print('from oracle${map['colorsAvailable']}');
    final colorList = map['colorsAvailable'];
    if (colorList is List && colorList.isNotEmpty) {
      try {
        parsedColors = colorList.map((hex) {
          final cleanHex = hex.toString().replaceAll('#', '').padLeft(6, '0');
          return Color(int.parse('0xFF$cleanHex'));
        }).toList();
      } catch (e) {
        print("Color parsing failed: $e");
      }
    }

    return RevenueIemsModel(
        id: map['itemId'].toString(),
        name: map['itemName'] ?? '',
        model: map['itemModel'] ?? '',
        price: (map['itemPrice'] is int)
            ? map['itemPrice']
            : int.tryParse(map['itemPrice'].toString()) ?? 0,
        imgAdress: map['itemImageAddress'] ?? '',
        itemColor: () {
          final rawColor = map['itemColor'];
          if (rawColor is List &&
              rawColor.isNotEmpty &&
              rawColor[0] is String) {
            return parseColor(rawColor[0]);
          }
          return Colors.grey;
        }(),
        sizes: (map['itemSize'] is List)
            ? List<String>.from(map['itemSize'])
            : (map['itemSize'] is String)
                ? map['itemSize'].toString().split(',')
                : [],
        selectedSize: map["itemSize"] ?? 'N/A',
        colorsAvailable: parsedColors,
        countOfItem: map['itemCount'] is int
            ? map['itemCount']
            : int.tryParse(map['itemCount'].toString()) ?? 1,
        addToCart: map['itemAddToCart'] ?? false,
        liked: map['itemLikes'] ?? false,
        type: map['ItemType'] ?? '',
        description: map['itemDescription'] ?? '',
        rate: map['itemRate'] ?? 0,
        deliverCompanies:
            map["Deliver Companies"] is List ? map["Deliver Companies"] : []);
  }

  ///////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////

  factory RevenueIemsModel.fromMongo(Map<String, dynamic> map) {
    print('Parsing item from Mongo: $map');
    Color parseColor(String hex) {
      try {
        return Color(int.parse(hex.replaceFirst('#', '0xff')));
      } catch (_) {
        return Colors.grey;
      }
    }

    List<Color> parsedColors = [];
    print('from oracle${map['colorsAvailable']}');
    final colorList = map['colorsAvailable'];
    if (colorList is List && colorList.isNotEmpty) {
      try {
        parsedColors = colorList.map((hex) {
          final cleanHex = hex.toString().replaceAll('#', '').padLeft(6, '0');
          return Color(int.parse('0xFF$cleanHex'));
        }).toList();
      } catch (e) {
        print("Color parsing failed: $e");
      }
    }

    return RevenueIemsModel(
        id: map['itemId'].toString(),
        name: map['itemName'] ?? '',
        model: map['itemModel'] ?? '',
        addToCart: map['itemAddToCart'] ?? false,
        price: (map['itemPrice'] is int)
            ? map['itemPrice']
            : int.tryParse(map['itemPrice'].toString()) ?? 0,
        type: map['itemType'] ?? '',
        description: map['itemDescription'] ?? '',
        imgAdress: map['itemImageAddress'] ?? '',
        itemColor: () {
          final rawColor = map['itemColor'];
          if (rawColor is List &&
              rawColor.isNotEmpty &&
              rawColor[0] is String) {
            return parseColor(rawColor[0]);
          }
          return Colors.grey;
        }(),
        liked: map['itemLikes'] ?? false,
        colorsAvailable: parsedColors,
        rate: map['itemRate'] ?? 0,
        sizes: (map['itemSize'] is List)
            ? List<String>.from(map['itemSize'])
            : (map['itemSize'] is String)
                ? map['itemSize'].toString().split(',')
                : [],
        countOfItem: map['itemCount'] is int
            ? map['itemCount']
            : int.tryParse(map['itemCount'].toString()) ?? 1,
        deliverCompanies:
            map["Deliver Companies"] is List ? map["Deliver Companies"] : []);
  }
}

class SearchItemModel {
  final String id;
  final String name;
  final String model;
  final int price;
  final String imgAdress;
  final double rate;

  SearchItemModel(
      {required this.id,
      required this.name,
      required this.model,
      required this.price,
      required this.imgAdress,
      required this.rate});

  factory SearchItemModel.fromSearchMap(Map<String, dynamic> map) {
    // print('from oracle${map['itemRate']}');
    return SearchItemModel(
      id: map['itemId'],
      name: map['itemName'] ?? '',
      model: map['itemModel'] ?? '',
      price: (map['itemPrice'] is int)
          ? map['itemPrice']
          : int.tryParse(map['itemPrice'].toString()) ?? 0,
      imgAdress: map['itemImageAddress'] ?? '',
      rate: double.tryParse(map['itemRate'].toString()) ?? 0.0,
    );
  }
  static SearchItemModel searchEmpty() {
    return SearchItemModel(
        id: '', name: '', model: '', price: 0, imgAdress: '', rate: 0.0);
  }
}

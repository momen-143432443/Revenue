import 'package:flutter/material.dart';

class RevenueIemsModel {
  String name;
  String model;
  double price;
  String imgAdress;
  Color itemColor;
  bool liked;

  RevenueIemsModel(
      {required this.name,
      required this.model,
      required this.price,
      required this.imgAdress,
      required this.itemColor,
      required this.liked});
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FetchCartItemsEvent extends Equatable {}

class FetchCartitemsEventLoading extends FetchCartItemsEvent {
  @override
  List<Object?> get props => [];
}

class DeleteExistSpecificItemFromCart extends FetchCartItemsEvent {
  final String itemId;
  DeleteExistSpecificItemFromCart(this.itemId);
  @override
  List<Object?> get props => [itemId];
}

import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FetchCartItemsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCartItemsStateLoading extends FetchCartItemsState {
  @override
  List<Object?> get props => [];
}

class FetchCartItemsStateLoaded extends FetchCartItemsState {
  final List<RevenueIemsModel> cart;
  FetchCartItemsStateLoaded(this.cart);
  @override
  List<Object?> get props => [cart];
}

class FetchCartItemsStateEmpty extends FetchCartItemsState {}

// ignore: must_be_immutable
class FetchCartItemsStateError extends FetchCartItemsState {
  String err;
  FetchCartItemsStateError(this.err);
  @override
  List<Object?> get props => [err];
}

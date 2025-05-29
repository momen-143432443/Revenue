import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class MostTrindingCubit extends Cubit<List<RevenueIemsModel>> {
  MostTrindingCubit() : super([]);

  void setInitialMosttrindingItems(List<RevenueIemsModel> items) {
    emit(List.from(items));
  }

  void toggleLikeFrommostTrending(int index) {
    final update = List<RevenueIemsModel>.from(state);
    update[index].liked = !update[index].liked;
    emit(update);
  }
}

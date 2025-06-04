import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';

abstract class DropShoeItemsIntoHomeScreenState extends Equatable {}

class DropShoeItemsIntoHomeScreenStateLoading
    extends DropShoeItemsIntoHomeScreenState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class DropShoeItemsIntoHomeScreenStateLoaded
    extends DropShoeItemsIntoHomeScreenState {
  final List<RevenueIemsModel> items;
  DropShoeItemsIntoHomeScreenStateLoaded({required this.items});
  @override
  List<Object?> get props => [items];
}

class DropShoeItemsIntoHomeScreenStateError
    extends DropShoeItemsIntoHomeScreenState {
  final String err;
  DropShoeItemsIntoHomeScreenStateError(this.err);
  List<Object?> get props => [err];
}

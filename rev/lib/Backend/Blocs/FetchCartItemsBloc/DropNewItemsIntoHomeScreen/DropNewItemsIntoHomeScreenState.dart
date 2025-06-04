import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';

abstract class DropNewItemsIntoHomeScreenState extends Equatable {}

class DropNewItemsIntoHomeScreenStateLoading
    extends DropNewItemsIntoHomeScreenState {
  @override
  List<Object?> get props => [];
}

class DropNewItemsIntoHomeScreenStateLoaded
    extends DropNewItemsIntoHomeScreenState {
  final List<RevenueIemsModel> items;
  DropNewItemsIntoHomeScreenStateLoaded({required this.items});
  @override
  List<Object?> get props => [items];
}

class DropNewItemsIntoHomeScreenStateError
    extends DropNewItemsIntoHomeScreenState {
  final String err;
  DropNewItemsIntoHomeScreenStateError(this.err);

  @override
  List<Object?> get props => [err];
}

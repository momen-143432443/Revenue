import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';

abstract class DropItemsIntoHomeScreenState extends Equatable {}

class DropItemsIntoHomeScreenStateLoading extends DropItemsIntoHomeScreenState {
  @override
  List<Object?> get props => [];
}

class DropItemsIntoHomeScreenStateLoaded extends DropItemsIntoHomeScreenState {
  final List<RevenueIemsModel> items;
  DropItemsIntoHomeScreenStateLoaded({required this.items});
  @override
  List<Object?> get props => [items];
}

class DropItemsIntoHomeScreenStateError extends DropItemsIntoHomeScreenState {
  final String err;
  DropItemsIntoHomeScreenStateError(this.err);
  List<Object?> get props => [err];
}

import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';

abstract class DropShoeItemsIntoHomeScreenState extends Equatable {
  final List<RevenueIemsModel> items;
  const DropShoeItemsIntoHomeScreenState(this.items);
  DropShoeItemsIntoHomeScreenState copyWith({List<RevenueIemsModel>? items}) {
    return DropShoeItemsIntoHomeScreenStateLoaded(items: items ?? this.items);
  }
}

class DropShoeItemsIntoHomeScreenStateLoading
    extends DropShoeItemsIntoHomeScreenState {
  const DropShoeItemsIntoHomeScreenStateLoading() : super(const []);
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class DropShoeItemsIntoHomeScreenStateLoaded
    extends DropShoeItemsIntoHomeScreenState {
  const DropShoeItemsIntoHomeScreenStateLoaded(
      {required List<RevenueIemsModel> items})
      : super(items);
  @override
  List<Object?> get props => [items];
}

class DropShoeItemsIntoHomeScreenStateError
    extends DropShoeItemsIntoHomeScreenState {
  final String err;
  const DropShoeItemsIntoHomeScreenStateError(this.err) : super(const []);
  @override
  List<Object?> get props => [err];
}

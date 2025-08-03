import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';

abstract class DropNewItemsIntoHomeScreenState extends Equatable {
  final List<RevenueIemsModel> items;
  const DropNewItemsIntoHomeScreenState(this.items);
  DropNewItemsIntoHomeScreenState copyWith({List<RevenueIemsModel>? items}) {
    return DropNewItemsIntoHomeScreenStateLoaded(items: items ?? this.items);
  }
}

class DropNewItemsIntoHomeScreenStateLoading
    extends DropNewItemsIntoHomeScreenState {
  const DropNewItemsIntoHomeScreenStateLoading() : super(const []);
  @override
  List<Object?> get props => [];
}

class DropNewItemsIntoHomeScreenStateLoaded
    extends DropNewItemsIntoHomeScreenState {
  const DropNewItemsIntoHomeScreenStateLoaded(
      {required List<RevenueIemsModel> items})
      : super(items);
  @override
  List<Object?> get props => [items];
}

class DropNewItemsIntoHomeScreenStateError
    extends DropNewItemsIntoHomeScreenState {
  final String err;
  const DropNewItemsIntoHomeScreenStateError(this.err) : super(const []);

  @override
  List<Object?> get props => [err];
}

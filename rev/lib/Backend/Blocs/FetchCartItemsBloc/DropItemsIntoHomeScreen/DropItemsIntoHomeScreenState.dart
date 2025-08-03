import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';

abstract class DropItemsIntoHomeScreenState extends Equatable {
  final List<RevenueIemsModel> items;
  const DropItemsIntoHomeScreenState(this.items);

  DropItemsIntoHomeScreenState copyWith({List<RevenueIemsModel>? items}) {
    return DropItemsIntoHomeScreenStateLoaded(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}

class DropItemsIntoHomeScreenStateLoading extends DropItemsIntoHomeScreenState {
  const DropItemsIntoHomeScreenStateLoading() : super(const []);
}

class DropItemsIntoHomeScreenStateLoaded extends DropItemsIntoHomeScreenState {
  const DropItemsIntoHomeScreenStateLoaded(
      {required List<RevenueIemsModel> items})
      : super(items);
  @override
  List<Object?> get props => [items];
}

class DropItemsIntoHomeScreenStateError extends DropItemsIntoHomeScreenState {
  final String err;
  const DropItemsIntoHomeScreenStateError(this.err) : super(const []);
  @override
  List<Object?> get props => [err];
}

import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';

abstract class DropFeatureItemIntoHomeScreenState extends Equatable {
  final List<RevenueIemsModel> items;
  const DropFeatureItemIntoHomeScreenState(this.items);
  DropFeatureItemIntoHomeScreenState copyWith({List<RevenueIemsModel>? items}) {
    return DropFeatureItemIntoHomeScreenStateLoaded(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}

class DropFeatureItemIntoHomeScreenStateLoading
    extends DropFeatureItemIntoHomeScreenState {
  const DropFeatureItemIntoHomeScreenStateLoading() : super(const []);
}

// ignore: must_be_immutable
class DropFeatureItemIntoHomeScreenStateLoaded
    extends DropFeatureItemIntoHomeScreenState {
  const DropFeatureItemIntoHomeScreenStateLoaded(
      {required List<RevenueIemsModel> items})
      : super(items);
  @override
  List<Object?> get props => [items];
}

class DropFeatureItemIntoHomeScreenStateError
    extends DropFeatureItemIntoHomeScreenState {
  final String err;
  const DropFeatureItemIntoHomeScreenStateError(this.err) : super(const []);

  @override
  List<Object?> get props => [err];
}

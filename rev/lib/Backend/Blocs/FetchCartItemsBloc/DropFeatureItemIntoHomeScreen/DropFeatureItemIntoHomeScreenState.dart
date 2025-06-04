import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:equatable/equatable.dart';

abstract class DropFeatureItemIntoHomeScreenState extends Equatable {}

class DropFeatureItemIntoHomeScreenStateLoading
    extends DropFeatureItemIntoHomeScreenState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class DropFeatureItemIntoHomeScreenStateLoaded
    extends DropFeatureItemIntoHomeScreenState {
  List<RevenueIemsModel> items = [];
  DropFeatureItemIntoHomeScreenStateLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class DropFeatureItemIntoHomeScreenStateError
    extends DropFeatureItemIntoHomeScreenState {
  final String err;
  DropFeatureItemIntoHomeScreenStateError(this.err);

  @override
  List<Object?> get props => [err];
}

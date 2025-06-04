import 'package:equatable/equatable.dart';

abstract class DropFeatureItemIntoHomeScreenEvent extends Equatable {}

class DropFeatureItemIntoHomeScreenEventLoading
    extends DropFeatureItemIntoHomeScreenEvent {
  @override
  List<Object?> get props => [];
}

class DropFeatureItemIntoHomeScreenEventError
    extends DropFeatureItemIntoHomeScreenEvent {
  final String err;
  DropFeatureItemIntoHomeScreenEventError(this.err);

  @override
  List<Object?> get props => [err];
}

import 'package:equatable/equatable.dart';

abstract class DropShoeItemsIntoHomeScreenEvent extends Equatable {}

class DropShoeItemsIntoHomeScreenEventLoading
    extends DropShoeItemsIntoHomeScreenEvent {
  @override
  List<Object?> get props => [];
}

class DropShoeItemsIntoHomeScreenEventError
    extends DropShoeItemsIntoHomeScreenEvent {
  final String err;
  DropShoeItemsIntoHomeScreenEventError(this.err);

  @override
  List<Object?> get props => [err];
}

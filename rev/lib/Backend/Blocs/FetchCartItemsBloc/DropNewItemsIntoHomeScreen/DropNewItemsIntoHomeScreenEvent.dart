import 'package:equatable/equatable.dart';

abstract class DropNewItemsIntoHomeScreenEvent extends Equatable {}

class DropNewItemsIntoHomeScreenEventLoading
    extends DropNewItemsIntoHomeScreenEvent {
  @override
  List<Object?> get props => [];
}

class DropNewItemsIntoHomeScreenError extends DropNewItemsIntoHomeScreenEvent {
  final String err;
  DropNewItemsIntoHomeScreenError(this.err);

  @override
  List<Object?> get props => [err];
}

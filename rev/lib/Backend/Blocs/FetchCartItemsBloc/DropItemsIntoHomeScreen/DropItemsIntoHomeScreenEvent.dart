import 'package:equatable/equatable.dart';

abstract class DropItemsIntoHomeScreenEvent extends Equatable {}

class DropItemsIntoHomeScreenEventLoading extends DropItemsIntoHomeScreenEvent {
  @override
  List<Object?> get props => [];
}

class DropItemsIntoHomeScreenEventError extends DropItemsIntoHomeScreenEvent {
  final String err;
  DropItemsIntoHomeScreenEventError(this.err);
  List<Object?> get props => [err];
}

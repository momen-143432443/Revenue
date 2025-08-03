import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class SelectShoeItemsColorEvent extends DropShoeItemsIntoHomeScreenEvent {
  final String itemId;
  final Color seleted;
  SelectShoeItemsColorEvent(this.itemId, this.seleted);

  @override
  List<Object?> get props => [itemId, seleted];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class SelectNewItemsColorEvent extends DropNewItemsIntoHomeScreenEvent {
  final String itemId;
  final Color seleted;
  SelectNewItemsColorEvent(this.itemId, this.seleted);

  @override
  List<Object?> get props => [itemId, seleted];
}

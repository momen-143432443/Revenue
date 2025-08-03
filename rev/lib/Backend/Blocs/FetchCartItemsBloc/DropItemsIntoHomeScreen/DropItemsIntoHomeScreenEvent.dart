import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class SelectColorEvent extends DropItemsIntoHomeScreenEvent {
  final String itemId;
  final Color seleted;
  SelectColorEvent(this.itemId, this.seleted);
  @override
  List<Object?> get props => throw UnimplementedError();
}

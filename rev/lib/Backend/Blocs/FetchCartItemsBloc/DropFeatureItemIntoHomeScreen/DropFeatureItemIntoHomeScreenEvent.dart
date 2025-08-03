import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class SelectColorFeatureItemEvent extends DropFeatureItemIntoHomeScreenEvent {
  final String itemId;
  final Color seleted;
  SelectColorFeatureItemEvent(this.itemId, this.seleted);
  @override
  List<Object?> get props => [itemId, seleted];
}

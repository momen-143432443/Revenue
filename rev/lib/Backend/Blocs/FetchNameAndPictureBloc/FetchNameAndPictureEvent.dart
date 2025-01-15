import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FetchNameAndPictureEvent extends Equatable {}

class FetchNameAndPictureEventLoading extends FetchNameAndPictureEvent {
  @override
  List<Object?> get props => [];
}

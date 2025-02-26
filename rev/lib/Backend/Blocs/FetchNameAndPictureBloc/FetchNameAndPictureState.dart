import 'package:css/Backend/Repositories/UserRepository/UserModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FetchNameAndPictureState extends Equatable {}

class FetchNameAndPictureStateLoading extends FetchNameAndPictureState {
  @override
  List<Object?> get props => [];
}

class FetchNameAndPictureStateLoaded extends FetchNameAndPictureState {
  final List<UserModel> user;
  FetchNameAndPictureStateLoaded(this.user);
  List<Object?> get props => [user];
}

// ignore: must_be_immutable
class FetchNameAndPictureStateError extends FetchNameAndPictureState {
  String err;
  FetchNameAndPictureStateError(this.err);
  List<Object?> get props => [err];
}

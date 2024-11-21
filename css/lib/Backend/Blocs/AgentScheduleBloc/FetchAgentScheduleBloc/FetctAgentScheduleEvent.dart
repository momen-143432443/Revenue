import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FetctAgentScheduleEvent extends Equatable {}

class FetctAgentScheduleEventLoading extends FetctAgentScheduleEvent {
  @override
  List<Object?> get props => [];
}

import 'package:css/Backend/SceduleSturcture.dart/FetchScheduleAgent.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FetchAgentScheduleState extends Equatable {}

class FetchAgentScheduleStateLoading extends FetchAgentScheduleState {
  @override
  List<Object?> get props => [];
}

class FetchAgentScheduleLoaded extends FetchAgentScheduleState {
  final FetchScheduleAgent fetchScheduleAgent;
  FetchAgentScheduleLoaded(this.fetchScheduleAgent);
  @override
  List<Object?> get props => [fetchScheduleAgent];
}

class FetchAgentScheduleError extends FetchAgentScheduleState {
  final String err;
  FetchAgentScheduleError(this.err);
  @override
  List<Object?> get props => [err];
}

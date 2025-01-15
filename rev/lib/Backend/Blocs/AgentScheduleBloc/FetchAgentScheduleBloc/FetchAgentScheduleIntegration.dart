import 'package:css/Backend/Blocs/AgentScheduleBloc/FetchAgentScheduleBloc/FetctAgentScheduleEvent.dart';
import 'package:css/Backend/Blocs/AgentScheduleBloc/FetchAgentScheduleBloc/FetctAgentScheduleState.dart';
import 'package:css/Backend/SceduleSturcture.dart/FetchScheduleAgent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAgentScheduleIntegration
    extends Bloc<FetctAgentScheduleEvent, FetchAgentScheduleState> {
  final FetchScheduleAgent fetchScheduleAgent;
  FetchAgentScheduleIntegration(this.fetchScheduleAgent)
      : super(FetchAgentScheduleStateLoading()) {
    on<FetctAgentScheduleEventLoading>((event, emit) {
      emit(FetchAgentScheduleStateLoading());
      try {
        emit(FetchAgentScheduleLoaded(fetchScheduleAgent));
      } catch (e) {
        emit(FetchAgentScheduleError(e.toString()));
      }
    });
  }
}

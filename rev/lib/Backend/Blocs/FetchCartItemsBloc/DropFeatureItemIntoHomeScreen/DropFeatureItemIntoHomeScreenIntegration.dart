import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropFeatureItemIntoHomeScreen/DropFeatureItemIntoHomeScreenEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropFeatureItemIntoHomeScreen/DropFeatureItemIntoHomeScreenState.dart';
import 'package:css/Backend/Connectivity_plus/SafeTap.dart';
import 'package:css/Backend/Controllers/ForProductControllers/ShowAllItems.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class DropFeatureItemIntoHomeScreenIntegration extends Bloc<
    DropFeatureItemIntoHomeScreenEvent, DropFeatureItemIntoHomeScreenState> {
  final ShowFeatureItems showFeatureItems;
  DropFeatureItemIntoHomeScreenIntegration(this.showFeatureItems)
      : super(DropFeatureItemIntoHomeScreenStateLoading()) {
    on<DropFeatureItemIntoHomeScreenEventLoading>(
      (event, emit) async {
        emit(DropFeatureItemIntoHomeScreenStateLoading());
        try {
          SafeTap.execute(
            context: navigator!.context,
            onTap: () async {
              print('Loading Connection');
            },
          );
          emit(DropFeatureItemIntoHomeScreenStateLoading());
          final items = await showFeatureItems.fetchAllItems();
          emit(DropFeatureItemIntoHomeScreenStateLoaded(items: items));
        } catch (e) {
          emit(DropFeatureItemIntoHomeScreenStateError(e.toString()));
        }
      },
    );
  }
}

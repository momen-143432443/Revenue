import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropNewItemsIntoHomeScreen/DropNewItemsIntoHomeScreenEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropNewItemsIntoHomeScreen/DropNewItemsIntoHomeScreenState.dart';
import 'package:css/Backend/Connectivity_plus/SafeTap.dart';
import 'package:css/Backend/Controllers/ForProductControllers/ShowAllItems.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class DropNewItemsIntoHomeScreenIntegration extends Bloc<
    DropNewItemsIntoHomeScreenEvent, DropNewItemsIntoHomeScreenState> {
  final ShowNewItems showNewItems;
  DropNewItemsIntoHomeScreenIntegration(this.showNewItems)
      : super(DropNewItemsIntoHomeScreenStateLoading()) {
    on<DropNewItemsIntoHomeScreenEventLoading>(
      (event, emit) async {
        SafeTap.execute(
          context: navigator!.context,
          onTap: () async {
            print('Loading Connection');
          },
        );
        emit(DropNewItemsIntoHomeScreenStateLoading());
        try {
          final allItems = await showNewItems.fetchAllItems();
          emit(DropNewItemsIntoHomeScreenStateLoaded(items: allItems));
        } catch (e) {}
      },
    );
  }
}

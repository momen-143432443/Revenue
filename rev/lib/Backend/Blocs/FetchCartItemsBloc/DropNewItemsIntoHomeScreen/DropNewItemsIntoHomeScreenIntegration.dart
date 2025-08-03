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
      : super(const DropNewItemsIntoHomeScreenStateLoading()) {
    on<DropNewItemsIntoHomeScreenEventLoading>(
      (event, emit) async {
        SafeTap.execute(
          context: navigator!.context,
          onTap: () async {
            // print('Loading Connection');
          },
        );
        emit(const DropNewItemsIntoHomeScreenStateLoading());
        try {
          final allItems = await showNewItems.fetchAllItems();
          emit(DropNewItemsIntoHomeScreenStateLoaded(items: allItems));
        } catch (e) {
          emit(DropNewItemsIntoHomeScreenStateError(e.toString()));
        }
      },
    );
    on<SelectNewItemsColorEvent>(
      (event, emit) {
        final updatedItems = state.items.map(
          (item) {
            if (item.id == event.itemId) {
              return item.copyWith(
                  selectedColor: item.selectedColor,
                  selectedSize: item.selectedSize);
            } else {
              return item;
            }
          },
        ).toList();
      },
    );
  }
}

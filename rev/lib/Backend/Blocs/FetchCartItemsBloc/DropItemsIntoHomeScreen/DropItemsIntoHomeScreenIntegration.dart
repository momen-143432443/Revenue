import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropItemsIntoHomeScreen/DropItemsIntoHomeScreenEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropItemsIntoHomeScreen/DropItemsIntoHomeScreenState.dart';
import 'package:css/Backend/Connectivity_plus/SafeTap.dart';
import 'package:css/Backend/Controllers/ForProductControllers/ShowAllItems.dart';
import 'package:css/Backend/Infsructure/Models/ItemsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DropItemsIntoHomeScreenIntegration
    extends Bloc<DropItemsIntoHomeScreenEvent, DropItemsIntoHomeScreenState> {
  final ShowAllItemsMostOfTrinding items;
  DropItemsIntoHomeScreenIntegration(this.items)
      : super(const DropItemsIntoHomeScreenStateLoading()) {
    on<DropItemsIntoHomeScreenEventLoading>(
      (event, emit) async {
        SafeTap.execute(
          context: navigator!.context,
          onTap: () async {
            // print('Loading Connection');
          },
        );
        emit(const DropItemsIntoHomeScreenStateLoading());
        try {
          final getItems = await items.fetchAllItem();
          emit(DropItemsIntoHomeScreenStateLoaded(items: getItems));
          // print("Fetch items from oracle");
        } catch (e) {
//           print('Error In Oracle Database');
//           print('''
// ---------------------------------------------
// ---------------------------------------------
// ---------------${e}--------------------------
// ---------------------------------------------
// ---------------------------------------------
// ''');
          emit(DropItemsIntoHomeScreenStateError(e.toString()));
        }
      },
    );
    on<SelectColorEvent>(
      (event, emit) {
        final updatedItems = state.items.map(
          (item) {
            if (item.id == event.itemId) {
              return item.copyWith(selectedColor: item.selectedColor);
            }
            return item;
          },
        ).toList();
        emit(state.copyWith(items: updatedItems));
      },
    );
  }
}

import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropItemsIntoHomeScreen/DropItemsIntoHomeScreenEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropItemsIntoHomeScreen/DropItemsIntoHomeScreenState.dart';
import 'package:css/Backend/Connectivity_plus/SafeTap.dart';
import 'package:css/Backend/Controllers/ForProductControllers/ShowAllItems.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DropItemsIntoHomeScreenIntegration
    extends Bloc<DropItemsIntoHomeScreenEvent, DropItemsIntoHomeScreenState> {
  final ShowAllItemsMostOfTrinding items;
  DropItemsIntoHomeScreenIntegration(this.items)
      : super(DropItemsIntoHomeScreenStateLoading()) {
    on<DropItemsIntoHomeScreenEventLoading>(
      (event, emit) async {
        SafeTap.execute(
          context: navigator!.context,
          onTap: () async {
            print('Loading Connection');
          },
        );
        emit(DropItemsIntoHomeScreenStateLoading());
        try {
          final getItems = await items.fetchAllItem();
          emit(DropItemsIntoHomeScreenStateLoaded(items: getItems));
          print("Fetch items from oracle");
        } catch (e) {
          print('Error In Oracle Database');
          print('''
---------------------------------------------
---------------------------------------------
---------------${e}--------------------------
---------------------------------------------
---------------------------------------------
''');
          emit(DropItemsIntoHomeScreenStateError(e.toString()));
        }
      },
    );
  }
}

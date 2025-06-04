import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropShoeItemsIntoHomeScreen/DropShoeItemsIntoHomeScreenEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/DropShoeItemsIntoHomeScreen/DropShoeItemsIntoHomeScreenState.dart';
import 'package:css/Backend/Connectivity_plus/SafeTap.dart';
import 'package:css/Backend/Controllers/ForProductControllers/ShowAllItems.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class DropShoeItemsIntoHomeScreenIntegration extends Bloc<
    DropShoeItemsIntoHomeScreenEvent, DropShoeItemsIntoHomeScreenState> {
  final ShowAllItemsShoesProducts itemsShoesProducts;
  DropShoeItemsIntoHomeScreenIntegration(this.itemsShoesProducts)
      : super(DropShoeItemsIntoHomeScreenStateLoading()) {
    on<DropShoeItemsIntoHomeScreenEventLoading>(
      (event, emit) async {
        SafeTap.execute(
          context: navigator!.context,
          onTap: () async {
            print('Loading Connection');
          },
        );
        emit(DropShoeItemsIntoHomeScreenStateLoading());
        try {
          final items = await itemsShoesProducts.fetchAllItems();
          emit(DropShoeItemsIntoHomeScreenStateLoaded(items: items));
        } catch (e) {}
      },
    );
  }
}

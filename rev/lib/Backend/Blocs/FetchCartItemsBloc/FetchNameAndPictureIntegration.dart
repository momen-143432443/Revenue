import 'package:css/Backend/Blocs/FetchCartItemsBloc/FetchNameAndPictureEvent.dart';
import 'package:css/Backend/Blocs/FetchCartItemsBloc/FetchNameAndPictureState.dart';
import 'package:css/Front/Functions/AppMethods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchCartItemsIntegration
    extends Bloc<FetchCartItemsEvent, FetchCartItemsState> {
  final AppMethods app;
  FetchCartItemsIntegration(this.app) : super(FetchCartItemsStateLoading()) {
    on<FetchCartitemsEventLoading>(
      (event, emit) async {
        emit(FetchCartItemsStateLoading());
        print('Loading Cart Items');
        try {
          final bd = await app.getCartItems();
          emit(FetchCartItemsStateLoaded(bd));
          print('Loaded Cart Items');
        } catch (e) {
          print('Error Cart Items');
          emit(FetchCartItemsStateError(e.toString()));
        }
      },
    );
    on<DeleteExistSpecificItemFromCart>(
      (event, emit) async {
        try {
          emit(FetchCartItemsStateLoading());
          final existItems = await app.getCartItems();
          await app.removeItems(event.itemId);
          emit(FetchCartItemsStateLoaded(existItems));
        } catch (e) {
          emit(FetchCartItemsStateError(e.toString()));
        }
      },
    );
  }
}

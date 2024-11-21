import 'package:css/Backend/Blocs/FetchNameAndPictureBloc/FetchNameAndPictureEvent.dart';
import 'package:css/Backend/Blocs/FetchNameAndPictureBloc/FetchNameAndPictureState.dart';
import 'package:css/Backend/Controllers/ProfileController.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchNameAndPictureIntegration
    extends Bloc<FetchNameAndPictureEvent, FetchNameAndPictureState> {
  final ProfileController profileController;
  FetchNameAndPictureIntegration(this.profileController)
      : super(FetchNameAndPictureStateLoading()) {
    on<FetchNameAndPictureEventLoading>(
      (event, emit) async {
        emit(FetchNameAndPictureStateLoading());
        print('Loading iamge and username');
        try {
          final bd = await profileController.fetchUserData();
          emit(FetchNameAndPictureStateLoaded(bd));
          print('Loaded iamge and username');
        } catch (e) {
          print('Error iamge and username');
          emit(FetchNameAndPictureStateError(e.toString()));
        }
      },
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class PopupCubit extends Cubit<bool> {
  PopupCubit() : super(false);

  bool _hasShownPopup = false;
  bool isFromNotification = false;
  bool ignoreNotificationStatus = false;

  /// Stack sadece [MasterRoute] olduğunda observer tarafından çağrılacak
  void onMasterRouteActive() {
    if ((!_hasShownPopup && !isFromNotification) ||
        (!_hasShownPopup && ignoreNotificationStatus)) {
      print("popup göster");
      emit(true); // popup göster
      _hasShownPopup = true;
    }
    ignoreNotificationStatus = true;
  }

  /// Popup kapatıldığında state'i sıfırla
  void dismissPopup() => emit(false);
}

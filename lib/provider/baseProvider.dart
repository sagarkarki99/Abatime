import 'package:flutter/foundation.dart';

enum ViewState { IDLE, LOADING, WITHDATA, WITHERROR }

class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;

  ViewState get state => _state;

  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}

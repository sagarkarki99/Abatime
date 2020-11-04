import 'package:flutter/foundation.dart';

enum ViewState { IDLE, LOADING, WITHDATA, WITHERROR }

class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;
  String _errorMessage = "Something went wrong!";

  ViewState get state => _state;
  String get uiErrorMessage => _errorMessage;

  void setUiState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}

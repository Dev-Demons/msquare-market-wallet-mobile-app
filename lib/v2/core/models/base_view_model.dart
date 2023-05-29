import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../enums/view_state.dart';

/// Class that handles Screen idle and busy state

class BaseViewModal extends ChangeNotifier {
  /// [ViewState] variable to set initial object state
  /// to idle
  ViewState _state = ViewState.idle;

  /// [Getter] Function that returns the current loading state
  ViewState get state => _state;

  /// [Function] that accepts the loading state and assign it to
  /// [_state] and notifies its listeners as well.
  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}

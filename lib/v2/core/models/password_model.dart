import 'package:flutter/cupertino.dart';

/// Class that handles Password Attempts for transactions
class PasswordModel extends ChangeNotifier {
  /// [Integer] variable that stores total number of attempts
  int? _totalAttempts;

  /// [TextEditingController] that controls password.
  TextEditingController? _passwordController;

  /// Main [Constructor] that initialized the data members
  PasswordModel() {
    // assign total number of attempts to 10
    _totalAttempts = 10;
    // assign password controller
    _passwordController = TextEditingController();
  }

  /// [Function] that reduces the total attempts and notifies its listeners
  void reduceAttempts() {
    _totalAttempts = _totalAttempts! - 1;
    notifyListeners();
  }

  /// [Getter] Function that returns total number of attempts.
  int get totalAttempts => _totalAttempts!;

  /// [Setter] Function that sets the [_totalAttempts] value and notifies
  /// its listeners.
  set totalAttempts(int value) {
    _totalAttempts = value;
    notifyListeners();
  }

  /// [Getter] Function that return the [TextEditingController] for passwordController
  TextEditingController get passwordController => _passwordController!;
}

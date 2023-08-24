import 'dart:async';
import 'dart:ui';

/// Provides a debouncing mechanism to ensure that the given [action] is executed
/// only once after the specified [milliseconds] have elapsed without any other calls.
class Debouncer {
  /// The number of milliseconds to wait before executing the debounced action.
  final int milliseconds;

  /// The callback action to be executed after the debounce delay.
  VoidCallback? action;
  Timer? _timer;

  /// Creates a [Debouncer] instance with a specified delay [milliseconds].
  Debouncer({required this.milliseconds});

  /// Runs the [action] after the set debouncing duration if no other calls are made.
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

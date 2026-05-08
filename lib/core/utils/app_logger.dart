import 'package:flutter/cupertino.dart';

class AppLogger {
  static void log(dynamic message) {
    debugPrint(message.toString());
  }
}

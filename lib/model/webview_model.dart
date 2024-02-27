import 'package:flutter/material.dart';

class webview_model with ChangeNotifier {
  double _progress = 0;
  double get progress => _progress;

  void changeprogress(progresss) {
    _progress = progresss;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    change();
  }

  var box = Hive.box('myThemeBox');
  bool theme =false;
  bool? themeBoolState;
  void changeTheme({required bool th}) async {
    box.put('theme', th);

    print("tema " + th.toString());
    change();
    notifyListeners();
  }

  void change() async {
    bool data = await box.get('theme') ?? false;
    if (data) {
      theme = data;
    } else {
      theme = false;
    }
    notifyListeners();
  }
}

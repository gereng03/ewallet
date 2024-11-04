// lib/service/navigation_service.dart

import 'package:flutter/foundation.dart';

class NavigationService extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void reset() {
    _selectedIndex = 0;
    notifyListeners();
  }
}
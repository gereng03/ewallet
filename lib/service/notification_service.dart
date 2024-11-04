// lib/service/notification_service.dart

import 'package:flutter/foundation.dart';

class NotificationService extends ChangeNotifier {
  int _notificationCount = 99;

  int get notificationCount => _notificationCount;

  void setNotificationCount(int count) {
    if (count != _notificationCount) {
      _notificationCount = count;
      notifyListeners();
    }
  }

  void clearNotifications() {
    if (_notificationCount != 0) {
      _notificationCount = 0;
      notifyListeners();
    }
  }

  void addNotification() {
    _notificationCount++;
    notifyListeners();
  }

  void reset() {
    _notificationCount = 0;
    notifyListeners();
  }

  bool hasNotifications() {
    return _notificationCount > 0;
  }
}
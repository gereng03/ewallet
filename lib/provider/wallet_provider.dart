import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class WalletProvider with ChangeNotifier {
  double _balance = 0;
  String _username = '';

  double get balance => _balance;
  String get username => _username;

  void initWalletStream(String userId) {
    // Listen to balance changes
    FirebaseDatabase.instance
        .ref()
        .child('wallets')
        .child(userId)
        .child('balance')
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        _balance = double.parse(event.snapshot.value.toString());
        notifyListeners();
      }
    });

    // Listen to username changes
    FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(userId)
        .child('username')
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        _username = event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }
}
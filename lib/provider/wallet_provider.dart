import 'package:flutter/foundation.dart';
import '../model/wallet.dart';
import '../service/wallet_service.dart';

class WalletProvider with ChangeNotifier {
  final WalletService _walletService = WalletService();
  Wallet? _wallet;

  Wallet? get wallet => _wallet;
  double get balance => _wallet?.balance ?? 0.0;

  void initWalletStream(String userId) {
    _walletService.getWalletStream(userId).listen((wallet) {
      _wallet = wallet;
      notifyListeners();
    });
  }

  Future<void> addMoney(double amount) async {
    if (_wallet == null) return;
    try {
      await _walletService.addMoney(_wallet!.id, amount);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> withdrawMoney(double amount) async {
    if (_wallet == null) return;
    try {
      await _walletService.withdrawMoney(_wallet!.id, amount);
    } catch (e) {
      rethrow;
    }
  }
}
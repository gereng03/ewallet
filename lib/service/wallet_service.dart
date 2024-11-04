import 'package:firebase_database/firebase_database.dart';
import '../model/wallet.dart';

class WalletService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Create a new wallet for a user
  Future<Wallet> createWallet(String userId) async {
    final walletRef = _database.child('wallets').push();
    final wallet = Wallet(
      id: walletRef.key!,
      userId: userId,
    );

    await walletRef.set(wallet.toMap());
    return wallet;
  }

  // Get wallet by user ID
  Stream<Wallet?> getWalletStream(String userId) {
    return _database
        .child('wallets')
        .orderByChild('userId')
        .equalTo(userId)
        .onValue
        .map((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value == null) return null;

      // Convert the data to a Map
      final Map<dynamic, dynamic> values =
      dataSnapshot.value as Map<dynamic, dynamic>;

      // Since we're querying by userId, we expect only one wallet
      // Get the first (and should be only) wallet
      final walletData = values.values.first as Map<dynamic, dynamic>;
      return Wallet.fromMap(walletData);
    });
  }

  // Update wallet balance
  Future<void> updateBalance(String walletId, double newBalance) async {
    await _database.child('wallets').child(walletId).update({
      'balance': newBalance,
      'lastUpdated': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Add money to wallet
  Future<void> addMoney(String walletId, double amount) async {
    final walletRef = _database.child('wallets').child(walletId);

    final snapshot = await walletRef.get();
    if (!snapshot.exists) {
      throw Exception('Wallet not found');
    }

    final currentBalance = (snapshot.value as Map)['balance'].toDouble();
    final newBalance = currentBalance + amount;

    await walletRef.update({
      'balance': newBalance,
      'lastUpdated': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Withdraw money from wallet
  Future<void> withdrawMoney(String walletId, double amount) async {
    final walletRef = _database.child('wallets').child(walletId);

    final snapshot = await walletRef.get();
    if (!snapshot.exists) {
      throw Exception('Wallet not found');
    }

    final currentBalance = (snapshot.value as Map)['balance'].toDouble();
    if (currentBalance < amount) {
      throw Exception('Insufficient balance');
    }

    final newBalance = currentBalance - amount;

    await walletRef.update({
      'balance': newBalance,
      'lastUpdated': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Check if wallet exists
  Future<bool> walletExists(String userId) async {
    final snapshot = await _database
        .child('wallets')
        .orderByChild('userId')
        .equalTo(userId)
        .get();

    return snapshot.exists;
  }
}
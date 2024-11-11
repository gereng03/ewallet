import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../model/wallet.dart';

class WalletService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  static const String _walletsPath = 'wallets';

  DatabaseReference get _walletsRef => _database.child(_walletsPath);

  Future<Wallet> createWallet(String userId) async {
    try {
      print('Starting wallet creation for user: $userId');

      // First check if wallet already exists
      final existingWallet = await walletExists(userId);
      if (existingWallet) {
        print('Wallet already exists for user: $userId');
        throw Exception('Wallet already exists for this user');
      }

      final walletRef = _walletsRef.child(userId);
      final wallet = {
        'userId': userId,
        'balance': 0.0,
        'lastUpdated': DateTime.now().toIso8601String(),
      };

      print('Attempting to save wallet data: $wallet');
      await walletRef.set(wallet);
      print('Wallet created successfully for user: $userId');

      return Wallet.fromMap({'id': userId, ...wallet});
    } catch (e) {
      print('Error creating wallet: $e');
      rethrow;
    }
  }

  Stream<Wallet?> getWalletStream(String userId) {
    print('Starting wallet stream for user: $userId');
    return _walletsRef
        .child(userId)
        .onValue
        .map((event) {
      final dataSnapshot = event.snapshot;
      if (!dataSnapshot.exists || dataSnapshot.value == null) {
        print('No wallet data found for user: $userId');
        return null;
      }

      try {
        final walletData = Map<String, dynamic>.from(dataSnapshot.value as Map);
        print('Retrieved wallet data: $walletData');
        return Wallet.fromMap({
          'id': userId,
          ...walletData,
        });
      } catch (e) {
        print('Error parsing wallet data: $e');
        return null;
      }
    });
  }

  Future<void> updateBalance(String walletId, double newBalance) async {
    if (newBalance < 0) {
      print('Attempted to set negative balance: $newBalance');
      throw Exception('Balance cannot be negative');
    }

    try {
      print('Updating balance for wallet: $walletId to $newBalance');
      await _walletsRef.child(walletId).update({
        'balance': newBalance,
        'lastUpdated': DateTime.now().toIso8601String(),
      });
      print('Balance updated successfully');
    } catch (e) {
      print('Error updating balance: $e');
      rethrow;
    }
  }

  Future<void> addMoney(String walletId, double amount) async {
    if (amount <= 0) {
      print('Attempted to add invalid amount: $amount');
      throw Exception('Amount must be greater than zero');
    }

    try {
      print('Adding $amount to wallet: $walletId');
      final walletRef = _walletsRef.child(walletId);
      final snapshot = await walletRef.get();

      if (!snapshot.exists) {
        print('Wallet not found: $walletId');
        throw Exception('Wallet not found');
      }

      final currentData = Map<String, dynamic>.from(snapshot.value as Map);
      final currentBalance = (currentData['balance'] ?? 0.0) as double;
      final newBalance = currentBalance + amount;

      await walletRef.update({
        'balance': newBalance,
        'lastUpdated': DateTime.now().toIso8601String(),
      });
      print('Money added successfully. New balance: $newBalance');
    } catch (e) {
      print('Error adding money: $e');
      rethrow;
    }
  }

  Future<void> withdrawMoney(String walletId, double amount) async {
    if (amount <= 0) {
      print('Attempted to withdraw invalid amount: $amount');
      throw Exception('Amount must be greater than zero');
    }

    try {
      print('Withdrawing $amount from wallet: $walletId');
      final walletRef = _walletsRef.child(walletId);
      final snapshot = await walletRef.get();

      if (!snapshot.exists) {
        print('Wallet not found: $walletId');
        throw Exception('Wallet not found');
      }

      final currentData = Map<String, dynamic>.from(snapshot.value as Map);
      final currentBalance = (currentData['balance'] ?? 0.0) as double;

      if (currentBalance < amount) {
        print('Insufficient balance. Current: $currentBalance, Requested: $amount');
        throw Exception('Insufficient balance');
      }

      final newBalance = currentBalance - amount;

      await walletRef.update({
        'balance': newBalance,
        'lastUpdated': DateTime.now().toIso8601String(),
      });
      print('Money withdrawn successfully. New balance: $newBalance');
    } catch (e) {
      print('Error withdrawing money: $e');
      rethrow;
    }
  }

  Future<bool> walletExists(String userId) async {
    try {
      print('Checking wallet existence for user: $userId');
      final snapshot = await _walletsRef.child(userId).get();
      print('Wallet exists: ${snapshot.exists}');
      return snapshot.exists;
    } catch (e) {
      print('Error checking wallet existence: $e');
      rethrow;
    }
  }
}
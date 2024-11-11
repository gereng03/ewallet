class Wallet {
  final String id;
  final String userId;
  final double balance;
  final String lastUpdated;

  Wallet({
    required this.id,
    required this.userId,
    this.balance = 0.0,
    required this.lastUpdated,
  });

  factory Wallet.fromMap(Map<dynamic, dynamic> map) {
    return Wallet(
      id: map['id'] as String,
      userId: map['userId'] as String,
      balance: (map['balance'] ?? 0.0).toDouble(),
      lastUpdated: map['lastUpdated'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'balance': balance,
      'lastUpdated': lastUpdated,
    };
  }
}
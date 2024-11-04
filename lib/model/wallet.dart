class Wallet {
  final String id;
  final String userId;
  double balance;
  final DateTime createdAt;
  DateTime lastUpdated;

  Wallet({
    required this.id,
    required this.userId,
    this.balance = 0.0,
    DateTime? createdAt,
    DateTime? lastUpdated,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastUpdated = lastUpdated ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'balance': balance,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory Wallet.fromMap(Map<dynamic, dynamic> map) {
    return Wallet(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      balance: (map['balance'] ?? 0.0).toDouble(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['lastUpdated'] ?? 0),
    );
  }
}
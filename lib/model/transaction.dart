// lib/model/transaction_model.dart

class TransactionModel {
  final String id;
  final String referenceId;
  final double amount;
  final String recipient;
  final DateTime timestamp;
  final String status;
  final String paymentMethod;
  final String recipientIcon;

  TransactionModel({
    required this.id,
    required this.referenceId,
    required this.amount,
    required this.recipient,
    required this.timestamp,
    required this.status,
    required this.paymentMethod,
    required this.recipientIcon,
  });
}
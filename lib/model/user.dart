
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? email;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.email,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      name: map['name'],
      email: map['email'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
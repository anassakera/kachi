import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String id;
  final String? email;
  final String? fullName;
  final String? avatarUrl;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    this.email,
    this.fullName,
    this.avatarUrl,
    this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        fullName = json['full_name'],
        avatarUrl = json['avatar_url'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'full_name': fullName,
        'avatar_url': avatarUrl,
        'created_at': createdAt?.toIso8601String(),
      };
}

import 'package:flutter/foundation.dart';

@immutable
class ProfileModel {
  final String id;
  final String userId;
  final String? phoneNumber;
  final String? address;
  final DateTime? updatedAt;

  const ProfileModel({
    required this.id,
    required this.userId,
    this.phoneNumber,
    this.address,
    this.updatedAt,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        phoneNumber = json['phone_number'],
        address = json['address'],
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'phone_number': phoneNumber,
        'address': address,
        'updated_at': updatedAt?.toIso8601String(),
      };
}

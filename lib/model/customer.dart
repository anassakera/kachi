class Customer {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final double totalChecksAmount;
  final int totalChecksCount;
  final int bouncedChecksCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic> metadata;

  Customer({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    required this.totalChecksAmount,
    required this.totalChecksCount,
    required this.bouncedChecksCount,
    required this.createdAt,
    this.updatedAt,
    required this.metadata,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      totalChecksAmount: json['totalChecksAmount'].toDouble(),
      totalChecksCount: json['totalChecksCount'],
      bouncedChecksCount: json['bouncedChecksCount'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'totalChecksAmount': totalChecksAmount,
      'totalChecksCount': totalChecksCount,
      'bouncedChecksCount': bouncedChecksCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    double? totalChecksAmount,
    int? totalChecksCount,
    int? bouncedChecksCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      totalChecksAmount: totalChecksAmount ?? this.totalChecksAmount,
      totalChecksCount: totalChecksCount ?? this.totalChecksCount,
      bouncedChecksCount: bouncedChecksCount ?? this.bouncedChecksCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }

  double get bounceRate => 
      totalChecksCount > 0 ? bouncedChecksCount / totalChecksCount : 0;
}

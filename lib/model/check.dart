class Check {
  final String id;
  final String checkNumber;
  final double amount;
  final DateTime issueDate;
  final DateTime dueDate;
  final String customerId;
  final String customerName;
  final String bankName;
  final String status; // pending, cleared, bounced, etc.
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Check({
    required this.id,
    required this.checkNumber,
    required this.amount,
    required this.issueDate,
    required this.dueDate,
    required this.customerId,
    required this.customerName,
    required this.bankName,
    required this.status,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  factory Check.fromJson(Map<String, dynamic> json) {
    return Check(
      id: json['id'],
      checkNumber: json['checkNumber'],
      amount: json['amount'].toDouble(),
      issueDate: DateTime.parse(json['issueDate']),
      dueDate: DateTime.parse(json['dueDate']),
      customerId: json['customerId'],
      customerName: json['customerName'],
      bankName: json['bankName'],
      status: json['status'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checkNumber': checkNumber,
      'amount': amount,
      'issueDate': issueDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'customerId': customerId,
      'customerName': customerName,
      'bankName': bankName,
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Check copyWith({
    String? id,
    String? checkNumber,
    double? amount,
    DateTime? issueDate,
    DateTime? dueDate,
    String? customerId,
    String? customerName,
    String? bankName,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Check(
      id: id ?? this.id,
      checkNumber: checkNumber ?? this.checkNumber,
      amount: amount ?? this.amount,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      bankName: bankName ?? this.bankName,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

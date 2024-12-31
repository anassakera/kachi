class Analytics {
  final double totalAmount;
  final int totalChecks;
  final Map<String, double> statusDistribution;
  final Map<String, double> bankDistribution;
  final List<TimeSeriesData> timeSeriesData;
  final Map<String, CustomerAnalytics> customerAnalytics;

  Analytics({
    required this.totalAmount,
    required this.totalChecks,
    required this.statusDistribution,
    required this.bankDistribution,
    required this.timeSeriesData,
    required this.customerAnalytics,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) {
    return Analytics(
      totalAmount: json['totalAmount'].toDouble(),
      totalChecks: json['totalChecks'],
      statusDistribution: Map<String, double>.from(json['statusDistribution']),
      bankDistribution: Map<String, double>.from(json['bankDistribution']),
      timeSeriesData: (json['timeSeriesData'] as List)
          .map((data) => TimeSeriesData.fromJson(data))
          .toList(),
      customerAnalytics: Map<String, CustomerAnalytics>.from(
        json['customerAnalytics'].map(
          (key, value) => MapEntry(key, CustomerAnalytics.fromJson(value)),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAmount': totalAmount,
      'totalChecks': totalChecks,
      'statusDistribution': statusDistribution,
      'bankDistribution': bankDistribution,
      'timeSeriesData': timeSeriesData.map((data) => data.toJson()).toList(),
      'customerAnalytics': customerAnalytics.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }
}

class TimeSeriesData {
  final DateTime date;
  final double amount;
  final int count;

  TimeSeriesData({
    required this.date,
    required this.amount,
    required this.count,
  });

  factory TimeSeriesData.fromJson(Map<String, dynamic> json) {
    return TimeSeriesData(
      date: DateTime.parse(json['date']),
      amount: json['amount'].toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
      'count': count,
    };
  }
}

class CustomerAnalytics {
  final String customerId;
  final String customerName;
  final double totalAmount;
  final int totalChecks;
  final int bouncedChecks;
  final double averageAmount;
  final Duration averagePaymentTime;

  CustomerAnalytics({
    required this.customerId,
    required this.customerName,
    required this.totalAmount,
    required this.totalChecks,
    required this.bouncedChecks,
    required this.averageAmount,
    required this.averagePaymentTime,
  });

  factory CustomerAnalytics.fromJson(Map<String, dynamic> json) {
    return CustomerAnalytics(
      customerId: json['customerId'],
      customerName: json['customerName'],
      totalAmount: json['totalAmount'].toDouble(),
      totalChecks: json['totalChecks'],
      bouncedChecks: json['bouncedChecks'],
      averageAmount: json['averageAmount'].toDouble(),
      averagePaymentTime: Duration(days: json['averagePaymentTimeDays']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'totalAmount': totalAmount,
      'totalChecks': totalChecks,
      'bouncedChecks': bouncedChecks,
      'averageAmount': averageAmount,
      'averagePaymentTimeDays': averagePaymentTime.inDays,
    };
  }

  double get bounceRate => 
      totalChecks > 0 ? bouncedChecks / totalChecks : 0;
}

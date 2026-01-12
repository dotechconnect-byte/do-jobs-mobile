class TransactionModel {
  final String id;
  final String title;
  final String date;
  final double amount;
  final String status; // completed, pending, processing
  final String type; // incoming, withdrawal
  final String? jobId;

  TransactionModel({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    required this.type,
    this.jobId,
  });

  String get formattedAmount {
    final sign = type == 'incoming' ? '+' : '-';
    return '$sign\$${amount.toStringAsFixed(2)}';
  }

  String get displayDate {
    final parts = date.split(',');
    return parts.length > 1 ? parts[0].trim() : date;
  }
}

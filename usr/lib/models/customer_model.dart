class Customer {
  final String id;
  final String last4Digits;
  final String locationName;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final String? orderId;
  bool isCompleted;

  Customer({
    required this.id,
    required this.last4Digits,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.orderId,
    this.isCompleted = false,
  });
}

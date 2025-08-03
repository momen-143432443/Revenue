class CustomerService {
  final String senderId;
  final String recevierId;
  final String message;
  final String email;
  final DateTime timestamp;

  CustomerService({
    required this.senderId,
    required this.recevierId,
    required this.message,
    required this.email,
    required this.timestamp,
  });

  Map<String, dynamic> toCartJson() => {
        "senderId": senderId,
        "message": message,
        "userEmail": email,
      };

  factory CustomerService.fromMap(Map<String, dynamic> map) {
    return CustomerService(
      senderId: map['senderId'] ?? "",
      recevierId: map['recevierId'] ?? "",
      message: map['message'] ?? "",
      email: map['userEmail']??"",
      timestamp: DateTime.tryParse(map['timestamp'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

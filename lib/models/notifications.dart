class Notification {
  Notification(
      { 
      required this.customerId,
      required this.message,
      required this.status
      });

  final String customerId;
  final String message;
  final bool status;

  Map<String, dynamic> toMap() {
    return {
      "customerId": customerId,
      'message': message,
      "status": status,
    };
  }



}

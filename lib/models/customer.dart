class Customer {
  Customer(
      {required this.username, required this.email, required this.phoneNo});

  final String username;
  final String email;
  final String phoneNo;



  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phoneNo': phoneNo,
    };
  }
  
}

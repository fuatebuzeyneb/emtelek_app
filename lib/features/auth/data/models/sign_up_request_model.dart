class SignUpRequestModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String accountType;

  SignUpRequestModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.accountType,
  });

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'Password': password,
      'AccountType': accountType,
    };
  }
}

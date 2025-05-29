// class AccountDataModel {
//   final int? clientId;
//   final String? firstName;
//   final String? lastName;
//   final String? phoneNumber;
//   final String? email;
//   final String? password;
//   final String? subscriptionDate;
//   final int? status;
//   final int? accountType;
//   final String? image;
//   final int? verified;

//   AccountDataModel({
//     this.clientId,
//     this.firstName,
//     this.lastName,
//     this.phoneNumber,
//     this.email,
//     this.password,
//     this.subscriptionDate,
//     this.status,
//     this.accountType,
//     this.image,
//     this.verified,
//   });

//   factory AccountDataModel.fromJson(Map<String, dynamic> json) {
//     return AccountDataModel(
//       clientId: json['ClientId'],
//       firstName: json['FirstName'],
//       lastName: json['LastName'],
//       phoneNumber: json['PhoneNumber'],
//       email: json['Email'],
//       password: json['Password'],
//       subscriptionDate: json['SubscriptionDate'],
//       status: json['Status'],
//       accountType: json['AccountType'],
//       image: json['Image'],
//       verified: json['Verified'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'ClientId': clientId,
//       'FirstName': firstName,
//       'LastName': lastName,
//       'PhoneNumber': phoneNumber,
//       'Email': email,
//       'Password': password,
//       'SubscriptionDate': subscriptionDate,
//       'Status': status,
//       'AccountType': accountType,
//       'Image': image,
//       'Verified': verified,
//     };
//   }
// }

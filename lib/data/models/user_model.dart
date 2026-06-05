class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String? address;
  final String? phoneNumber;
  final bool billRemainders;
  final bool notificationRemainder;
  final String type;
  final String? gender;
  final String? dateOfBirth;
  final String createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.address,
    this.phoneNumber,
    required this.billRemainders,
    required this.notificationRemainder,
    required this.type,
    this.gender,
    this.dateOfBirth,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'].toString(),
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    avatar: json['avatar'],
    address: json['address'],
    phoneNumber: json['phone_number'],
    billRemainders: json['bill_remainders'] ?? false,
    notificationRemainder: json['notification_remainder'] ?? false,
    type: json['type'] ?? 'user',
    gender: json['gender'],
    dateOfBirth: json['date_of_birth'],
    createdAt: json['created_at'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'avatar': avatar,
    'address': address,
    'phone_number': phoneNumber,
    'bill_remainders': billRemainders,
    'notification_remainder': notificationRemainder,
    'type': type,
    'gender': gender,
    'date_of_birth': dateOfBirth,
    'created_at': createdAt,
  };
}

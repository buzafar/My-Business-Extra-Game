class UserModel {

  final int id;
  final String createdAt;
  final String email;
  num balance;
  final String userId;

  UserModel({required this.id, required this.createdAt, required this.email, required this.balance, required this.userId});


  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      createdAt: map['created_at'],
      email: map['email'],
      balance: map['balance'],
      userId: map['user_id']
    );
  }

  UserModel copyWith({
    int? id,
    String? createdAt,
    String? email,
    num? balance,
    String? userId,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      userId: userId ?? this.userId,
    );
  }
}
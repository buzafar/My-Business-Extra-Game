class UserFactory {

  final int id;
  final String createdAt;
  final int userId;
  final int factoryId;
  DateTime lastProduced;
  final int requiredSeconds;

  UserFactory({required this.id, required this.createdAt, required this.userId, required this.factoryId, required this.lastProduced, required this.requiredSeconds});

  factory UserFactory.fromJson(Map<String, dynamic> map) {
    return UserFactory(
      id: map['id'],
      createdAt: map['created_at'],
      userId: map['user_id'],
      factoryId: map['factory_id'],
      lastProduced: DateTime.parse(map['last_produced']),
      requiredSeconds: map['required_seconds']
    );
}

}
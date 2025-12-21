class UserFactory {
  final int id;
  final String createdAt;
  final int userId;
  final int factoryId;
  DateTime lastProduced;
  int requiredSeconds;
  double productionCost;
  int outputSlots;

  UserFactory({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.factoryId,
    required this.lastProduced,
    required this.requiredSeconds,
    required this.productionCost,
    required this.outputSlots,
  });

  factory UserFactory.fromJson(Map<String, dynamic> map) {
    return UserFactory(
      id: map['id'],
      createdAt: map['created_at'],
      userId: map['user_id'],
      factoryId: map['factory_id'],
      lastProduced: DateTime.parse(map['last_produced']),
      requiredSeconds: map['required_seconds'],
      productionCost: map['production_cost'],
      outputSlots: map['output_slots'],
    );
  }

  UserFactory copyWith({
    int? id,
    String? createdAt,
    int? userId,
    int? factoryId,
    DateTime? lastProduced,
    int? requiredSeconds,
    double? productionCost,
    int? outputSlots,
  }) {
    return UserFactory(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      factoryId: factoryId ?? this.factoryId,
      lastProduced: lastProduced ?? this.lastProduced,
      requiredSeconds: requiredSeconds ?? this.requiredSeconds,
      productionCost: productionCost ?? this.productionCost,
      outputSlots: outputSlots ?? this.outputSlots,
    );
  }
}

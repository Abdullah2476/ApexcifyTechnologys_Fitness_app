class Usermodal {
  String userId;
  String name;
  String email;
  String dateOfBirth;
  double weight;
  int height;
  int targetSteps;
  int logSteps;

  Usermodal({
    required this.userId,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.weight,
    required this.height,
    required this.targetSteps,
    required this.logSteps,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'weight': weight,
      'height': height,
      'targetSteps': targetSteps,
    };
  }

  factory Usermodal.fromMap(Map<String, dynamic> map) {
    return Usermodal(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      weight: (map['weight'] ?? 0).toDouble(),
      height: (map['height'] ?? 0),
      targetSteps: (map['targetSteps'] ?? 5000),
      logSteps: (map['logSteps'] ?? 5000),
    );
  }
}

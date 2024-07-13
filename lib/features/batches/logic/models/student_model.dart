class StudentModel {
  String id;
  String name;
  String enrollmentId;
  int jupiterCoins;
  String studentProfile;
  String whatsApp;
  String phone;

  StudentModel({
    required this.id,
    required this.name,
    required this.enrollmentId,
    required this.jupiterCoins,
    required this.studentProfile,
    required this.whatsApp,
    required this.phone,
  });

  factory StudentModel.fromJson(json) {
    return StudentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      enrollmentId: json['enrollmentId'] ?? '',
      jupiterCoins: json['jupiterCoins'] ?? '',
      studentProfile: json['studentProfile'] ?? '',
      whatsApp: json['whatsApp'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

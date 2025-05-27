class ProfileModel {
  String name;
  String rollNo;
  String emailId;

  ProfileModel({
    required this.name,
    required this.rollNo,
    required this.emailId,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      rollNo: json['rollNo'] ?? '',
      emailId: json['emailId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rollNo': rollNo,
      'emailId': emailId,
    };
  }
}

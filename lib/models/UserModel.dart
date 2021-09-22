class UserModel {
  final String id;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String phone;
  final String roleType;
  final String username;
  final String status;
  final String civilId;
  final String mobile;
  final String loyaltyPoints;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.roleType,
    this.username,
    this.status,
    this.civilId,
    this.mobile,
    this.loyaltyPoints
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      email: json['email'].toString(),
      emailVerifiedAt: json['email_verified_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      phone: json['phone'].toString(),
      roleType: json['role_type'].toString(),
      username: json['username'].toString(),
      status: json['status'].toString(),
      civilId: json['civil_id'].toString(),
      mobile: json['mobile'].toString(),
      loyaltyPoints: json['loyalty_points'].toString(),
    );
  }
}

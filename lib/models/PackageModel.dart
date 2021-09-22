class PackageModel {
  final String id;
  final String vehicleId;
  final String vehicleType;
  final String duration;
  final String mileage;
  final String installment;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  PackageModel({
    this.id,
    this.vehicleId,
    this.vehicleType,
    this.duration,
    this.mileage,
    this.installment,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'].toString(),
      vehicleId: json['vehicle_id'].toString(),
      vehicleType: json['vehicle_type'].toString(),
      duration: json['duration'].toString(),
      mileage: json['mileage'].toString(),
      installment: json['installment'].toString(),
      deletedAt: json['deleted_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}

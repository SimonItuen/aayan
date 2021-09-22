class SubModelModel {
  final String id;
  final String model;
  final String brand;
  final String subModel;
  final String createdAt;
  final String updatedAt;
  final String image;

  SubModelModel({
    this.model,
    this.brand,
    this.subModel,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory SubModelModel.fromJson(Map<String, dynamic> json) {
    return SubModelModel(
      id: json['id'].toString(),
      model: json['model'].toString(),
      brand: json['brand'].toString(),
      subModel: json['sub_model'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      image: json['image'].toString(),
    );
  }
}

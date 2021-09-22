class ModelModel {
  final String id;
  final String model;
  final String brand;
  final String carModelVariant;
  final String createdAt;
  final String updatedAt;
  final String image;

  ModelModel({
    this.model,
    this.brand,
    this.carModelVariant,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory ModelModel.fromJson(Map<String, dynamic> json) {
    return ModelModel(
      id: json['id'].toString(),
      model: json['model'].toString(),
      brand: json['brand'].toString(),
      carModelVariant: json['car_model_variant'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      image: json['image'].toString(),
    );
  }
}

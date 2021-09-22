class CarDetailModel {
  final String id;
  final String brand;
  final String model;
  final String year;
  final String carName;
  final String price;
  final String feature;
  final String status;
  final String imageName;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  CarDetailModel({
    this.id,
    this.brand,
    this.model,
    this.year,
    this.carName,
    this.price,
    this.feature,
    this.imageName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.status,
  });
  factory CarDetailModel.fromJson(Map<String, dynamic> json) {
    return CarDetailModel(
      id: json['id'].toString(),
      brand: json['brand'].toString(),
      model: json['model'].toString(),
      year: json['year'].toString(),
      carName: json['car_name'].toString(),
      price: json['price'].toString(),
      feature: json['featured'].toString(),
      imageName: json['image_name'].toString(),
      status: json['status'].toString(),
      deletedAt: json['deleted_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}

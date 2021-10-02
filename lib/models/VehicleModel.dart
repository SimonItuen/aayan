class VehicleModel {
  final String id;
  final String rn;
  final String brand;
  final String altBrand;
  final String model;
  final String altModel;
  final String year;
  final String carName;
  final String mileage;
  final String price;
  final String feature;
  final String status;
  final String imageName;
  final String altCarName;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  VehicleModel({
    this.id,
    this.rn,
    this.brand,
    this.model,
    this.altBrand,
    this.altModel,
    this.year,
    this.carName,
    this.altCarName,
    this.mileage,
    this.price,
    this.feature,
    this.imageName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.status,
  });


  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'].toString(),
      rn: json['rn'].toString(),
      brand: json['brand'].toString(),
      model: json['model'].toString(),
      altBrand: json['alt_brand'].toString(),
      altModel: json['alt_model'].toString(),
      year: json['year'].toString(),
      carName: json['car_name']??(json['brand'].toString()+json['model'].toString()+json['year'].toString()),
      altCarName: json['alt_car_name']??(json['alt_brand'].toString()+json['alt_model'].toString()+json['year'].toString()),
      price: json['price'].toString(),
      feature: json['featured'].toString(),
      mileage: json['mileage'].toString(),
      imageName: json['image_name'].toString(),
      status: json['status'].toString(),
      deletedAt: json['deleted_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}

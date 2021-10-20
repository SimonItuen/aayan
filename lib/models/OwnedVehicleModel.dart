class OwnedVehicleModel {
  final String id;
  final String brand;
  final String altBrand;
  final String model;
  final String modelVariantId;
  final String altModel;
  final String year;
  final String carName;
  final String price;
  final String status;
  final String imageName;
  final String altCarName;

  OwnedVehicleModel({
    this.id,
    this.brand,
    this.model,
    this.modelVariantId,
    this.altBrand,
    this.altModel,
    this.year,
    this.carName,
    this.altCarName,
    this.price,
    this.imageName,
    this.status,
  });


  factory OwnedVehicleModel.fromJson(Map<String, dynamic> json) {
    return OwnedVehicleModel(
      id: json['id'].toString(),
      brand: json['brand'].toString(),
      model: json['model'].toString(),
      modelVariantId: json['model_variant_id'].toString(),
      altBrand: json['alt_brand'].toString(),
      altModel: json['alt_model'].toString(),
      year: json['year'].toString(),
      carName: json['car_name']??(json['brand'].toString()+json['model'].toString()+json['year'].toString()),
      altCarName: json['alt_car_name']??(json['alt_brand'].toString()+json['alt_model'].toString()+json['year'].toString()),
      price: json['price'].toString(),
      imageName: json['image_name'].toString(),
      status: json['status'].toString(),
    );
  }
}

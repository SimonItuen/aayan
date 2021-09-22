import 'package:Aayan/models/CarDetailModel.dart';

class FeaturedVehicleModel {
  final String id;
  final String vehicleType;
  final String leaseCar;
  final String usedCar;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String imageName;
  final String brand;
  final String year;
  final String model;
  final String price;
  final String carName;

  FeaturedVehicleModel( {
    this.id,
    this.vehicleType,
    this.leaseCar,
    this.usedCar, this.brand,
    this.year,
    this.model,
    this.carName,
    this.price,
    this.imageName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory FeaturedVehicleModel.fromJson(Map<String, dynamic> json) {

    return FeaturedVehicleModel(
      id: json['id'].toString(),
      vehicleType: json['vehicle_type'].toString(),
      leaseCar: json['lease_car'].toString(),
      usedCar: json['used_car'].toString(),
      brand: json['brand'].toString(),
      model: json['model'].toString(),
      carName: json['brand'].toString()+' '+json['model'].toString()+' '+json['year'].toString(),
      year: json['year'].toString(),
      price: json['price'].toString(),
      imageName: json['image_name'].toString(),
    );
  }
}

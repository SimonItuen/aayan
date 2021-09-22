import 'package:Aayan/models/PackageModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/services/HttpService.dart';

class VehicleDetailModel {
  final String id;
  final String brand;
  final String model;
  final String year;
  final String carName;
  final String mileage;
  final String price;
  final String feature;
  final String status;
  final String imageName;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;
  final List<PackageModel> packageList;
  final List<VehicleModel> similarVehicleList;
  final List<String> imageList;

  VehicleDetailModel({
    this.id,
    this.brand,
    this.model,
    this.year,
    this.carName,
    this.mileage,
    this.price,
    this.feature,
    this.imageName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.status,
    this.packageList,
    this.similarVehicleList,
    this.imageList,
  });

  factory VehicleDetailModel.fromJson(Map<String, dynamic> json) {
    List<PackageModel> packageList = [];
    List<VehicleModel> similarVehicleList = [];
    List<String> imageList = [];

    if (json['images'] != null) {
      for (Map i in json['images']) {
        imageList.add('https://aayan.creativity.com.kw/${i['path']}');
      }
    }

    if (json['packages'] != null) {
      for (Map i in json['packages']) {
        print(i);
        packageList.add(PackageModel.fromJson(i));
      }
    }
    if (json['similar_vehicles'] != null) {
      for (Map i in json['similar_vehicles']) {
        print(i);
        similarVehicleList.add(VehicleModel.fromJson(i));
      }
    }
    return VehicleDetailModel(
      id: json['id'].toString(),
      brand: json['brand'].toString(),
      model: json['model'].toString(),
      year: json['year'].toString(),
      carName: json['brand'].toString() +
          ' ' +
          json['model'].toString() +
          ' ' +
          json['year'].toString(),
      price: json['price'].toString(),
      feature: json['feature'].toString(),
      mileage: json['mileage'].toString(),
      imageName: json['image_name'].toString(),
      imageList: imageList,
      status: json['status'].toString(),
      packageList: packageList,
      similarVehicleList: similarVehicleList,
      deletedAt: json['deleted_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}

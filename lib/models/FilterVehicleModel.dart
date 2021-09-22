import 'package:Aayan/models/ModelModel.dart';

class FilterVehicleModel {
  String brand;
  ModelModel model;
  String subModel;
  String year;
  String leasePeriod;
  String minPrice;
  String maxPrice;

  FilterVehicleModel(
      {this.brand,
      this.model,
      this.subModel,
      this.year,
      this.leasePeriod,
      this.minPrice,
      this.maxPrice});
}

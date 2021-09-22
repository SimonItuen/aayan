class LeaseAddonModel {
  final String id;
  final String addon;
  final String status;
  final String price;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  LeaseAddonModel({
    this.id,
    this.addon,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.status,
    this.price,
  });

  factory LeaseAddonModel.fromJson(Map<String, dynamic> json) {
    return LeaseAddonModel(
      id: json['id'].toString(),
      addon: json['addon'].toString(),
      status: json['status'].toString(),
      price: json['price'].toString(),
      deletedAt: json['deleted_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}

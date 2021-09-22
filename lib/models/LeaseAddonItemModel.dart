class LeaseAddonItemModel {
  final String id;
  final String leasingAddonId;
  final String item;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  LeaseAddonItemModel({
    this.id,
    this.leasingAddonId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.item,
  });

  factory LeaseAddonItemModel.fromJson(Map<String, dynamic> json) {
    return LeaseAddonItemModel(
      id: json['id'].toString(),
      leasingAddonId: json['leasing_addon_id'].toString(),
      item: json['item'].toString(),
      deletedAt: json['deleted_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}

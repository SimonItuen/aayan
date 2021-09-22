class BannerModel {
  final String id;
  final String linkType;
  final String externalLink;
  final String leaseCar;
  final String usedCar;
  final String sortOrder;
  final String bannerImage;
  final String status;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  BannerModel({
    this.id,
    this.linkType,
    this.externalLink,
    this.leaseCar,
    this.usedCar,
    this.sortOrder,
    this.bannerImage,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.status,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'].toString(),
      linkType: json['link_type'].toString(),
      externalLink: json['external_link'].toString(),
      leaseCar: json['lease_car'].toString(),
      usedCar: json['used_car'].toString(),
      sortOrder: json['sort_order'].toString(),
      status: json['status'].toString(),
      deletedAt: json['deleted_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      bannerImage: json['banner_image'].toString(),
    );
  }
}

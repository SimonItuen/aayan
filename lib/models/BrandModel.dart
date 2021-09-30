class BrandModel {
  final String id;
  final String title;
  final String arTitle;
  final String status;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;
  final String image;
  

  BrandModel({
    this.id,
    this.title,
    this.arTitle,
    this.createdAt,
    this.updatedAt,this.deletedAt,
    this.status,
    this.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      arTitle: json['ar_title'].toString(),
      status: json['status'].toString(),
      deletedAt: json['deleted_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      image: json['image'].toString(),
    );
  }
}

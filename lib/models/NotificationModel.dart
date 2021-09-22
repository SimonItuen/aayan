class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String schedule;
  final String userType;
  final String timeDiff;
  final String imageUrl;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.schedule,
    this.userType,
    this.timeDiff,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      imageUrl: json['image_url'].toString(),
      schedule: json['schedule'].toString(),
      userType: json['used_type'].toString(),
      timeDiff: json['time_diff'].toString(),
      deletedAt: json['deleted_at'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}

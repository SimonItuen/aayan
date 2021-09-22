import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PageInfoModel {
  int currentPage = 1;
  int lastPage = 1;

  PageInfoModel({this.currentPage=1, this.lastPage});

  factory PageInfoModel.fromJson(Map<String, dynamic> json) {
    print('Chris ${json['current_page']} >= ${json['last_page']}');
    return PageInfoModel(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
    );
  }

  void incrementPageNumber() {
    if (currentPage < lastPage) {
      currentPage++;

    }
  }
}

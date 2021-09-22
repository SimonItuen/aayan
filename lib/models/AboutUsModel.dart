class AboutUsModel{
  final String eng;
  final String arb;

  AboutUsModel({this.eng, this.arb});

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      eng: json['about_us_eng'].toString(),
      arb: json['about_us_arabic'].toString(),
    );
  }
}
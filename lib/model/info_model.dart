class InfoModel {
  InfoModel({
    this.message,
    this.data,
  });

  final String? message;
  final Data? data;

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.title,
    this.poweredBy,
    this.framework,
    this.createdAt,
  });

  final String? title;
  final String? poweredBy;
  final String? framework;
  final DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        poweredBy: json["powered_by"],
        framework: json["framework"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );
}

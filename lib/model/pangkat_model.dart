import 'dart:convert';

class PangkatModel {
  PangkatModel({
    required this.message,
    required this.page,
    required this.perpage,
    required this.total_data,
    required this.total_page,
    required this.data,
  });

  String message;
  int page;
  int perpage;
  int total_data;
  int total_page;

  List<Data> data;

  factory PangkatModel.fromJson(Map<String, dynamic> json) => PangkatModel(
        message: json["message"],
        page: json["page"],
        perpage: json["perpage"],
        total_data: json["total_data"],
        total_page: json["total_page"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "perpage": perpage,
        "total_data": total_data,
        "total_data": total_data,
        "total_page": total_page,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data(
      {required this.pangkat,
      required this.nomorSk,
      required this.tmt,
      required this.no,
      required this.jenisKenaikan});

  String pangkat;
  String nomorSk;
  String tmt;
  String no;
  String jenisKenaikan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      pangkat: json["pangkat"],
      nomorSk: json["nomor_sk"],
      tmt: json["tmt"],
      no: json["no"],
      jenisKenaikan: json["jenis_kenaikan"]);

  Map<String, dynamic> toJson() => {
        "pangkat": pangkat,
        "nomor_sk": nomorSk,
        "tmt": tmt,
        "no": no,
        "jenis_kenaikan": jenisKenaikan
      };
}

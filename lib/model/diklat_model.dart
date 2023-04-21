import 'dart:convert';

class DiklatModel {
  DiklatModel({
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

  factory DiklatModel.fromJson(Map<String, dynamic> json) => DiklatModel(
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
      {required this.namaDiklat,
      required this.nomor_sttpp,
      required this.tahun,
      required this.no,
      required this.unitkerja});

  String namaDiklat;
  String nomor_sttpp;
  String tahun;
  String no;
  String unitkerja;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      namaDiklat: json["nama_diklat"],
      nomor_sttpp: json["nomor_sttpp"],
      tahun: json["tahun"],
      no: json["no"],
      unitkerja: json["jenis_diklat"]);

  Map<String, dynamic> toJson() => {
        "nama_diklat": namaDiklat,
        "nomor_sttpp": nomor_sttpp,
        "tahun": tahun,
        "no": no,
        "jenis_diklat": unitkerja
      };
}

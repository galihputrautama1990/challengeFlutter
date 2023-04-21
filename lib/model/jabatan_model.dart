import 'dart:convert';

class JabatanModel {
  JabatanModel({
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

  factory JabatanModel.fromJson(Map<String, dynamic> json) => JabatanModel(
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
      {required this.namaJabatan,
      required this.nomorSk,
      required this.tmt,
      required this.no,
      required this.unitkerja});

  String namaJabatan;
  String nomorSk;
  String tmt;
  String no;
  String unitkerja;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      namaJabatan: json["nama_jabatan"],
      nomorSk: json["nomor_sk"],
      tmt: json["tmt"],
      no: json["no"],
      unitkerja: json["unit_kerja"]);

  Map<String, dynamic> toJson() => {
        "nama_jabatan": namaJabatan,
        "nomor_sk": nomorSk,
        "tmt": tmt,
        "no": no,
        "unit_kerja": unitkerja
      };
}

// To parse this JSON data, do
//
//     final profilModel = profilModelFromJson(jsonString);

import 'dart:convert';

class ProfilModel {
  ProfilModel({
    required this.nama,
    required this.fingerId,
    required this.nik,
    required this.tempatLahir,
    required this.jabatan,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.eselon,
    required this.pangkatGolonganRuang,
    required this.pangkat,
    required this.satuanOrganisasiId,
    required this.golonganRuang,
    required this.nipLama,
    required this.nipx,
    required this.photo,
    required this.satker,
    required this.pendidikanTerakhir,
    required this.jenjangPendidikanTerakhir,
    required this.jurusan,
    required this.namaSekolah,
    required this.satuanOrganisasiIdLen,
    required this.namaJabatan,
    required this.statusPegawai,
    required this.berkalaTerakhir,
    required this.opdId,
    required this.opd,
    required this.agama,
    required this.tmtCpns,
    required this.tmtPns,
    required this.karpeg,
    required this.jenisJabatan,
  });

  String nama;
  String fingerId;
  String nik;
  String tempatLahir;
  String jabatan;
  String jenisKelamin;
  String tanggalLahir;
  String eselon;
  String pangkatGolonganRuang;
  String pangkat;
  String satuanOrganisasiId;
  String golonganRuang;
  String nipLama;
  String nipx;
  String photo;
  String satker;
  String pendidikanTerakhir;
  String jenjangPendidikanTerakhir;
  String jurusan;
  String namaSekolah;
  int satuanOrganisasiIdLen;
  String namaJabatan;
  String statusPegawai;
  String berkalaTerakhir;
  String opdId;
  String opd;
  String agama;
  String tmtCpns;
  String tmtPns;
  String karpeg;
  String jenisJabatan;

  factory ProfilModel.fromJson(Map<String, dynamic> json) => ProfilModel(
        nama: json["nama"],
        fingerId: json["finger_id"],
        nik: json["nik"],
        tempatLahir: json["tempat_lahir"],
        jabatan: json["jabatan"],
        jenisKelamin: json["jenis_kelamin"],
        tanggalLahir: json["tanggal_lahir"],
        eselon: json["eselon"],
        pangkatGolonganRuang: json["pangkat_golongan_ruang"],
        pangkat: json["pangkat"],
        satuanOrganisasiId: json["SatuanOrganisasiID"],
        golonganRuang: json["golongan_ruang"],
        nipLama: json["nip_lama"],
        nipx: json["nipx"],
        photo: json["photo"],
        satker: json["satker"],
        pendidikanTerakhir: json["pendidikan_terakhir"],
        jenjangPendidikanTerakhir: json["jenjang_pendidikan_terakhir"],
        jurusan: json["jurusan"],
        namaSekolah: json["nama_sekolah"],
        satuanOrganisasiIdLen: json["SatuanOrganisasiID_len"],
        namaJabatan: json["nama_jabatan"],
        statusPegawai: json["status_pegawai"],
        berkalaTerakhir: json["berkala_terakhir"],
        opdId: json["OpdID"],
        opd: json["opd"],
        agama: json["agama"],
        tmtCpns: json["tmt_cpns"],
        tmtPns: json["tmt_pns"],
        karpeg: json["karpeg"],
        jenisJabatan: json["jenis_jabatan"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "finger_id": fingerId,
        "nik": nik,
        "tempat_lahir": tempatLahir,
        "jabatan": jabatan,
        "jenis_kelamin": jenisKelamin,
        "tanggal_lahir": tanggalLahir,
        "eselon": eselon,
        "pangkat_golongan_ruang": pangkatGolonganRuang,
        "pangkat": pangkat,
        "SatuanOrganisasiID": satuanOrganisasiId,
        "golongan_ruang": golonganRuang,
        "nip_lama": nipLama,
        "nipx": nipx,
        "photo": photo,
        "satker": satker,
        "pendidikan_terakhir": pendidikanTerakhir,
        "jenjang_pendidikan_terakhir": jenjangPendidikanTerakhir,
        "jurusan": jurusan,
        "nama_sekolah": namaSekolah,
        "SatuanOrganisasiID_len": satuanOrganisasiIdLen,
        "nama_jabatan": namaJabatan,
        "status_pegawai": statusPegawai,
        "berkala_terakhir": berkalaTerakhir,
        "OpdID": opdId,
        "opd": opd,
        "agama": agama,
        "tmt_cpns": tmtCpns,
        "tmt_pns": tmtPns,
        "karpeg": karpeg,
        "jenis_jabatan": jenisJabatan,
      };
}

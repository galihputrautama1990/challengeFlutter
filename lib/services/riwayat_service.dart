import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';

import 'package:flutter_training/model/pangkat_model.dart';
import 'package:flutter_training/model/jabatan_model.dart';
import 'package:flutter_training/model/diklat_model.dart';
import 'package:flutter_training/model/profil_model.dart';
import 'package:flutter_training/utils/wrapper.dart';

class RiwayatService {
  final Dio dio;
  RiwayatService(this.dio);

  Future<PangkatModel> getPangkat() async {
    return await Wrapper<PangkatModel>().wrap(
      () async {
        final response = await dio.get("");
        final result = PangkatModel.fromJson(response.data);
        return result;
      },
    );
  }

  Future<JabatanModel> getJabatan() async {
    return await Wrapper<JabatanModel>().wrap(
      () async {
        final response = await dio.get("");
        final result = JabatanModel.fromJson(response.data);
        return result;
      },
    );
  }

  Future<DiklatModel> getDiklat() async {
    return await Wrapper<DiklatModel>().wrap(
      () async {
        final response = await dio.get("");
        final result = DiklatModel.fromJson(response.data);
        return result;
      },
    );
  }

  Future<ProfilModel> getProfil() async {
    return await Wrapper<ProfilModel>().wrap(
      () async {
        final response = await dio.get("");
        final result = ProfilModel.fromJson(response.data);
        return result;
      },
    );
  }
}

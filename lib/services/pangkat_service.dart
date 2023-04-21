import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';

import 'package:flutter_training/model/pangkat_model.dart';
import 'package:flutter_training/sources/data_source.dart';
import 'package:flutter_training/utils/api_path.dart';
import 'package:flutter_training/utils/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PangkatService {
  final Dio dio;
  PangkatService(this.dio);

  Future<PangkatModel> getPangkat() async {
    return await Wrapper<PangkatModel>().wrap(
      () async {
        final response = await dio.get("");
        final result = PangkatModel.fromJson(response.data);
        return result;
      },
    );
  }
}

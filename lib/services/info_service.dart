import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_training/model/info_model.dart';
import 'package:flutter_training/sources/network_source.dart';
import 'package:flutter_training/utils/api_path.dart';
import 'package:flutter_training/utils/wrapper.dart';

class InfoService {
  final Dio dio;

  InfoService(this.dio);

  Future<InfoModel> getInfo() async {
    return await Wrapper<InfoModel>().wrap(
      () async {
        final response = await dio.get(info);
        final result = InfoModel.fromJson(response.data);
        return result;
      },
    );
  }
}

import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';

import 'package:flutter_training/model/login_model.dart';
import 'package:flutter_training/sources/session_source.dart';
import 'package:flutter_training/utils/api_path.dart';
import 'package:flutter_training/utils/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio;
  final param = '';
  AuthService(this.dio);

  Future<LoginModel> doLogin(Map<String, dynamic> payload) async {
    return await Wrapper<LoginModel>().wrap(
      () async {
        final formData = FormData.fromMap(payload);
        final response = await dio.post(login, data: formData);
        final result = LoginModel.fromJson(response.data);
        await SessionSource().saveToken(result.data!.token!, result.data!.nama!,
            result.data!.nip!, result.data!.opd!);
        return result;
      },
    );
  }
}

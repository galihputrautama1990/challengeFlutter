import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkSource {
  static Dio dio() {
    final dio = Dio();
    dio.options = BaseOptions(
      headers: {
        "Authorization": "Basic dHJhaW5pbmc6dHJhaW5pbmc",
      },
      baseUrl: 'http://bkd.blitarkota.go.id/siap-api/index.php/login_personal/',
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    );

    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }

  static Dio dioPangkat(nip, page) {
    final dio = Dio();
    dio.options = BaseOptions(
      headers: {
        "Authorization": "Basic dHJhaW5pbmc6dHJhaW5pbmc",
      },
      baseUrl: 'http://bkd.blitarkota.go.id/siap-api/riwayat_pangkat/' +
          nip +
          '/' +
          page.toString(),
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    );

    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }

  static Dio dioRiwayat(nip, riwayat, page) {
    final dio = Dio();
    dio.options = BaseOptions(
      headers: {
        "Authorization": "Basic dHJhaW5pbmc6dHJhaW5pbmc",
      },
      baseUrl: 'http://bkd.blitarkota.go.id/siap-api/riwayat_' +
          riwayat +
          '/' +
          nip +
          '/' +
          page.toString(),
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    );

    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }

  static Dio dioProfil(nip) {
    final dio = Dio();
    dio.options = BaseOptions(
      headers: {
        "Authorization": "Basic dHJhaW5pbmc6dHJhaW5pbmc",
      },
      baseUrl: 'https://bkd.blitarkota.go.id/siap-api/asn/' + nip,
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    );

    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }

  static Dio dioDetail() {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl:
          'https://bkd.blitarkota.go.id/siap-api/index.php/login_personal/MTk5MDA4MjcyMDE1MDExMDAx/MTEzNA==',
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    );

    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }

  static Dio mockDio() {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: 'https://mock.apidog.com/m1/361910-0-default',
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    );

    return dio;
  }
}

import 'dart:async';

import 'package:dio/dio.dart';

class Wrapper<T> {
  Future<T> wrap(Future<T> Function() futureFunction) async {
    try {
      // print("Wrap Start");
      final result = await futureFunction();
      return result;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 400) {
          throw Exception(e.response!.data['message']);
        } else {
          throw Exception("Api Errr");
        }
      } else {
        rethrow;
      }
    }
  }

  Future<void> wrapBloc(StreamController<T> controller,
      Future<T> Function() futureFunction) async {
    try {
      final response = await futureFunction();
      controller.add(response);
    } catch (error) {
      controller.addError(error);
    }
  }
}

// Class Wrapper<T anything>, Wrapper<String>
// Function Future<T>, wrap, Fu

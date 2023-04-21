import 'dart:async';

import 'package:flutter_training/model/info_model.dart';
import 'package:flutter_training/services/info_service.dart';
import 'package:flutter_training/sources/network_source.dart';
import 'package:flutter_training/utils/wrapper.dart';

class InfoBloc {
  final _stream = StreamController<InfoModel>(); // controller, emit here
  Stream<InfoModel> get stream => _stream.stream; // will represent the stream

  Future<void> getInfo() async {
    Wrapper<InfoModel>().wrapBloc(
      _stream,
      () async {
        return await InfoService(NetworkSource.dio()).getInfo();
      },
    );
  }
}

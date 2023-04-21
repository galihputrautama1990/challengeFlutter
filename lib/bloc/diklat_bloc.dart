import 'dart:async';
import 'dart:convert';

import 'package:flutter_training/services/riwayat_service.dart';
import 'package:flutter_training/sources/network_source.dart';
import 'package:flutter_training/utils/wrapper.dart';

// enum DiklatState { init, loading, success, failure }

abstract class DiklatState {}

class DiklatInit implements DiklatState {}

class DiklatError implements DiklatState {
  final String message;
  DiklatError(this.message);
}

class DiklatSuccess implements DiklatState {
  final String message;
  final int current_page;
  final int total_page;
  DiklatSuccess(this.message, this.current_page, this.total_page);
}

class DiklatLoading implements DiklatState {
  // print("Diklat Loading");
}

class DiklatBloc {
  DiklatBloc() {
    _state.sink.add(DiklatInit());
  }

  final _state = StreamController<DiklatState>();
  Stream<DiklatState> get state => _state.stream;

  Future<void> Diklat(nip, riwayat, page) async {
    _state.sink.add(DiklatLoading());
    try {
      final result =
          await RiwayatService(NetworkSource.dioRiwayat(nip, riwayat, page))
              .getDiklat();
      final resultString = jsonEncode(result.data);
      final total_page = result.total_page;
      final current_page = result.page;
      _state.sink.add(DiklatSuccess(resultString, current_page, total_page));
    } catch (e) {
      _state.sink.add(DiklatError(e.toString()));
    }
  }
}

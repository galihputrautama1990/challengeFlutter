import 'dart:async';
import 'dart:convert';
import 'package:flutter_training/services/riwayat_service.dart';
import 'package:flutter_training/sources/network_source.dart';
import 'package:flutter_training/utils/wrapper.dart';

import '../sources/session_source.dart';

// enum JabatanState { init, loading, success, failure }

abstract class JabatanState {}

class JabatanInit implements JabatanState {}

class JabatanError implements JabatanState {
  final String message;
  JabatanError(this.message);
}

class JabatanSuccess implements JabatanState {
  final String message;
  final int current_page;
  final int total_page;
  JabatanSuccess(this.message, this.current_page, this.total_page);
}

class JabatanLoading implements JabatanState {
  // print("Jabatan Loading");
}

class JabatanBloc {
  JabatanBloc() {
    _state.sink.add(JabatanInit());
  }

  final _state = StreamController<JabatanState>();
  Stream<JabatanState> get state => _state.stream;

  Future<void> Jabatan(nip, riwayat, page) async {
    _state.sink.add(JabatanLoading());
    try {
      final result =
          await RiwayatService(NetworkSource.dioRiwayat(nip, riwayat, page))
              .getJabatan();
      final resultString = jsonEncode(result.data);
      final total_page = result.total_page;
      final current_page = result.page;
      _state.sink.add(JabatanSuccess(resultString, current_page, total_page));
    } catch (e) {
      _state.sink.add(JabatanError(e.toString()));
    }
  }
}

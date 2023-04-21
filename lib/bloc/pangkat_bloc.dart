import 'dart:async';
import 'dart:convert';

import 'package:flutter_training/model/info_model.dart';
import 'package:flutter_training/services/pangkat_service.dart';
import 'package:flutter_training/sources/network_source.dart';
import 'package:flutter_training/utils/wrapper.dart';

import '../services/riwayat_service.dart';
import '../sources/session_source.dart';

// enum PangkatState { init, loading, success, failure }

abstract class PangkatState {}

class PangkatInit implements PangkatState {}

class PangkatError implements PangkatState {
  final String message;
  PangkatError(this.message);
}

class PangkatSuccess implements PangkatState {
  final String message;
  final int current_page;
  final int total_page;
  PangkatSuccess(this.message, this.current_page, this.total_page);
}

class PangkatLoading implements PangkatState {
  // print("Pangkat Loading");
}

class PangkatBloc {
  PangkatBloc() {
    _state.sink.add(PangkatInit());
  }

  final _state = StreamController<PangkatState>();
  Stream<PangkatState> get state => _state.stream;

  Future<void> Pangkat(nip, riwayat, page) async {
    _state.sink.add(PangkatLoading());
    try {
      final result =
          await RiwayatService(NetworkSource.dioRiwayat(nip, riwayat, page))
              .getPangkat();
      final resultString = jsonEncode(result.data);
      final total_page = result.total_page;
      final current_page = result.page;
      _state.sink.add(PangkatSuccess(resultString, current_page, total_page));
    } catch (e) {
      _state.sink.add(PangkatError(e.toString()));
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter_training/model/profil_model.dart';
import 'package:flutter_training/sources/network_source.dart';
import 'package:flutter_training/utils/wrapper.dart';

import '../services/riwayat_service.dart';

// enum PangkatState { init, loading, success, failure }

abstract class ProfilState {}

class ProfilInit implements ProfilState {}

class ProfilError implements ProfilState {
  final String message;
  ProfilError(this.message);
}

class ProfilSuccess implements ProfilState {
  final String message;
  ProfilSuccess(this.message);
}

class ProfilLoading implements ProfilState {
  // print("Pangkat Loading");
}

class ProfilBloc {
  ProfilBloc() {
    _state.sink.add(ProfilInit());
  }

  final _state = StreamController<ProfilState>();
  Stream<ProfilState> get state => _state.stream;

  Future<void> Profil(nip) async {
    _state.sink.add(ProfilLoading());
    try {
      final result =
          await RiwayatService(NetworkSource.dioProfil(nip)).getProfil();
      final resultString = jsonEncode(result);
      _state.sink.add(ProfilSuccess(resultString));
    } catch (e) {
      _state.sink.add(ProfilError(e.toString()));
    }
  }
}

import 'dart:convert';

import 'package:flutter_training/model/info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionSource {
  final _token = '_token';

  Future<void> saveToken(
      String token, String nama, String nip, String opd) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("nama", nama);
    prefs.setString("nip", nip);
    prefs.setString("opd", opd);
    prefs.setString("fotoprofil",
        'http://bkd.blitarkota.go.id/sikoi/images/personal/' + nip + '.jpg');

    await prefs.setString(_token, token);
  }

  Future<void> saveData(String DataProfil) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("Data", DataProfil);
  }

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token);
  }

  Future<String?> readData(Data) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Data);
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_token);
  }
}

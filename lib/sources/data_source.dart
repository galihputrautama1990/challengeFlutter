import 'dart:convert';

import 'package:flutter_training/model/info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSource {
  final _token = '_token';

  Future<void> SaveData(String Data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("Data", Data);
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/sources/session_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';

import '../../bloc/diklat_bloc.dart';

class DiklatPage extends StatefulWidget {
  DiklatPage({super.key});

  @override
  State<DiklatPage> createState() => _DiklatPageState();
}

class _DiklatPageState extends State<DiklatPage> {
  String? Nama;
  String? Nip;
  String? Opd;
  String? Param;
  String? Riwayat = 'diklat';
  String? FotoProfil = "http://bkd.blitarkota.go.id/sikoi/images/logo.png";
  // final bloc_data = PangkatBloc();
  final bloc_data = DiklatBloc();
  int _current_page = 1;
  int _total_page = 0;
  List _DataDiklat = [];
  List _listPage = [];

  updateData() async {
    final token = SessionSource().readData('token');
    final nama = await SessionSource().readData('nama');
    final nip = await SessionSource().readData('nip');
    final opd = await SessionSource().readData('opd');
    final fotoprofil = await SessionSource().readData('fotoprofil');

    if (token != null) {
      setState(() {
        Nama = nama;
        Nip = nip;
        Opd = opd;
        FotoProfil = fotoprofil;
        bloc_data.Diklat(Nip, Riwayat, _current_page);
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void initState() {
    super.initState();
    updateData();
  }

  Future<void> _fetchData(
      String Pangkat, int current_page, int total_page) async {
    final data = json.decode(Pangkat);
    setState(() {
      _DataDiklat = data;
      _current_page = current_page;
      _total_page = total_page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.centerRight, child: Text("SIKOI")),
      ),
      drawer: Drawer_main(context, Nip, Nama, Opd, FotoProfil),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: StreamListener<DiklatState>(
                stream: bloc_data.state, // Stream being subscribed to
                onData: (data) {
                  if (data is DiklatLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(child: CircularProgressIndicator()),
                                SizedBox(height: 16),
                                Text("Please wait..."),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (data is DiklatError) {
                    Navigator.pop(context);
                    print(data);
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(data.message),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (data is DiklatSuccess) {
                    Navigator.pop(context);
                    // print(data.current_page);
                    _fetchData(
                        data.message, data.current_page, data.total_page);
                  }
                },
                onError: (error, stackTrace) {
                  print("ERROR");
                  // Optionally handle errors in the Stream
                },
                onDone: () {
                  print("Done");
                  // Optionally react to when the Stream is closed
                },
                cancelOnError: true,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Riwayat Pendidikan dan Pelatihan(DIklat)",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            child: Container(
                                height: 450,
                                width: 100,
                                child: _DataDiklat.isEmpty
                                    ? Center(
                                        child: Text("No Data"),
                                      )
                                    // The ListView that displays photos
                                    : ListView.builder(
                                        itemCount: _DataDiklat.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return Card(
                                            child: ListTile(
                                              leading: Text(_DataDiklat[index]
                                                      ["no"] +
                                                  "."),
                                              title: Text(_DataDiklat[index]
                                                  ['nama_diklat']),
                                              subtitle: Text(_DataDiklat[index]
                                                      ['jenis_diklat'] +
                                                  '\nNo SK: ' +
                                                  _DataDiklat[index]
                                                      ['nomor_sttpp'] +
                                                  "\n" +
                                                  "Tahun :  " +
                                                  _DataDiklat[index]['tahun']),
                                              // trailing: Icon(Icons.school)
                                            ),
                                          );
                                        },
                                      )),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              for (var i = 1; i <= _total_page; i++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap: () {
                                        (i != _current_page)
                                            ? bloc_data.Diklat(Nip, Riwayat, i)
                                            : print("Clicked");
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: (i == _current_page)
                                              ? Colors.grey
                                              : Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              i.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: (i == _current_page)
                                                      ? Colors.black
                                                      : Colors.white),
                                            )),
                                      )),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

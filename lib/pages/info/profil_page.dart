import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/model/diklat_model.dart';
import 'package:flutter_training/sources/session_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';
import '../../bloc/profil_bloc.dart';

class ProfilPage extends StatefulWidget {
  ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String? Nama;
  String? Nip;
  String? Opd;
  String? Param;
  String? Jabatan;
  String? Pangkat;
  String? Tmt_cpns;
  String? Tmt_pns;
  String? Agama;
  String? Status_pegawai;
  String? Pendidikan;
  List _DataProfil = [];
  String? FotoProfil = "http://bkd.blitarkota.go.id/sikoi/images/logo.png";
  final bloc_data = ProfilBloc();

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
        bloc_data.Profil(Nip);
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void initState() {
    super.initState();
    updateData();
  }

  Future<void> _fetchData(String Data) async {
    final data = json.decode(Data);
    setState(() {
      Jabatan = data['nama_jabatan'];
      Pendidikan = data['pendidikan_terakhir'];
      Pangkat = data['pangkat_golongan_ruang'];
      Agama = data['agama'];
      Tmt_cpns = data['tmt_cpns'];
      Tmt_pns = data['tmt_pns'];
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
              child: StreamListener<ProfilState>(
                stream: bloc_data.state, // Stream being subscribed to
                onData: (data) {
                  if (data is ProfilLoading) {
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
                  } else if (data is ProfilError) {
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
                  } else if (data is ProfilSuccess) {
                    Navigator.pop(context);

                    final _DataProfil = json.decode(data.message);
                    _fetchData(data.message);
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Data Profil",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Container(
                                  width: double.infinity,
                                  child: ListTile(
                                    leading: Image.network(
                                      "$FotoProfil",
                                      height: 250,
                                    ),
                                    title: Text('$Nama'),
                                    subtitle: Text('NIP : $Nip'),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Card(
                                  child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                                columnWidths: {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(1),
                                  2: FlexColumnWidth(8),
                                },
                                border: TableBorder.symmetric(
                                  outside: BorderSide.none,
                                  inside: const BorderSide(
                                      width: 1,
                                      color: Colors.white,
                                      style: BorderStyle.solid),
                                ), // Allows to add a border decoration around your table
                                children: [
                                  TableRow(children: [
                                    Text('Unit Kerja'),
                                    Text(':'),
                                    Text('$Opd')
                                  ]),
                                  TableRow(children: [
                                    Text('Jabatan'),
                                    Text(':'),
                                    Text('$Jabatan')
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      'Pangkat',
                                    ),
                                    Text(":"),
                                    Text('$Pangkat'),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      'TMT PNS',
                                    ),
                                    Text(":"),
                                    Text('$Tmt_pns'),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      'TMT CPNS',
                                    ),
                                    Text(":"),
                                    Text('$Tmt_cpns'),
                                  ]),
                                ]),
                          )))
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

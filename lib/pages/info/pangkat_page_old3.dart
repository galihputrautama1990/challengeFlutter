import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/model/info_model.dart';
import 'package:flutter_training/model/pangkat_model.dart';
import 'package:flutter_training/pages/list_attendance_page.dart';
import 'package:flutter_training/sources/session_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_training/bloc/pangkat_bloc.dart';

import 'package:flutter_stream_listener/flutter_stream_listener.dart';
// import 'package:flutter_training/bloc/login_bloc.dart';

void main() {
  runApp(MaterialApp(
    title: "Latihan Drawable Flutter",
    //menghilangkan debug banner
    debugShowCheckedModeBanner: false,
    home: PangkatPage(),
  ));
}

class PangkatPage extends StatefulWidget {
  PangkatPage({super.key});

  String nom = "12";
  @override
  State<PangkatPage> createState() => _PangkatPageState();
}

class _PangkatPageState extends State<PangkatPage> {
  String? Nama;
  String? Nip;
  String? Opd;
  String? FotoProfil = "http://bkd.blitarkota.go.id/sikoi/images/logo.png";
  // final bloc_data = PangkatBloc();
  final bloc_data = PangkatBloc();

  updateData() async {
    final token = SessionSource().readData('token');
    final nama = await SessionSource().readData('nama');
    final nip = await SessionSource().readData('nip');
    final opd = await SessionSource().readData('opd');
    final fotoprofil = await SessionSource().readData('fotoprofil');
    // print(bloc_data.DataPangkat);
    if (token != null) {
      setState(() {
        Nama = nama;
        Nip = nip;
        Opd = opd;
        FotoProfil = fotoprofil;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void initState() {
    super.initState();
    updateData();
    bloc_data.Pangkat('nip', 'pangkat', 1);
  }

  late Future<PangkatModel> Dpp;

  Future<List<dynamic>> _fecthDataUsers(data) async {
    print("Dalam List View");
    print(data);
    return json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerRight,
            child: Text("RIWAYAT KEPANGKATAN")),
      ),
      drawer: Drawer_main(context, Nip, Nama, Opd, FotoProfil),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: StreamListener<PangkatState>(
                stream: bloc_data.state, // Stream being subscribed to
                onData: (data) {
                  if (data is PangkatLoading) {
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
                  } else if (data is PangkatError) {
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
                  } else if (data is PangkatSuccess) {
                    Navigator.pop(context);
                    Opd = 'ASDD';
                    // List<Data>? DataPangkat;
                    setState(() {
                      print("Dari Sukses");
                      print(data.message);
                      final DataPangkat = data.message;
                      print(DataPangkat);
                      SafeArea(
                        child: FutureBuilder<List<dynamic>>(
                          future: _fecthDataUsers(DataPangkat),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              print('Has Data');
                              return ListView.builder(
                                  padding: EdgeInsets.all(10),
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      title: Text("AA"),
                                      subtitle: Text("AS"),
                                    );
                                  });
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      );
                    });
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
                    children: [
                      Text(
                        "$Opd",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 21),
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

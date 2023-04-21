import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/pages/list_attendance_page.dart';
import 'package:flutter_training/sources/session_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_training/bloc/pangkat_bloc.dart';
import '../../utils/side_bar.dart';

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
  // final bloc_data = PangkatBloc();

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

  @override
  Widget build(BuildContext context) {
    updateData();

    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerRight,
            child: Text("RIWAYAT KEPANGKATAN")),
      ),
      drawer: Drawer_main(context, Nip, Nama, Opd, FotoProfil),
      body: Center(
        child: Text(" . Ini halaman utama, kalian bebas memberikan widget"),
      ),
    );
  }
}

Widget _buildDrawer_profil(context, nip, nama, opd, FotoProfil) {
  return SizedBox(
    //membuat menu drawer
    child: Drawer(
      //membuat list,
      //list digunakan untuk melakukan scrolling jika datanya terlalu panjang
      child: ListView(
        padding: EdgeInsets.zero,
        //di dalam listview ini terdapat beberapa widget drawable
        children: [
          UserAccountsDrawerHeader(
            //membuat gambar profil
            currentAccountPicture: Image(
                image: NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")),
            //membuat nama akun
            accountName: Text("Sahretech"),
            //membuat nama email
            accountEmail: Text("ig: @sahretech"),
            //memberikan background
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2016/04/24/20/52/laundry-1350593_960_720.jpg"),
                    fit: BoxFit.cover)),
          ),
          //membuat list menu
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Beranda"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Pegawai"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text("Transaksi"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.emoji_emotions),
            title: Text("Profil"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Tentang"),
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

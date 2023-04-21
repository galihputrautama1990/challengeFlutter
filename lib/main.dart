import 'package:flutter/material.dart';
import 'package:flutter_training/pages/home_page.dart';
import 'package:flutter_training/pages/info/data_fetch.dart';
import 'package:flutter_training/pages/info/data_list.dart';
import 'package:flutter_training/pages/info/diklat_page.dart';
import 'package:flutter_training/pages/info/info_page.dart';
import 'package:flutter_training/pages/info/jabatan_page.dart';
import 'package:flutter_training/pages/info/pangkat_page.dart';
import 'package:flutter_training/pages/info/profil_page.dart';
import 'package:flutter_training/pages/info/reactive_info_page.dart';
import 'package:flutter_training/pages/list_attendance_page.dart';
import 'package:flutter_training/pages/login_page.dart';
import 'package:flutter_training/pages/example_sidebar_page.dart';
import 'package:flutter_training/pages/splash_page.dart';
import 'package:flutter_training/pages/submit_attendance_page.dart';
import 'package:flutter_training/sources/session_source.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Training',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => HomePage(),
        '/fetch': (context) => DataFetchPage(),
        '/list': (context) => DataListPage(),
        '/login': (context) => LoginPage(),
        '/profil': (context) => ProfilPage(),
        '/info': (context) => ReactiveInfoPage(),
        '/side': (context) => SidebarPage(),
        '/pangkat': (context) => PangkatPage(),
        '/jabatan': (context) => JabatanPage(),
        '/diklat': (context) => DiklatPage(),
        '/list-attendance': (context) => ListAttendancePage(),
        '/submit-attendance': (context) => SubmitAttendancePage(),
      },
    );
  }
}

Widget Drawer_main(context, nip, nama, opd, FotoProfil) {
  return SizedBox(
    child: Drawer(
      child: ListView(
        // padding: EdgeInsets.zero,
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(height: 15),
                Center(
                  child: Image.network(
                    "$FotoProfil",
                    height: 150,
                    width: 125,
                  ),
                ),
              ]),
              SizedBox(height: 8),
              Row(
                children: [
                  Center(
                    child: Text(
                      "$nama",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text("$nip"),
            ],
          ),
          Divider(),
          //membuat list menu
          ListTile(
            leading: Icon(Icons.supervisor_account),
            title: Text("Profil"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profil');
            },
          ),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text("Kepangkatan"),
            onTap: () {
              // blocPangkat.Pangkat(nip);
              Navigator.pushReplacementNamed(context, '/pangkat');
            },
          ),
          ListTile(
            leading: Icon(Icons.event_seat_sharp),
            title: Text("Jabatan"),
            onTap: () {
              // blocPangkat.Pangkat(nip);
              Navigator.pushReplacementNamed(context, '/jabatan');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text("Pendidikan dan Pelatihan"),
            onTap: () {
              // blocPangkat.Pangkat(nip);
              Navigator.pushReplacementNamed(context, '/diklat');
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.info),
            title: Text("Log Out"),
            onTap: () {
              SessionSource().deleteToken();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    ),
  );
}

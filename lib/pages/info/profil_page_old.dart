import 'package:flutter/material.dart';
import 'package:flutter_training/pages/list_attendance_page.dart';
import 'package:flutter_training/sources/session_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

void main() {
  runApp(MaterialApp(
    title: "Latihan Drawable Flutter",
    //menghilangkan debug banner
    debugShowCheckedModeBanner: false,
    home: ProfilPage(),
  ));
}

class ProfilPage extends StatefulWidget {
  ProfilPage({super.key});

  String nom = "12";
  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String? Nama;
  String? Nip;
  String? FotoProfil = "http://bkd.blitarkota.go.id/sikoi/images/logo.png";


  updateData() async {
    final nama = await SessionSource().readData('nama');
    final nip = await SessionSource().readData('nip');

    // print(token);
    if (nama != null && nip != null) {
      setState(() {
        Nama = nama;
        Nip = nip;
        FotoProfil =
            'http://bkd.blitarkota.go.id/sikoi/images/personal/' + nip + '.jpg';
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    double quantity = 1;
    // final token = SessionSource().readToken();
    final prefs = SharedPreferences.getInstance();
    updateData();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "LOG OUT",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // await SessionSource().deleteToken();

                      // Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "LOG OUT",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Center(
                child: Image.network(
                  "$FotoProfil",
                  height: 300,
                  width: 300,
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  "$Nama",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
                ),
              ),
              SizedBox(height: 8),
              Text("$Nip"),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/side');
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color(0xff4287f5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/info');
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
      drawer: _buildDrawer(),
    );
  }
}

Widget _buildDrawer() {
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
            onTap: () {},
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

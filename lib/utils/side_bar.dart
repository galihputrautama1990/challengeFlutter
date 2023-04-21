import 'package:flutter/material.dart';
import 'package:flutter_training/bloc/pangkat_bloc.dart';

Widget Drawer_util(context, nip, nama, opd, FotoProfil) {
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
                Container(
                  child: Image.network(
                    "$FotoProfil",
                    height: 150,
                    width: 125,
                  ),
                ),
              ]),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "$nama",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text("$nip"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text("$opd", textAlign: TextAlign.center),
                  ),
                ],
              ),
              // Text("$opd"),
            ],
          ),
          Divider(),
          //membuat list menu
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Beranda"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Pangkat"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pangkat');
            },
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

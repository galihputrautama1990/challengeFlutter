import 'package:flutter/material.dart';

class DataListPage extends StatefulWidget {
  const DataListPage({super.key});

  @override
  State<DataListPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DataListPage> {
  List _list = [];

  @override
  void initState() {
    super.initState();

    _list.add(1);
    _list.add(2);
    _list.add(3);
    _list.add(4);
    _list.add(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center());
  }
}

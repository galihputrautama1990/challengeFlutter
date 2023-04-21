import 'package:flutter/material.dart';
import 'package:flutter_training/bloc/info_bloc.dart';
import 'package:flutter_training/model/info_model.dart';

class ReactiveInfoPage extends StatefulWidget {
  const ReactiveInfoPage({super.key});

  @override
  State<ReactiveInfoPage> createState() => _ReactiveInfoPageState();
}

class _ReactiveInfoPageState extends State<ReactiveInfoPage> {
  final bloc = InfoBloc();

  @override
  void initState() {
    super.initState();
    bloc.getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST API"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              bloc.getInfo();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: StreamBuilder<InfoModel>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data?.data?.title ?? "-"),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

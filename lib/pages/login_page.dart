import 'package:flutter/material.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';
import 'package:flutter_training/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _username = TextEditingController(text: '199008272015011001');
  final _password = TextEditingController(text: '1134');

  final bloc = LoginBloc();

  bool obsecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset('assets/images/login.png'),
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: StreamListener<LoginState>(
            stream: bloc.state, // Stream being subscribed to
            onData: (data) {
              if (data is LoginLoading) {
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
              } else if (data is LoginError) {
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
              } else if (data is LoginSuccess) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/profil');
              }
            },
            onError: (error, stackTrace) {
              // Optionally handle errors in the Stream
            },
            onDone: () {
              // Optionally react to when the Stream is closed
            },
            cancelOnError: true,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _username,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text("NIP"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Field ini wajib diisi';
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _password,
                    obscureText: obsecurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obsecurePassword = !obsecurePassword;
                          });
                        },
                        icon: Icon(obsecurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Field ini wajib diisi';
                      }
                    },
                  ),
                  // Expanded(child: Container()),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            bloc.login({
                              'username': _username.text,
                              'password': _password.text,
                              'method': 'flutter'
                            });
                          }
                        },
                        child: Text(
                          "Go",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(232, 67, 91, 5)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )))),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16)
      ]),
    );
  }
}

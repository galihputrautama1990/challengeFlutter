import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/model/example_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class SubmitAttendancePage extends StatefulWidget {
  const SubmitAttendancePage({super.key});

  @override
  State<SubmitAttendancePage> createState() => _SubmitAttendancePageState();
}

class _SubmitAttendancePageState extends State<SubmitAttendancePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _rencanaController = TextEditingController();

  String? lokasiKerja;

  List<String> alatKerja = [];

  String? suasana;

  XFile? gambarSelfie;

  Position? posisiUser;

  selfie(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front,
    );

    if (image != null) {
      setState(() {
        gambarSelfie = image;
      });
    }
  }

  updateLokasi() async {
    try {
      final position = await _determinePosition();
      
      setState(() {
        posisiUser = position;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {
    _rencanaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Attendance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(21),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _rencanaController,
                decoration: InputDecoration(
                  label: Text("Rencana Pekerjaan"),
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Field ini wajib diisi';
                  }
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  label: Text("Lokasi Kerja"),
                ),
                items: ['WFH', 'WFO']
                    .map(
                      (e) => DropdownMenuItem(value: e, child: Text(e)),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    lokasiKerja = val;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Harap memilih lokasi kerja';
                  }
                },
              ),
              SizedBox(height: 16),
              Text('Alat Kerja yang dipilih: ${alatKerja.join(', ')}'),
              FormField<List<String>>(
                initialValue: alatKerja,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                builder: (state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      title: Text('Laptop'),
                      value: alatKerja.contains('laptop'),
                      onChanged: (checked) {
                        // state.
                        if (checked!) {
                          alatKerja.add('laptop');
                        } else {
                          alatKerja.remove('laptop');
                        }
                        state.didChange(alatKerja);
                        setState(() {});
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Komputer'),
                      value: alatKerja.contains('komputer'),
                      onChanged: (checked) {
                        if (checked!) {
                          alatKerja.add('komputer');
                        } else {
                          alatKerja.remove('komputer');
                        }
                        state.didChange(alatKerja);
                        setState(() {});
                      },
                    ),
                    CheckboxListTile(
                      title: Text('HP'),
                      value: alatKerja.contains('hp'),
                      onChanged: (checked) {
                        if (checked!) {
                          alatKerja.add('hp');
                        } else {
                          alatKerja.remove('hp');
                        }
                        state.didChange(alatKerja);
                        setState(() {});
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Lainya'),
                      value: alatKerja.contains('lainya'),
                      onChanged: (checked) {
                        if (checked!) {
                          alatKerja.add('lainya');
                        } else {
                          alatKerja.remove('lainya');
                        }
                        state.didChange(alatKerja);
                        setState(() {});
                      },
                    ),
                    if (state.hasError)
                      Text(
                        state.errorText!,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                  ],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap pilih minimal 1 alat kerja';
                  }
                },
              ),
              SizedBox(height: 16),
              Text('Suasana Hati'),
              FormField<String>(
                initialValue: suasana,
                builder: (state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile<String>(
                      title: Text('Sedih'),
                      value: 'sedih',
                      groupValue: suasana,
                      onChanged: (val) {
                        state.didChange(val!);
                        setState(() {
                          suasana = val;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Senang'),
                      value: 'senang',
                      groupValue: suasana,
                      onChanged: (val) {
                        state.didChange(val!);

                        setState(() {
                          suasana = val;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Netral'),
                      value: 'netral',
                      groupValue: suasana,
                      onChanged: (val) {
                        state.didChange(val!);

                        setState(() {
                          suasana = val;
                        });
                      },
                    ),
                    if (state.hasError)
                      Text(
                        state.errorText!,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                  ],
                ),
                validator: (val) {
                  if (val == null) {
                    return 'Harap isi suasana hati!';
                  } else if (val == 'sedih') {
                    return 'jangan bersedih!';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 16),
              FormField<XFile>(
                builder: (state) => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            child: Text('Selfie'),
                            onPressed: () {
                              selfie(ImageSource.camera);
                              state.didChange(gambarSelfie);
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            child: Text('Gallery'),
                            onPressed: () {
                              selfie(ImageSource.gallery);
                              state.didChange(gambarSelfie);
                            },
                          ),
                        ),
                      ],
                    ),
                    if (state.hasError)
                      Text(
                        state.errorText!,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                  ],
                ),
                validator: (file) {
                  if (file == null) {
                    return 'Wajib selfie!';
                  }
                },
              ),
              if (gambarSelfie != null)
                if (kIsWeb)
                  Image.network(
                    gambarSelfie!.path,
                  )
                else
                  Image.file(
                    File(gambarSelfie!.path),
                  ),
              SizedBox(height: 16),
              FormField<Position>(
                builder: (state) => Column(
                  children: [
                    Row(
                      children: [
                        if (posisiUser != null)
                          Text(
                              '${posisiUser!.latitude} ${posisiUser!.longitude}')
                        else
                          Text('Lokasi belum tersedia'),
                        Spacer(),
                        FilledButton(
                          child: Text('Perbarui Lokasi'),
                          onPressed: () async {
                            await updateLokasi();
                            state.didChange(posisiUser);
                          },
                        ),
                      ],
                    ),
                    if (state.hasError)
                      Text(
                        state.errorText!,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                  ],
                ),
                validator: (posisi) {
                  if (posisi == null) {
                    return 'Harap perbarui lokasi!';
                  }
                },
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("OK");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Contoh StatelesWidget
class HelloMessage extends StatelessWidget {
  const HelloMessage({
    super.key,
    this.nama,
  });

  final String? nama;

  @override
  Widget build(BuildContext context) {
    return Text("Halo, ${nama ?? 'test'}");
  }
}

// Contoh StatefulWidget
class TombolBintang extends StatefulWidget {
  const TombolBintang({
    super.key,
    this.initialFavoriteNum = 0,
    this.initialIsLoved = false,
  });

  final int initialFavoriteNum;
  final bool initialIsLoved;

  @override
  State<TombolBintang> createState() => _TombolBintangState();
}

class _TombolBintangState extends State<TombolBintang> {
  // menggunakan keyword late
  // late: menunggu lifecycle initState selesai
  late int numFavorite = widget.initialFavoriteNum;

  // manual, tanpa keyword late
  // isFavorite diberi nilai awal sembari menunggu initState dijalankan
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    // ketika initState dijalankan, ubah nilai isFavorite menjadi widget.initialIsLoved
    isFavorite = widget.initialIsLoved;

    print('widget ditampilkan di layar');
  }

  @override
  void didUpdateWidget(covariant TombolBintang oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('parameter widget berubah');
  }

  @override
  void dispose() {
    print("widget favorite dihapus dari layar");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isFavorite = !isFavorite;

        if (isFavorite) {
          numFavorite++;
        } else {
          numFavorite--;
        }

        // memberitahu bahwa terdapat perubahan nilai pada state
        // sehingga method build() akan dipanggil ulang
        setState(() {});
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          Text(numFavorite.toString()),
        ],
      ),
    );
  }
}

// FilledButton(
//   onPressed: () async {
//     final result = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1999),
//       lastDate: DateTime(2045),
//     );

//     final time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     print(result);
//   },
//   child: Text('Pilih date'),
// ),

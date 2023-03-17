import 'dart:convert';
import 'dart:io';

import 'package:fenix_flutter/core/models/device_model.dart';
import 'package:fenix_flutter/core/providers/add_device_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddDevice extends StatefulWidget {
  const AddDevice({Key? key}) : super(key: key);

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final controllerId = TextEditingController();
  final controllerName = TextEditingController();
  final controllerUserUid = TextEditingController();
  Image img1 = Image.asset("assets/images/abierto.png");
  Image img2 = Image.asset("assets/images/cerrado.png");
  Image img3 = Image.asset("assets/images/espera.png");
  late File imageCon;
  late File imageDiscon;
  late File imageWait;
  late String imgConString;
  late String imgDisconString;
  late String imgWaitString;

  Future selectImage(String fieldName) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        if (!kIsWeb) {
          if (fieldName == "imageCon") {
            imageCon = File(pickedImage.path);
            imgConString = base64Encode(imageCon.readAsBytesSync());
            img1 = Image.file(imageCon);
          } else if (fieldName == "imageDiscon") {
            imageDiscon = File(pickedImage.path);
            imgDisconString = base64Encode(imageDiscon.readAsBytesSync());
            img2 = Image.file(imageDiscon);
          } else if (fieldName == "imageWait") {
            imageWait = File(pickedImage.path);
            imgWaitString = base64Encode(imageWait.readAsBytesSync());
            img3 = Image.file(imageWait);
          }
        } else {
          if (fieldName == "imageCon") {
            imgConString = pickedImage.path;
            img1 = Image.network(imgConString);
          } else if (fieldName == "imageDiscon") {
            imgDisconString = pickedImage.path;
            img2 = Image.network(imgDisconString);
          } else if (fieldName == "imageWait") {
            imgWaitString = pickedImage.path;
            img3 = Image.network(imgWaitString);
          }
        }
      });
    }
  }

  Future<String> _getBytesFromUrl(str) async {
    final response = await http.get(Uri.parse(str));
    return base64Encode(response.bodyBytes);
  }

  Future<String> _getBytesFromAsset(str) async {
    final ByteData data = await rootBundle.load(str);
    return base64Encode(data.buffer.asUint8List());
  }

  @override
  void initState() {
    super.initState();
    asyncImages();
  }

  void asyncImages() async {
    if (!kIsWeb) {
      imgConString = await _getBytesFromAsset("assets/images/abierto.png");
      imgDisconString = await _getBytesFromAsset("assets/images/cerrado.png");
      imgWaitString = await _getBytesFromAsset("assets/images/espera.png");
    } else {
      imgConString = await _getBytesFromAsset("assets/images/abierto.png");
      imgDisconString = await _getBytesFromAsset("assets/images/cerrado.png");
      imgWaitString = await _getBytesFromAsset("assets/images/espera.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Añadir Dispositivo"),
        ),
        body: Center(
          child: Card(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.devices_other, size: 100),
                const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Id:",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: controllerId,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: "Id",
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Nombre:",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: controllerName,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: "Nombre",
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "UserUid:",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: controllerUserUid,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: "UserUid",
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Imagen\nconexion:",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width / 6),
                          height: (MediaQuery.of(context).size.width / 6),
                          child: img1,
                        ),
                        TextButton(
                          onPressed: () {
                            selectImage("imageCon");
                          },
                          child: const Text(
                            "Seleccionar\nImagen",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Imagen\ndesconexión:",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width / 6),
                          height: (MediaQuery.of(context).size.width / 6),
                          child: img2,
                        ),
                        TextButton(
                          onPressed: () {
                            selectImage("imageDiscon");
                          },
                          child: const Text(
                            "Seleccionar\nImagen",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Imagen\nespera:",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width / 6),
                          height: (MediaQuery.of(context).size.width / 6),
                          child: img3,
                        ),
                        TextButton(
                          onPressed: () {
                            selectImage("imageWait");
                          },
                          child: const Text(
                            "Seleccionar\nImagen",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                      ),
                      onPressed: () async {
                        Device device;
                        if (!kIsWeb) {
                          device = Device(
                              id: controllerId.text,
                              name: controllerName.text,
                              userUid: controllerUserUid.text,
                              imgcon: imgConString,
                              imgdiscon: imgDisconString,
                              imgwait: imgWaitString);
                        } else {
                          if (img1.image !=
                              Image.asset("assets/images/abierto.png").image) {
                            imgConString = await _getBytesFromUrl(imgConString);
                          }
                          if (img2.image !=
                              Image.asset("assets/images/cerrado.png").image) {
                            imgDisconString =
                                await _getBytesFromUrl(imgDisconString);
                          }
                          if (img3.image !=
                              Image.asset("assets/images/espera.png").image) {
                            imgWaitString =
                                await _getBytesFromUrl(imgWaitString);
                          }
                          device = Device(
                              id: controllerId.text,
                              name: controllerName.text,
                              userUid: controllerUserUid.text,
                              imgcon: imgConString,
                              imgdiscon: imgDisconString,
                              imgwait: imgWaitString);
                        }
                        addDevice(device: device);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/devices", (route) => false);
                      },
                      child: const Text('Añadir',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ))
              ]),
            ),
          ),
        ));
  }
}

import 'package:fenix_flutter/core/models/device_model.dart';
import 'package:fenix_flutter/core/providers/add_device_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_web/image_picker_web.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final controllerId = TextEditingController();
  final controllerName = TextEditingController();
  final controllerUserUid = TextEditingController();
  Image imageCon = Image.asset("abierto.png");
  Image imageDiscon = Image.asset("cerrado.png");
  Image imageWait = Image.asset("espera.png");
  late Uint8List imgConBytes;
  late Uint8List imgDisconBytes;
  late Uint8List imgWaitBytes;

  Future<void> selectImage(String fieldName) async {
    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS) {
      // se ejecuta en Web
      Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
      if (bytesFromPicker != null) {
        setState(() {
          if (fieldName == "imageCon") {
            imgConBytes = bytesFromPicker;
            imageCon = Image.memory(bytesFromPicker);
          } else if (fieldName == "imageDiscon") {
            imgDisconBytes = bytesFromPicker;
            imageDiscon = Image.memory(bytesFromPicker);
          } else if (fieldName == "imageWait") {
            imgWaitBytes = bytesFromPicker;
            imageWait = Image.memory(bytesFromPicker);
          }
        });
      }
    } else {
      // se ejecuta en android o ios
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        // asegurarse de que la ruta de la imagen seleccionada sea válida
        String? filePath = result.files.single.path;
        if (filePath != null && filePath.startsWith('assets/')) {
          ByteData bytes = await rootBundle.load(filePath);
          setState(() {
            if (fieldName == "imageCon") {
              imageCon = Image.asset(filePath);
              imgConBytes = bytes.buffer.asUint8List();
            } else if (fieldName == "imageDiscon") {
              imageDiscon = Image.asset(filePath);
              imgDisconBytes = bytes.buffer.asUint8List();
            } else if (fieldName == "imageWait") {
              imageWait = Image.asset(filePath);
              imgWaitBytes = bytes.buffer.asUint8List();
            }
          });
        }
      }
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Imagen conexion:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width / 6),
                          height: (MediaQuery.of(context).size.width / 6),
                          child: imageCon,
                        ),
                        TextButton(
                          onPressed: () {
                            selectImage("imageCon");
                          },
                          child: const Text("Seleccionar Imagen"),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Imagen desconexión:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width / 6),
                          height: (MediaQuery.of(context).size.width / 6),
                          child: imageDiscon,
                        ),
                        TextButton(
                          onPressed: () {
                            selectImage("imageDiscon");
                          },
                          child: const Text("Seleccionar Imagen"),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Imagen espera:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width / 6),
                          height: (MediaQuery.of(context).size.width / 6),
                          child: imageWait,
                        ),
                        TextButton(
                          onPressed: () {
                            selectImage("imageWait");
                          },
                          child: const Text("Seleccionar Imagen"),
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
                        if (imageCon.image ==
                            Image.asset("abierto.png").image) {
                          ByteData bytes = await rootBundle.load("abierto.png");
                          imgConBytes = bytes.buffer.asUint8List();
                        }
                        if (imageDiscon.image ==
                            Image.asset("cerrado.png").image) {
                          ByteData bytes = await rootBundle.load("cerrado.png");
                          imgDisconBytes = bytes.buffer.asUint8List();
                        }
                        if (imageWait.image ==
                            Image.asset("espera.png").image) {
                          ByteData bytes = await rootBundle.load("espera.png");
                          imgWaitBytes = bytes.buffer.asUint8List();
                        }
                        Device device = Device(
                            id: controllerId.text,
                            name: controllerName.text,
                            userUid: controllerUserUid.text,
                            imgcon: imgConBytes,
                            imgdiscon: imgDisconBytes,
                            imgwait: imgWaitBytes);
                        addDevice(device: device);
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

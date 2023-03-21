import 'dart:convert';
import 'dart:io';

import 'package:fenix_flutter/core/models/device_model.dart';
import 'package:fenix_flutter/core/providers/add_device_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

///Clase que te muestra un formulario para añadir un dispositivo
///Por defecto tendra imagenes por defecto que se almacenan en la
///carpeta de assets y el usuario podra cambiar por otras de su dispositivo
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

  ///Este metodo obtiene una imagen usando la libreria image_picker y segun
  ///el dispositivo en el que funcione la aplicacion lo almacena de una manera
  ///o otra, recibe como parametro el nombre del campo que debe guardarla
  Future selectImage(String fieldName) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      //Indica a la aplicacion que debe cambiar el estado
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

  ///Obtiene los bytes de la imagen a partir de una url (se usa en web)
  Future<String> _getBytesFromUrl(str) async {
    final response = await http.get(Uri.parse(str));
    return base64Encode(response.bodyBytes);
  }

  ///Obtiene los bytes de la imagen a partir de un asset
  Future<String> _getBytesFromAsset(str) async {
    final ByteData data = await rootBundle.load(str);
    return base64Encode(data.buffer.asUint8List());
  }

  @override
  void initState() {
    super.initState();
    asyncImages();
  }

  ///Obtiene los bytes en forma de string
  void asyncImages() async {
    imgConString = await _getBytesFromAsset("assets/images/abierto.png");
    imgDisconString = await _getBytesFromAsset("assets/images/cerrado.png");
    imgWaitString = await _getBytesFromAsset("assets/images/espera.png");
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
              //Columna con un icono, Text y TextField para los campos,
              //una fila que contiene las imagenes y un boton para añadir
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.devices_other, size: 100),
                //ID
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
                //NOMBRE
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
                //USER_UID
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
                //Row que contiene 3 columnas (1 por imagen)
                //Cada columna contiene un texto, una imagen y un boton para cambiar la imagen
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Columna Imagen Conexion
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
                    //Columna Imagen Desconexion
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
                    //Columna Imagen Espera
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
                //Boton para añadir el dispositivo
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                      ),
                      onPressed: () async {
                        Device device;
                        //Si no se ejecuta en web se crea el dispositivo
                        if (!kIsWeb) {
                          device = Device(
                              id: controllerId.text,
                              name: controllerName.text,
                              userUid: controllerUserUid.text,
                              imgcon: imgConString,
                              imgdiscon: imgDisconString,
                              imgwait: imgWaitString);
                          //En caso de que sea web se obtienen los string con
                          //los bytes de las imagenes que no hayan sido cambiadas
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
                        //Se añade el dispositivo
                        addDevice(device: device);
                        //Se vuelve a la pantalla de dispositivos
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

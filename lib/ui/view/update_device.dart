import 'dart:convert';
import 'dart:io';

import 'package:fenix_flutter/core/models/device_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../core/providers/device_details_provider.dart';
import '../../core/providers/update_device_provider.dart';

///Esta clase sirve para cambiar y actualizar los datos de un dispositivo
class UpdateDevice extends StatefulWidget {
  final String id;

  const UpdateDevice({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateDevice> createState() => _UpdateDeviceState();
}

class _UpdateDeviceState extends State<UpdateDevice> {
  final controllerId = TextEditingController();
  final controllerName = TextEditingController();
  final controllerUserUid = TextEditingController();
  late Image img1;
  late Image img2;
  late Image img3;
  late File imageCon;
  late File imageDiscon;
  late File imageWait;
  late String imgConString;
  late String imgDisconString;
  late String imgWaitString;

  late Future<Device> device;
  late String _id;

  ///Este metodo obtiene una imagen usando la libreria image_picker y segun
  ///el dispositivo en el que funcione la aplicacion lo almacena de una manera
  ///o otra, recibe como parametro el nombre del campo que debe guardarla
  Future selectImage(String fieldName) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (!kIsWeb) {
        if (fieldName == "imageCon") {
          imageCon = File(pickedImage.path);
          imgConString = base64Encode(imageCon.readAsBytesSync());
        } else if (fieldName == "imageDiscon") {
          imageDiscon = File(pickedImage.path);
          imgDisconString = base64Encode(imageDiscon.readAsBytesSync());
        } else if (fieldName == "imageWait") {
          imageWait = File(pickedImage.path);
          imgWaitString = base64Encode(imageWait.readAsBytesSync());
        }
      } else {
        if (fieldName == "imageCon") {
          imgConString = pickedImage.path;
          imgConString = await _getBytesFromUrl(imgConString);
        } else if (fieldName == "imageDiscon") {
          imgDisconString = pickedImage.path;
          imgDisconString = await _getBytesFromUrl(imgDisconString);
        } else if (fieldName == "imageWait") {
          imgWaitString = pickedImage.path;
          imgWaitString = await _getBytesFromUrl(imgWaitString);
        }
      }
      //Indica a la aplicacion que debe cambiar el estado
      setState(() {
        device = Future.value(Device(
            id: controllerId.text,
            name: controllerName.text,
            userUid: controllerUserUid.text,
            imgcon: imgConString,
            imgdiscon: imgDisconString,
            imgwait: imgWaitString));
      });
    }
  }

  ///Obtiene los bytes de la imagen a partir de una url (se usa en web)
  Future<String> _getBytesFromUrl(str) async {
    final response = await http.get(Uri.parse(str));
    return base64Encode(response.bodyBytes);
  }

  @override
  void initState() {
    super.initState();
    //Se obtiene el dispositivo por su id
    _id = widget.id;
    device = getDeviceById(_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Actualizar Dispositivo"),
        ),
        body: FutureBuilder<Device>(
            future: device,
            builder: (context, snapshot) {
              //Si contiene datos se muestran
              if (snapshot.hasData) {
                //Se crea un dispositivo
                Device dev = Device(
                    id: snapshot.data!.id,
                    name: snapshot.data!.name,
                    userUid: snapshot.data!.userUid,
                    imgcon: snapshot.data!.imgcon,
                    imgdiscon: snapshot.data!.imgdiscon,
                    imgwait: snapshot.data!.imgwait);
                //Se añaden los datos a sus campos
                controllerId.text = dev.id;
                controllerName.text = dev.name;
                controllerUserUid.text = dev.userUid;
                //Se les asigna los caracters codificados a sus string
                imgConString = dev.imgcon;
                imgDisconString = dev.imgdiscon;
                imgWaitString = dev.imgwait;
                //Se obtienen las imagenes a traves de sus string
                img1 = Image.memory(base64Decode(dev.imgcon));
                img2 = Image.memory(base64Decode(dev.imgdiscon));
                img3 = Image.memory(base64Decode(dev.imgwait));
                return Center(
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      //Columna con un icono, Text y TextField para los campos,
                      //una fila que contiene las imagenes y un boton para editar
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
                                  width:
                                      (MediaQuery.of(context).size.width / 6),
                                  height:
                                      (MediaQuery.of(context).size.width / 6),
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
                                  width:
                                      (MediaQuery.of(context).size.width / 6),
                                  height:
                                      (MediaQuery.of(context).size.width / 6),
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
                                  width:
                                      (MediaQuery.of(context).size.width / 6),
                                  height:
                                      (MediaQuery.of(context).size.width / 6),
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
                        //Boton para editar el dispositivo
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                              ),
                              onPressed: () async {
                                Device device;
                                //Se obtiene el dispositivo con los datos cambiados
                                device = Device(
                                    id: controllerId.text,
                                    name: controllerName.text,
                                    userUid: controllerUserUid.text,
                                    imgcon: imgConString,
                                    imgdiscon: imgDisconString,
                                    imgwait: imgWaitString);
                                //Se llama al metodo para actualizar el dispositivo
                                updateDevice(device: device);
                                //Se vuelve a las pantallas de dispositivos
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/devices", (route) => false);
                              },
                              child: const Text('Actualizar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ))
                      ]),
                    ),
                  ),
                );
                //Si se obtiene error se muestra
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('An error occurred: ${snapshot.error}'),
                );
                //Si esta cargando se muestra un icono de carga
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

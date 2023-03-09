/*import 'package:fenix_flutter/core/models/device_model.dart';
import 'package:fenix_flutter/core/providers/device_details_provider.dart';
import 'package:fenix_flutter/core/providers/update_device_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Image imageCon = Image.asset("abierto.png");
  Image imageDiscon = Image.asset("cerrado.png");
  Image imageWait = Image.asset("espera.png");
  late Uint8List imgConBytes;
  late Uint8List imgDisconBytes;
  late Uint8List imgWaitBytes;

  late Future<Device> device;
  late String _id;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    device = getDeviceById(_id);
  }

  Future<void> selectImage(String fieldName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // asegurarse de que la ruta de la imagen seleccionada sea válida
      Uint8List? bytes = result.files.single.bytes;
      if (bytes != null) {
        setState(() {
          if (fieldName == "imageCon") {
            imageCon = Image.memory(bytes);
            imgConBytes = bytes;
          } else if (fieldName == "imageDiscon") {
            imageDiscon = Image.memory(bytes);
            imgDisconBytes = bytes;
          } else if (fieldName == "imageWait") {
            imageWait = Image.memory(bytes);
            imgWaitBytes = bytes;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ActualizarDispositivo"),
        ),
        body: FutureBuilder<Device>(
            future: device,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Device dev = Device(
                    id: snapshot.data!.id,
                    name: snapshot.data!.name,
                    userUid: snapshot.data!.userUid,
                    imgcon: snapshot.data!.imgcon,
                    imgdiscon: snapshot.data!.imgdiscon,
                    imgwait: snapshot.data!.imgwait);
                controllerId.text = dev.id;
                controllerName.text = dev.name;
                controllerUserUid.text = dev.userUid;
                return Center(
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
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
                                  width:
                                      (MediaQuery.of(context).size.width / 6),
                                  height:
                                      (MediaQuery.of(context).size.width / 6),
                                  child: imageCon,
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
                                  width:
                                      (MediaQuery.of(context).size.width / 6),
                                  height:
                                      (MediaQuery.of(context).size.width / 6),
                                  child: imageDiscon,
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
                                  width:
                                      (MediaQuery.of(context).size.width / 6),
                                  height:
                                      (MediaQuery.of(context).size.width / 6),
                                  child: imageWait,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                              ),
                              onPressed: () async {
                                Device device = Device(
                                    id: controllerId.text,
                                    name: controllerName.text,
                                    userUid: controllerUserUid.text,
                                    imgcon: imgConBytes,
                                    imgdiscon: imgDisconBytes,
                                    imgwait: imgWaitBytes);
                                updateDevice(device: device);
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
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('An error occurred: ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
*/
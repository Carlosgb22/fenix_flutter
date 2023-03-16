import 'dart:convert';

import 'package:fenix_flutter/core/providers/device_details_provider.dart';
import 'package:fenix_flutter/ui/view/update_device.dart';
import 'package:flutter/material.dart';

import '../../core/models/device_model.dart';

class DeviceDetails extends StatefulWidget {
  final String id;

  const DeviceDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<DeviceDetails> createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  late Future<Device> device;
  late String _id;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    device = getDeviceById(_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dispositivo"),
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
                return Center(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Id: ${dev.id}",
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.left),
                          Text("Nombre: ${dev.name}",
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.left),
                          Text("Usuario: ${dev.userUid}",
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.left)
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                border: Border.all(
                                  color: Colors.black38,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text("Imagen conexion:",
                                      style: TextStyle(fontSize: 28),
                                      textAlign: TextAlign.center),
                                  Image.memory(
                                    base64Decode(dev.imgcon),
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                border: Border.all(
                                  color: Colors.black38,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text("Imagen desconexion:",
                                      style: TextStyle(fontSize: 28),
                                      textAlign: TextAlign.center),
                                  Image.memory(
                                    base64Decode(dev.imgdiscon),
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                border: Border.all(
                                  color: Colors.black38,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text("Imagen espera:",
                                      style: TextStyle(fontSize: 28),
                                      textAlign: TextAlign.center),
                                  Image.memory(
                                    base64Decode(dev.imgwait),
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue.shade300,
                            padding: const EdgeInsets.symmetric(vertical: 30),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateDevice(id: dev.id)));
                          },
                          child: const Text(
                            "Actualizar dispositivo",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
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

import 'dart:convert';

import 'package:fenix_flutter/core/providers/device_details_provider.dart';
import 'package:fenix_flutter/ui/view/update_device.dart';
import 'package:flutter/material.dart';

import '../../core/models/device_model.dart';

///Esta clase muestra los detalles de un dispositivo
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
    //Se obtiene el dispositivo para cargar el widget
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
              //Si se han obtenido datos se crea un dispositivo y se muestra
              if (snapshot.hasData) {
                Device dev = Device(
                    id: snapshot.data!.id,
                    name: snapshot.data!.name,
                    userUid: snapshot.data!.userUid,
                    imgcon: snapshot.data!.imgcon,
                    imgdiscon: snapshot.data!.imgdiscon,
                    imgwait: snapshot.data!.imgwait);
                //Se muestran los datos en una columna, las imagenes en una fila y un boton que te permite cambiar los datos
                return Center(
                  child: Column(
                    children: [
                      //DATOS
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
                      //IMAGENES
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
                      //BOTON
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
                //En caso de error te lo muestra en el medio de la pantalla
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('An error occurred: ${snapshot.error}'),
                );
                //En el caso de que este cargando te muestra un indicador de carga
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

import 'package:fenix_flutter/core/providers/devices_provider.dart';
import 'package:fenix_flutter/ui/view/widget.dart';
import 'package:flutter/material.dart';
import '../../core/models/device_model.dart';

///Esta clase muetra una lista que contiene todos los dispositivos
///de la base de datos y un boton para añadir mas dispositivos
class Devices extends StatefulWidget {
  const Devices({super.key});

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  late Future<List<Device>> _deviceList;

  @override
  void initState() {
    super.initState();
    _deviceList = getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dispositivos"),
        ),
        //FutureBuilder que recibe los dispositivos
        body: FutureBuilder<List<Device>>(
            future: _deviceList,
            builder: (context, snapshot) {
              //snapshot seria el futuro, si tiene datos se muestran los dispositivos en un ListView
              if (snapshot.hasData) {
                List<Device> list = <Device>[];
                for (var data in snapshot.data!) {
                  list.add(Device(
                      id: data.id,
                      name: data.name,
                      userUid: data.userUid,
                      imgcon: data.imgcon,
                      imgdiscon: data.imgdiscon,
                      imgwait: data.imgwait));
                }
                return ListView.builder(
                  // Deja que ListView sepa cuántos elementos necesita para construir
                  itemCount: list.length,
                  // Proporciona una función de constructor. Se crea un dispositivo por cada elemento
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return ListTile(
                      //DeviceButton es un widget personalizado el cual se encutra en widget.dart
                      title: DeviceButton(device: item),
                    );
                  },
                );
                //Si snapshot tiene errores, te muestra el error en el centro
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('An error occurred: ${snapshot.error}'),
                );
                //En el caso de tardar mucho te muestra un indicador de carga
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        //Te muestra un boton flotante con el simbolo + el cual te permite añadir un dispositivo
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/devices/add");
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add_to_queue),
        ));
  }
}

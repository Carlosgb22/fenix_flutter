import 'package:fenix_flutter/core/providers/devices_provider.dart';
import 'package:fenix_flutter/ui/view/widget.dart';
import 'package:flutter/material.dart';

import '../../core/models/device_model.dart';

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
        body: FutureBuilder<List<Device>>(
            future: _deviceList,
            builder: (context, snapshot) {
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
                  // Proporciona una función de constructor. ¡Aquí es donde sucede la magia! Vamos a
                  // convertir cada elemento en un Widget basado en el tipo de elemento que es.
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return ListTile(
                      title: DeviceButton(device: item),
                    );
                  },
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
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/devices/add");
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add_to_queue),
        ));
  }
}

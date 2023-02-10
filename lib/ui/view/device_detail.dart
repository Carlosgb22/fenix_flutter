import 'package:flutter/material.dart';

class DevieceDetails extends StatelessWidget {
  const DevieceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detalle"),
        ),
        body: Column(
          children: const [],
        ));
  }
}
/*
import 'package:fenix_flutter/core/providers/devices_provider.dart';
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
                for (var i = 0; i < snapshot.data!.length; i++) {
                  return ListTile(
                    title: Text(snapshot.data![i].id),
                    subtitle: Text(snapshot.data![i].name),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('An error occurred: ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              throw Exception("");
            }));
  }
}
*/
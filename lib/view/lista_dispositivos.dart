import 'package:flutter/material.dart';

import '../controller/lista_dispositivos_controller.dart';

class ListaDispositivos extends StatelessWidget {
  const ListaDispositivos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dispositivos"),
        ),
        body: Column(
          children: [verDispositivos()],
        ));
  }
}

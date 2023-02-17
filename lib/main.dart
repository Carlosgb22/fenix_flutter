/// Clase lanzadora del programa
import 'package:fenix_flutter/ui/view/add_device.dart';
import 'package:fenix_flutter/ui/view/devices.dart';
import 'package:fenix_flutter/ui/view/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

///Metodo principal que llama al Widget Fenix
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: "Fenix",
    initialRoute: "/login",
    routes: {
      "/login": (context) => const Start(),
      "/devices": (context) => const Devices(),
      "/devices/add": (context) => const AddDevice(),
    },
  ));
}

///StatefulWidget Start que muestra la primera pantalla del programa
class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _InicioState();
}

///Estado del Widget Start, Contiene un Scaffold con una AppBar con el nombre de la aplicacion
///y un body con un widget llamado Login que se encuentra en la clase widget.dart
class _InicioState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fenix"),
        ),
        body: const Login());
  }
}

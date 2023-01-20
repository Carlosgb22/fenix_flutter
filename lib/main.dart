/// Clase lanzadora del programa
import 'package:fenix_flutter/view/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

///Metodo principal que llama al Widget Fenix
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Fenix());
}

///Este StatelessWidget devuelve un Widget MaterialApp cuyo contenido es la clse Inicio
class Fenix extends StatelessWidget {
  const Fenix({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Fenix",
      home: Inicio(),
    );
  }
}

///StatefulWidget Inicio que muestra la primera pantalla del programa
class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

///Estado del Widget Inicio, Contiene un Scaffold con una AppBar con el nombre de la aplicacion
///y un body con un widget llamado Login que se encuentra en la clase widget.dart
class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fenix"),
        ),
        body: const Login());
  }
}

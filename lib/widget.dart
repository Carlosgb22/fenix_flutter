///Clase que contiene todos los widgets creados por mi (Actividad 10 Desarrollo de Interfaces RA3)
import 'package:fenix_flutter/controller/login_controller.dart';
import 'package:flutter/material.dart';

///TextEditingController para el TextField del email y el TextField  de la contraseña
final controllerEmail = TextEditingController();
final controllerContrasenia = TextEditingController();

///Widget en el cual el usuario debe escribir su email
class CampoEmail extends StatefulWidget {
  const CampoEmail({super.key});

  @override
  State<CampoEmail> createState() => _CampoEmailState();
}

///Estado del Widget CampoEmail, contiene un metodo dispose()
///para el controlador y un contenedor con un TextField
class _CampoEmailState extends State<CampoEmail> {
  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: controllerEmail,
        decoration: const InputDecoration(
          hintText: "Email",
        ),
      ),
    );
  }
}

///Widget en el cual el usuario debe escribir su contraseña
class CampoContrasenia extends StatefulWidget {
  const CampoContrasenia({super.key});

  @override
  State<CampoContrasenia> createState() => _CampoContraseniaState();
}

///Estado del Widget CampoContrasenia, contiene un metodo dispose() para el
///controlador y un contendor con un TextField con la propiedad obscureText a true
class _CampoContraseniaState extends State<CampoContrasenia> {
  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    controllerContrasenia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: controllerContrasenia,
        //Esta propiedad evita que se muestre el texto
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Contraseña",
        ),
      ),
    );
  }
}

///Widget el cual es un boton que realiza la autentificacion
class BotonLogin extends StatefulWidget {
  const BotonLogin({super.key});

  @override
  State<BotonLogin> createState() => _BotonLoginState();
}

///Estado del Widget BotonLogin que devuelve un TextButton con un
///metodo que realiza una autentificacion en la base de datos
class _BotonLoginState extends State<BotonLogin> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue.shade300,
          padding: const EdgeInsets.symmetric(horizontal: 30),
        ),
        //Metodo explicado en el controlador
        onPressed: () {
          login(controllerEmail, controllerContrasenia, context);
        },
        child: const Text("Login"));
  }
}

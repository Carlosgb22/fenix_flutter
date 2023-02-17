///Clase que contiene todos los widgets creados por mi (Actividad 10 Desarrollo de Interfaces RA3)
import 'package:fenix_flutter/core/models/device_model.dart';
import 'package:fenix_flutter/core/providers/login_provider.dart';
import 'package:fenix_flutter/ui/view/device_detail.dart';
import 'package:flutter/material.dart';

///TextEditingController para el TextField del email y el TextField  de la contraseña
final controllerEmail = TextEditingController();
final controllerPassword = TextEditingController();

///Widget en el cual el usuario debe escribir su email
class FieldEmail extends StatefulWidget {
  const FieldEmail({super.key});

  @override
  State<FieldEmail> createState() => _FieldEmailState();
}

///Estado del Widget FieldEmail, contiene un metodo dispose()
///para el controlador y un contenedor con un TextField
class _FieldEmailState extends State<FieldEmail> {
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
class FieldPassword extends StatefulWidget {
  const FieldPassword({super.key});

  @override
  State<FieldPassword> createState() => FieldPasswordState();
}

///Estado del Widget FieldPassword, contiene un metodo dispose() para el
///controlador y un contendor con un TextField con la propiedad obscureText a true
class FieldPasswordState extends State<FieldPassword> {
  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: controllerPassword,
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
class ButtonLogin extends StatefulWidget {
  const ButtonLogin({super.key});

  @override
  State<ButtonLogin> createState() => _ButtonLoginState();
}

///Estado del Widget ButtonLogin que devuelve un TextButton con un
///metodo que realiza una autentificacion en la base de datos
class _ButtonLoginState extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue.shade300,
          padding: const EdgeInsets.symmetric(horizontal: 30),
        ),
        //Metodo explicado en el controlador
        onPressed: () {
          login(controllerEmail, controllerPassword, context);
        },
        child: const Text("Login"));
  }
}

class DeviceButton extends StatelessWidget {
  final Device device;
  const DeviceButton({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          side: const BorderSide(width: 3.0),
          textStyle: const TextStyle(fontSize: 15)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            Icons.devices_other,
            color: Colors.blue,
            size: 60,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 7),
            child: Text("Id: ${device.id}"),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 7),
            child: Text("Nombre: ${device.name}"),
          ),
        ],
      ),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DeviceDetails(id: device.id))),
    );
  }
}

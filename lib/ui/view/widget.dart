///Clase que contiene todos los widgets creados por mi (Actividad 10 Desarrollo de Interfaces RA3)
import 'package:fenix_flutter/core/models/device_model.dart';
import 'package:fenix_flutter/core/providers/delete_device_provider.dart';
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

///Widget el cual es un boton que muestra datos del dispositivo
class DeviceButton extends StatelessWidget {
  final Device device;
  //Se le pasa un dispositivo al boton con el cual se generará el boton
  const DeviceButton({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    //Devuelve un boton
    return TextButton(
      style: TextButton.styleFrom(
          side: const BorderSide(width: 3.0),
          textStyle: const TextStyle(fontSize: 15)),
      //Tiene una fila que se expande al ancho disponible de la pantalla
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //Lista de items que tiene la fila
        children: [
          //Icono proporcionado por flutter
          const Icon(
            Icons.devices_other,
            color: Colors.blue,
            size: 60,
          ),
          //Texto que indica el id del dispositivo
          Text("Id: ${device.id}"),
          //Texto que indica el nombre del dispositivo
          Text("Nombre: ${device.name}"),
          //Boton con icono de una papelera proporcionado por flutter
          IconButton(
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: Colors.red,
            ),
            //Cuando pulsas la papelera se borra el dispositivo indicado y te muestra un dialogo
            onPressed: () {
              deleteDevice(id: device.id);
              AlertDialog(
                content: Text("Dispositivo con id '${device.id}' eliminado"),
                actions: <Widget>[
                  TextButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/devices", (route) => false);
                      }),
                ],
              );
            },
          ),
        ],
      ),
      //Cuando pulsas el resto de la fila te muestra una pestaña con los detalles del dispositivo
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DeviceDetails(id: device.id))),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/lista_dispositivos.dart';

login(TextEditingController controllerEmail,
    TextEditingController controllerContrasenia, BuildContext context) {
  //Crea una instancia de FirebaseAuth
  FirebaseAuth.instance
      //Se llama a este metodo al cual se le pasa como parametros el correo
      //y contraseña introducidos en en los Widget CampoEmail y CampoContrasenia
      .signInWithEmailAndPassword(
          email: controllerEmail.text, password: controllerContrasenia.text)
      .then((user) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListaDispositivos()),
          ))
      //En caso de dar fallo se obtiene el error y mediante
      //su codigo de error se obtiene el mensaje de error
      .catchError((e) {
    String errorMessage;
    switch (e.code) {
      case "invalid-email":
        errorMessage = "La direccion de email esta malformada.";
        break;
      case "wrong-password":
        errorMessage = "La countraseña es incorrecta.";
        break;
      case "user-not-found":
        errorMessage = "No existe nigun usuario con este email.";
        break;
      case "user-disabled":
        errorMessage = "El usuario con este email ha sido deshabilitado.";
        break;
      case "operation-not-allowed":
        errorMessage = "Demasiadas peticiones, intentelo mas tarde.";
        break;
      default:
        errorMessage = "Un error ha ocurrido.";
    }
    //Se muestra en un AlertDialog el mensaje de Error obtenido anteriormente
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errorMessage),
          );
        });
  });
}

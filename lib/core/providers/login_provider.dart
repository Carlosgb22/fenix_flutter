import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///Este metodo comprueba de que el login se realice correctamente
///y en caso contrario te devuelve un mensaje de error
login(TextEditingController controllerEmail,
    TextEditingController controllerPassword, BuildContext context) {
  //Crea una instancia de FirebaseAuth
  FirebaseAuth.instance
      //Se llama a este metodo al cual se le pasa como parametros el correo
      //y contraseña introducidos en en los Widget CampoEmail y CampoContrasenia
      .signInWithEmailAndPassword(
          email: controllerEmail.text, password: controllerPassword.text)
      .then((user) => Navigator.pushNamedAndRemoveUntil(
          context, "/devices", (route) => false))
      //En caso de dar fallo se obtiene el error y mediante
      //su codigo de error se obtiene el mensaje de error
      // ignore: body_might_complete_normally_catch_error
      .catchError((e) {
    String errorMessage;
    switch (e.code) {
      case "invalid-email":
        return errorMessage = "La direccion de email esta malformada.";
      case "wrong-password":
        errorMessage = "La contraseña es incorrecta.";
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

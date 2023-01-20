import 'package:flutter/material.dart';

import '../widget.dart';

///Widget Login que contiene otros widgets
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

///Estado del widget Login, devuelve un Center que contiene una columna con una
///imagen y otra columna con decoracion de una linea negra y otra columna con
///varios widgets creados por mi como CampoEmail, Campocontrasenia y BotonLogin
class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image(
          image: AssetImage('assets/logo.png'),
          width: 400,
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            children: const [
              SizedBox(
                width: 300,
                child: CampoEmail(),
              ),
              SizedBox(
                width: 300,
                child: CampoContrasenia(),
              ),
              Padding(padding: EdgeInsets.all(10), child: BotonLogin())
            ],
          ),
        ),
      ],
    ));
  }
}

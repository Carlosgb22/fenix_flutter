import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/device_model.dart';

///Este metodo realiza una conexion con la api y devuelve una lista de dispositivos
Future<List<Device>> getDevicesHttp() async {
  var response = await http.get(Uri.parse("http://192.168.0.9:8080/devices"));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final deviceList = (data as List).map((e) => Device.fromJson(e)).toList();
    return deviceList;
  } else {
    throw Exception('Error al obtener el JSON');
  }
}

///Este metodo realiza una conexion con la api y devuelve el dispositivo con el id indicado
Future<Device> getDeviceByIdHttp(id) async {
  var response =
      await http.get(Uri.parse("http://192.168.0.9:8080/devices/$id"));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    var deviceData = data[0];
    return Device.fromJson(deviceData);
  } else {
    throw Exception('Error al obtener el JSON');
  }
}

///Este metodo realiza una conexion con la api y se le pasa un json con los datos del dispositivo
addDeviceHttp(String json) async {
  await http.post(Uri.parse("http://192.168.0.9:8080/devices/add"),
      body: json, headers: {"Content-type": "application/json"});
}

///Este metodo realiza una conexion con la api y se le pasa un json con los datos del dispositivo
updateDeviceHttp(String json, String id) async {
  await http.post(Uri.parse("http://192.168.0.9:8080/devices/$id/update"),
      body: json, headers: {"Content-type": "application/json"});
}

///Este metodo realiza una conexion con la api y elimina el dispositivo con el id que se le pasa
deleteDeviceHttp(id) async {
  await http.delete(Uri.parse("http://192.168.0.9:8080/devices/$id"));
}

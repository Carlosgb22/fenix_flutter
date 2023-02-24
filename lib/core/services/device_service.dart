import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/device_model.dart';

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

addDeviceHttp(String json) async {
  var response = await http.post(
      Uri.parse("http://192.168.0.9:8080/devices/add"),
      body: json,
      headers: {"Content-type": "application/json"});
  if (response.statusCode == 200) {
    //Hacer que recargue lista de dispositivos
  }
}

updateDeviceHttp(String json, String id) async {
  var response = await http.post(
      Uri.parse("http://192.168.0.9:8080/devices/$id/update"),
      body: json,
      headers: {"Content-type": "application/json"});
  if (response.statusCode == 200) {
    //Hacer que recargue lista de dispositivos
  }
}

deleteDeviceHttp(id) async {
  var response =
      await http.delete(Uri.parse("http://192.168.0.9:8080/devices/$id"));
  if (response.statusCode == 200) {
    return true;
  }
}

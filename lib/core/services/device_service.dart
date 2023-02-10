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

Future<Device> getDeviceByIdHttp() async {
  var response = await http.get(Uri.parse("http://192.168.0.9:8080/devices"));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final device = Device.fromJson(data);
    return device;
  } else {
    throw Exception('Error al obtener el JSON');
  }
}

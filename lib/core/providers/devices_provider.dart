import 'package:fenix_flutter/core/services/device_service.dart';
import '../models/device_model.dart';

///Este metodo obtiene una lista de dispositivos desde
///el metodo de la base de datos y los devuelve como un futuro
Future<List<Device>> getDevices() {
  var devices = getDevicesHttp();
  return Future.value(devices);
}

import 'package:fenix_flutter/core/services/device_service.dart';
import '../models/device_model.dart';

///Este metodo obtiene un dispositivo a partir de su id desde
///el metodo de la base de datos y lo devuelve como un futuro
Future<Device> getDeviceById(String id) {
  var device = getDeviceByIdHttp(id);
  return Future.value(device);
}

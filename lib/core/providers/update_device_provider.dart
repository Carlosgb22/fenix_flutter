import 'package:fenix_flutter/core/models/device_model.dart';
import 'package:fenix_flutter/core/services/device_service.dart';

///Este metodo obtiene un dispositivo lo convierte en
///json y se lo pasa al metodo de la base de datos
updateDevice({required Device device}) {
  var devJson = device.toJson();
  updateDeviceHttp(devJson, device.id);
}

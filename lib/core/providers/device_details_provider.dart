import 'package:fenix_flutter/core/services/device_service.dart';

import '../models/device_model.dart';

Future<Device> getDeviceById(String id) {
  var device = getDeviceByIdHttp();
  return Future.value(device);
}

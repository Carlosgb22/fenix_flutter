import 'package:fenix_flutter/core/services/device_service.dart';

import '../models/device_model.dart';

Future<List<Device>> getDevices() {
  var devices = getDevicesHttp();
  return Future.value(devices);
}

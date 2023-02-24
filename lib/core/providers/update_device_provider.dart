import 'package:fenix_flutter/core/models/device_model.dart';
import 'package:fenix_flutter/core/services/device_service.dart';

updateDevice({required Device device}) {
  var devJson = device.toJson();
  updateDeviceHttp(devJson, device.id);
}

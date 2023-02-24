import 'package:fenix_flutter/core/services/device_service.dart';

deleteDevice({required String id}) {
  deleteDeviceHttp(id);
}

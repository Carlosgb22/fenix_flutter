import 'package:fenix_flutter/core/services/device_service.dart';

///Este metodo obtiene el id de un dispositivo y se lo pasa al metodo de la base de datos
deleteDevice({required String id}) {
  deleteDeviceHttp(id);
}

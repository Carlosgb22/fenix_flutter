/// Clase Device la cual posee un metodo de factoria para obtener un dispositivo desde un json
///y otro metodo para convertir un dispositivo a json
class Device {
  final String id;
  final String name;
  final String userUid;
  String imgcon;
  String imgdiscon;
  String imgwait;

  Device({
    required this.id,
    required this.name,
    required this.userUid,
    required this.imgcon,
    required this.imgdiscon,
    required this.imgwait,
  });

  ///Metodo el cual obtiene datos en forma de mapa y devuelve un dispositivo
  factory Device.fromJson(Map<String, dynamic> data) {
    return Device(
        id: data['id'],
        name: data['name'],
        userUid: data['userUid'],
        imgcon: data['imgcon'],
        imgdiscon: data['imgdiscon'],
        imgwait: data['imgwait']);
  }

  ///Metodo para obtener un json a partir de un dispositivo
  String toJson() {
    return '{"id": "$id", "name": "$name", "userUid": "$userUid", "imgcon": "$imgcon", "imgdiscon": "$imgdiscon", "imgwait": "$imgwait"}';
  }

  @override
  String toString() {
    return 'Device{id: $id, name: $name, userUid: $userUid, imgcon: $imgcon, imgdiscon: $imgdiscon, imgwait: $imgwait}';
  }
}

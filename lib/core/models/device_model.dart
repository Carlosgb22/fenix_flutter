import 'dart:convert';

class Device {
  final String id;
  final String name;
  final String userUid;
  List<int> imgcon;
  List<int> imgdiscon;
  List<int> imgwait;

  Device({
    required this.id,
    required this.name,
    required this.userUid,
    required this.imgcon,
    required this.imgdiscon,
    required this.imgwait,
  });

  factory Device.fromJson(Map<String, dynamic> data) {
    var mapCon = (jsonDecode(jsonEncode(data['imgcon'])));
    var mapDiscon = jsonDecode(jsonEncode(data['imgdiscon']));
    var mapWait = jsonDecode(jsonEncode(data['imgwait']));
    return Device(
        id: data['id'],
        name: data['name'],
        userUid: data['userUid'],
        imgcon: List<int>.from(mapCon['data']),
        imgdiscon: List<int>.from(mapDiscon['data']),
        imgwait: List<int>.from(mapWait['data']));
  }

  String toJson() {
    imgcon = imgcon.toList();
    imgdiscon = imgdiscon.toList();
    imgwait = imgwait.toList();
    String dataString =
        '{"id": "$id", "name": "$name", "userUid": "$userUid", "imgcon": "$imgcon", "imgdiscon": "$imgdiscon", "imgwait": "$imgwait"}';
    return dataString;
  }

  @override
  String toString() {
    return 'Device{id: $id, name: $name, userUid: $userUid, imgcon: $imgcon, imgdiscon: $imgdiscon, imgwait: $imgwait}';
  }
}

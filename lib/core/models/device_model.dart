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

  factory Device.fromJson(Map<String, dynamic> data) {
    return Device(
        id: data['id'],
        name: data['name'],
        userUid: data['userUid'],
        imgcon: data['imgcon'],
        imgdiscon: data['imgdiscon'],
        imgwait: data['imgwait']);
  }

  String toJson() {
    return '{"id": "$id", "name": "$name", "userUid": "$userUid", "imgcon": "$imgcon", "imgdiscon": "$imgdiscon", "imgwait": "$imgwait"}';
  }

  @override
  String toString() {
    return 'Device{id: $id, name: $name, userUid: $userUid, imgcon: $imgcon, imgdiscon: $imgdiscon, imgwait: $imgwait}';
  }
}

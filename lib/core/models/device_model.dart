import 'package:cloud_firestore/cloud_firestore.dart';

class Device {
  final String id;
  final String name;
  final String userUid;
  final Blob? imgcon;
  final Blob? imgdiscon;
  final Blob? imgwait;

  Device({
    required this.id,
    required this.name,
    required this.userUid,
    this.imgcon,
    this.imgdiscon,
    this.imgwait,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      userUid: json['userUid'],
      imgcon: json['imgcon'],
      imgdiscon: json['imgdiscon'],
      imgwait: json['imgwait'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['userUid'] = userUid;
    if (data['imgcon'] != null) {
      data['imgcon'] = imgcon;
    }
    if (data['imgdiscon'] != null) {
      data['imgdiscon'] = imgdiscon;
    }
    if (data['imgwait'] != null) {
      data['imgwait'] = imgwait;
    }
    return data;
  }

  @override
  String toString() {
    return 'Device{id: $id, name: $name, userUid: $userUid, imgcon: $imgcon, imgdiscon: $imgdiscon, imgwait: $imgwait}';
  }
}

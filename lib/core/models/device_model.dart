import 'dart:typed_data';

import 'package:fenix_flutter/core/models/image_model.dart';

class Device {
  final String id;
  final String name;
  final String userUid;
  final Uint8List? imgcon;
  final Uint8List? imgdiscon;
  final Uint8List? imgwait;

  Device({
    required this.id,
    required this.name,
    required this.userUid,
    this.imgcon,
    this.imgdiscon,
    this.imgwait,
  });

  factory Device.fromJson(Map<String, dynamic> data) {
    return Device(
      id: data['id'],
      name: data['name'],
      userUid: data['userUid'],
      imgcon:
          data['imgcon'] != null ? Image.toUint8List(data['imgcon']).img : null,
      imgdiscon: data['imgdiscon'] != null
          ? Image.toUint8List(data['imgdiscon']).img
          : null,
      imgwait: data['imgwait'] != null
          ? Image.toUint8List(data['imgwait']).img
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['userUid'] = userUid;
    if (imgcon != null) {
      data['imgcon'] = Image.fromUint8List(imgcon!).imgJson;
    }
    if (imgdiscon != null) {
      data['imgdiscon'] = Image.fromUint8List(imgdiscon!).imgJson;
    }
    if (imgwait != null) {
      data['imgwait'] = Image.fromUint8List(imgwait!).imgJson;
    }
    return data;
  }

  @override
  String toString() {
    return 'Device{id: $id, name: $name, userUid: $userUid, imgcon: $imgcon, imgdiscon: $imgdiscon, imgwait: $imgwait}';
  }
}

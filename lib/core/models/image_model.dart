import 'dart:convert';
import 'dart:typed_data';

class Image {
  final Uint8List? img;

  Image({
    this.img,
  });

  factory Image.toUint8List(Map<String, dynamic> data) {
    String imgJ = jsonDecode((data['data']).toString()).toString();
    imgJ = imgJ.substring(1, imgJ.length - 1);
    List<String> imgList = imgJ.split(',');
    return Image(
        img: Uint8List.fromList(
            imgList.map((numb) => int.parse(numb)).toList()));
  }

  Map<String, dynamic> fromUint8List() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (img != null) {
      data['type'] = 'Buffer';
      data['imgcon'] = base64Encode(img!);
    }
    return data;
  }
}
/*
factory Image.fromJson(Map<String, dynamic> data) {
    final imgJ = jsonDecode(data['data']);
    return Image(
      img: imgJ['data'] != null ? base64Decode(imgJ['data']) : null,
    );
  }
*/
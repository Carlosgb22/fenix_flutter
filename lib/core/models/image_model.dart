import 'dart:convert';
import 'dart:typed_data';

class Image {
  final Uint8List? img;
  final Map<String, String> imgJson;

  Image({
    this.img,
    this.imgJson = const {},
  });

  factory Image.toUint8List(Map<String, dynamic> data) {
    String imgJ = jsonDecode((data['data']).toString()).toString();
    imgJ = imgJ.substring(1, imgJ.length - 1);
    List<String> imgList = imgJ.split(',');
    return Image(
      img: Uint8List.fromList(imgList.map((numb) => int.parse(numb)).toList()),
    );
  }

  static Image fromUint8List(Uint8List img) {
    return Image(
      img: img,
      imgJson: {'type': 'Buffer', 'data': base64Encode(img)},
    );
  }
}

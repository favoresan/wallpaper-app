import 'dart:ui';

class ColorManager {
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color primary = HexColor.fromHex('#0a101d');
  static Color lightBlue = HexColor.fromHex('#A9CDF4');
  static Color pink = HexColor.fromHex('#FF95C8');
  static Color lightGrey = HexColor.fromHex('#99999b');
  static Color yellow = HexColor.fromHex('#FFD675');
  static Color green = HexColor.fromHex('#A3F082');
  static Color transBlack = HexColor.fromHex('#1c1b1b');
  static Color cream = HexColor.fromHex('#F9BA6D');
  static Color lightYellow = HexColor.fromHex('#F8F843');
  // static Color darkPink = HexColor.fromHex('#FF44EC');
  static Color darkPink = HexColor.fromHex('#FF44EC');
  static Color black = HexColor.fromHex('#070a16');
  static Color error = HexColor.fromHex('#e61f34');
  static Color search = HexColor.fromHex('#1e202e');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}

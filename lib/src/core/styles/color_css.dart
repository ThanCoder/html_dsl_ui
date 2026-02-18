import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

enum ColorName { red, blue, green, chocolate, teal, gray, yellow }

class Color {
  final List<String> colorList;
  const Color(this.colorList);

  /// ### ၁။ Standard Color Names
  factory Color.fromName(ColorName value) {
    return Color([value.name]);
  }

  /// ### ၂။ RGB Format: rgb(255, 0, 0)
  factory Color.rgb(int r, int g, int b) {
    return Color(['rgb(', '$r,', '$g,', '$b', ')']);
  }

  /// ### ၃။ RGBA Format: rgba(255, 0, 0, 0.5)
  factory Color.rgba(int r, int g, int b, double a) {
    return Color(['rgba(', '$r,', '$g,', '$b,', '$a', ')']);
  }

  /// ### ၄။ Hex Format: #ffffff
  factory Color.hex(String hex) {
    final h = hex.startsWith('#') ? hex : '#$hex';
    return Color([h]);
  }

  String get value => colorList.join('');
}

extension ColorCssExtension on StyleBuilder {
  StyleBuilder color(Color color) {
    addStyle('color', color.value);
    return this;
  }

  StyleBuilder backgroundColor(Color color) {
    addStyle('background-color:', color.value);
    return this;
  }
}

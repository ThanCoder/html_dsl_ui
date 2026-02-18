import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

class PseudoBuilder {
  final Map<String, Map<String, String>> _pseudoMap = {};

  // Chaining လုပ်ဖို့ helper function
  PseudoBuilder on(String name, StyleBuilder style) {
    _pseudoMap[name] = style.build();
    return this;
  }

  // အသုံးများတဲ့ pseudo တွေအတွက် shorthand
  PseudoBuilder hover(StyleBuilder style) => on(':hover', style);
  PseudoBuilder active(StyleBuilder style) => on(':active', style);
  PseudoBuilder focus(StyleBuilder style) => on(':focus', style);

  Map<String, Map<String, String>> build() => _pseudoMap;
}

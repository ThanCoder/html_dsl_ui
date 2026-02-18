import 'package:html_dsl_ui/src/core/styles/media_builder.dart';
import 'package:html_dsl_ui/src/core/styles/pseudo_builder.dart';
import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

class Style {
  final StyleBuilder styleBuilder;
  final PseudoBuilder? pseudo; // { ":hover": {...}, ":active": {...} }
  final MediaBuilder? media;
  String? _selector;

  Style({String? selector, required this.styleBuilder, this.pseudo, this.media})
    : _selector = selector;

  void setSelector(String selector) {
    _selector = selector;
  }

  String? get selector => _selector;

  String render() {
    StringBuffer css = StringBuffer();
    if (selector == null) return '';

    // 1. Base Styles
    css.writeln("$selector { ${_map(styleBuilder.build())} }");

    // 2. Pseudo-classes & Elements (:hover, :active, ::before, etc.)
    pseudo?.build().forEach((key, rules) {
      css.writeln("$selector$key { ${_map(rules)} }");
    });

    // 3. Media Queries
    media?.build().forEach((query, rules) {
      css.writeln("@media $query { $selector { ${_map(rules)} } }");
    });

    return css.toString();
  }

  String _map(Map<String, String> m) =>
      m.entries.map((e) => "${e.key}: ${e.value};").join(" ");
}

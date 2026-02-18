import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

class MediaBuilder {
  final Map<String, Map<String, String>> _mediaMap = {};

  // query: "(max-width: 600px)"
  MediaBuilder on(String query, Map<String, String> styles) {
    _mediaMap[query] = styles;
    return this;
  }

  // Shorthand for mobile
  MediaBuilder mobile(StyleBuilder style) =>
      on("(max-width: 600px)", style.build());

  Map<String, Map<String, String>> build() => _mediaMap;
}

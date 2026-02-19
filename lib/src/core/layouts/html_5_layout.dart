import 'package:html_dsl_ui/html_dsl_ui.dart';
import 'package:html_dsl_ui/src/core/engine/html_ui_engine.dart';
import 'package:html_dsl_ui/src/core/styles/style.dart';

class Html5Layout {
  final Widget child;
  final String? title;
  final Style? globalStyle;
  final bool manify;
  final void Function(String generatedCss)? onGenereatedCss;
  final void Function(String generatedJs)? onGenereatedJs;
  const Html5Layout(
    this.child, {
    this.title,
    this.globalStyle,
    this.manify = false,
    this.onGenereatedCss,
    this.onGenereatedJs,
  });

  String get _getAllCss {
    final buff = StringBuffer();
    final styleContent = HtmlUiEngine.generateCssOnly();

    if (globalStyle != null) {
      buff.writeln(globalStyle?.render());
    }
    if (styleContent.isNotEmpty) {
      buff.writeln(styleContent);
    }
    if (onGenereatedCss != null) {
      onGenereatedCss?.call(buff.toString());
      return '';
    }

    return buff.toString();
  }

  String get _getAllJs {
    final buff = StringBuffer();
    final jsCodeContent = HtmlUiEngine.generateJsOnly();

    if (jsCodeContent.isNotEmpty) {
      buff.writeln(jsCodeContent);
    }
    if (onGenereatedJs != null) {
      onGenereatedJs?.call(buff.toString());
      return '';
    }

    return buff.toString();
  }

  String get toHtml {
    final html = HtmlUiEngine.render(child);

    final res =
        '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title ?? 'Document'}</title>
    ${_getAllCss.isNotEmpty ? '<style>$_getAllCss</style>' : ''}
</head>
<body>
    $html

    ${_getAllJs.isNotEmpty ? '<script>$_getAllJs</script>' : ''}
</body>
</html>
''';
    if (manify) {
      return res.replaceAll('\n', '');
    }
    return res.trim();
  }
}

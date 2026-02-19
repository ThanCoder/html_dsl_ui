import 'package:html_dsl_ui/src/core/js/script.dart';
import 'package:html_dsl_ui/src/core/styles/style.dart';

abstract class Widget {
  const Widget();
}

abstract class StatelessWidget extends Widget {
  const StatelessWidget();
  Widget build();
}

class TextWidget extends Widget {
  final String text;
  const TextWidget(this.text);
}

class HtmlWidget extends Widget {
  final String tag;
  final String? id;
  final String? className;
  final Map<String, String>? attributes;
  final List<Widget>? children;
  final Style? style;
  final Script? script;
  final bool selfClosingTag;

  const HtmlWidget(
    this.tag, {
    this.selfClosingTag = false,
    this.attributes,
    this.children,
    this.id,
    this.className,
    this.style,
    this.script,
  });
}

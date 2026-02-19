import 'package:html_dsl_ui/html_dsl_ui.dart';

class Button extends HtmlWidget {
  final String text;
  Button(this.text, {super.attributes, super.style, super.script})
    : super('button', children: [TextWidget(text)]);
}

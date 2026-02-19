import 'package:html_dsl_ui/html_dsl_ui.dart';
import 'package:html_dsl_ui/src/core/styles/style.dart';
import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

class Card extends HtmlWidget {
  final Widget child;
  Card({
    super.attributes,
    super.id,
    super.className,
    super.script,
    Style? style,
    required this.child,
  }) : super(
         'div',
         style:
             style ??
             Style(
               styleBuilder: StyleBuilder().addRaw({
                 "border-radius": "12px",
                 "box-shadow": "0 4px 6px rgba(0,0,0,0.1)",
                 "border": "1px solid #eee",
                 "margin": "10px",
               }),
             ),
         children: [child],
       );
}

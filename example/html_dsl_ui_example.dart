import 'dart:io';

import 'package:html_dsl_ui/html_dsl_ui.dart';
import 'package:html_dsl_ui/src/core/html_elements/card.dart';
import 'package:html_dsl_ui/src/core/html_elements/elements.dart';
import 'package:html_dsl_ui/src/core/html_elements/list_elments.dart';
import 'package:html_dsl_ui/src/core/layouts/html_5_layout.dart';
import 'package:html_dsl_ui/src/core/styles/color_css.dart';
import 'package:html_dsl_ui/src/core/styles/css_unit.dart';
import 'package:html_dsl_ui/src/core/styles/cursor_css.dart';
import 'package:html_dsl_ui/src/core/styles/pseudo_builder.dart';
import 'package:html_dsl_ui/src/core/styles/style.dart';
import 'package:html_dsl_ui/src/core/styles/style_builder.dart';
import 'package:html_dsl_ui/src/core/styles/wh_css.dart';

void main() async {
  final app = App();
  final html = Html5Layout(
    app,
    title: 'My Title',
    manify: false,
    globalStyle: Style(
      selector: 'body',
      styleBuilder: StyleBuilder().padding(0.px).margin(0.px),
    ),
  ).toHtml;

  final file = File('res.html');
  await file.writeAsString(html);
}

class App extends StatelessWidget {
  @override
  Widget build() {
    return Div(
      attributes: {'id': '5'},
      children: [
        Div(
          children: [
            TextWidget('hello'),
            H1(
              style: Style(
                styleBuilder: StyleBuilder().color(
                  Color.fromName(ColorName.red),
                ),
                pseudo: PseudoBuilder().hover(
                  StyleBuilder()
                      .cursor(Cursor.pointer)
                      .color(Color.hex('#444444')),
                ),
              ),
              children: [TextWidget('i am h1 widget')],
            ),
            UnorderedList(items: [ListItem('name'),ListItem('age')]),
            Column(
              children: [
                H3(children: [TextWidget('column')]),
                H3(children: [TextWidget('column')]),
                H3(children: [TextWidget('column')]),
                H3(children: [TextWidget('column')]),
              ],
            ),
            Row(
              children: [
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
              ],
            ),
            Card(
              child: Img(
                style: Style(
                  styleBuilder: StyleBuilder().width(100.px).height(100.px),
                ),
                src:
                    'https://www.thebiglead.com/wp-content/uploads/2026/02/default-695-1536x1021.jpg',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

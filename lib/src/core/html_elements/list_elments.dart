import 'package:html_dsl_ui/html_dsl_ui.dart';
import 'package:html_dsl_ui/src/core/styles/style.dart';
import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

class ListItem extends StatelessWidget {
  final String text;
  final Style? itemStyle;

  const ListItem(this.text, {this.itemStyle});

  @override
  Widget build() {
    return HtmlWidget('li', style: itemStyle, children: [TextWidget(text)]);
  }
}

class UnorderedList extends StatelessWidget {
  final List<ListItem> items;
  final String? id;

  const UnorderedList({required this.items, this.id});

  @override
  Widget build() {
    return HtmlWidget(
      'ul',
      style: Style(
        styleBuilder: StyleBuilder().addRaw({
          "list-style": "none",
          "padding": "0",
        }),
      ),
      children: items,
    );
  }
}

class Column extends HtmlWidget {
  final String gap;
  Column({required List<Widget> children, Style? style, this.gap = '10px'})
    : super(
        'div',
        style: style,
        children: children,
        attributes: {"style": "display: flex; flex-direction: column;gap:$gap"},
      );
}

class Row extends HtmlWidget {
  final String gap;
  Row({required List<Widget> children, Style? style, this.gap = '10px'})
    : super(
        'div',
        style: style,
        children: children,
        attributes: {"style": "display: flex; flex-direction: row;gap:$gap"},
      );
}

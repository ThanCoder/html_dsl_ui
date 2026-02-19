import 'package:html_dsl_ui/html_dsl_ui.dart';

class Div extends HtmlWidget {
  const Div({
    super.attributes,
    super.style,
    super.script,
    super.id,
    super.className,
    required super.children,
  }) : super('div');
}

class Span extends HtmlWidget {
  const Span({
    super.attributes,
    super.style,
    super.script,
    super.id,
    super.className,

    required super.children,
  }) : super('span');
}

class H1 extends HtmlWidget {
  const H1({
    super.attributes,
    super.style,
    super.script,
    super.id,
    super.className,

    required super.children,
  }) : super('h1');
}

class H2 extends HtmlWidget {
  const H2({
    super.attributes,
    super.style,
    super.script,
    super.id,
    super.className,

    required super.children,
  }) : super('h2');
}

class H3 extends HtmlWidget {
  const H3({
    super.attributes,
    super.style,
    super.script,
    super.id,
    super.className,
    required super.children,
  }) : super('h3');
}

class H4 extends HtmlWidget {
  const H4({
    super.attributes,
    super.style,
    super.script,
    super.id,
    super.className,
    required super.children,
  }) : super('h4');
}

class Img extends HtmlWidget {
  final String src;
  final String alt;
  Img({
    required this.src,
    this.alt = 'Img',
    super.style,
    super.script,
    super.id,
    super.className,
    Map<String, String>? attributes,
  }) : super(
         'img',
         attributes: {'src': src, 'alt': alt, ...?attributes},
         selfClosingTag: true,
       );
}

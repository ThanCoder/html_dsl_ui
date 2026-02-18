import 'package:html_dsl_ui/html_dsl_ui.dart';
import 'package:html_dsl_ui/src/core/styles/style.dart';

class _IdGenerator {
  static int _number = 0;
  static void clear() {
    _number = 0;
  }

  static int get genNumber {
    _number++;
    return _number;
  }
}

class HtmlUiEngine {
  // HTML5 Void Elements စာရင်း
  static const _voidElements = {
    'area',
    'base',
    'br',
    'col',
    'embed',
    'hr',
    'img',
    'input',
    'link',
    'meta',
    'param',
    'source',
    'track',
    'wbr',
  };

  static final Set<Style> _styleRegistry = {};

  static String render(Widget widget) {
    if (widget is TextWidget) {
      return widget.text;
    } else if (widget is StatelessWidget) {
      return render(widget.build());
    } else if (widget is HtmlWidget) {
      final attributes = {...?widget.attributes};
      final children = [...?widget.children];

      // style
      if (widget.style != null) {
        if (widget.style!.selector == null) {
          attributes['dsl-ui-id'] = _IdGenerator.genNumber.toString();
          widget.style!.setSelector('[dsl-ui-id="${attributes['dsl-ui-id']}"]');
        }
        _styleRegistry.add(widget.style!);
      }

      final attrs = attributes.entries
          .map((e) => ' ${e.key}="${e.value}"')
          .join('');
      final result = children.map((e) => render(e)).join('');
      if (_voidElements.contains(widget.tag.toLowerCase())) {
        return '<${widget.tag}$attrs/>';
      }
      return '<${widget.tag}$attrs>$result</${widget.tag}>';
    }

    return '';
  }

  // CSS သီးသန့် ထုတ်ယူခြင်း (For style.css file)
  static String generateCssOnly() {
    return _styleRegistry.map((s) => s.render()).join("\n");
  }

  String toHtml(Widget widget) {
    _styleRegistry.clear();
    _IdGenerator.clear();
    return HtmlUiEngine.render(widget);
  }
}

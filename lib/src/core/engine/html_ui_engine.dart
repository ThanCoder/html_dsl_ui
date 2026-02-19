import 'package:html_dsl_ui/html_dsl_ui.dart';
import 'package:html_dsl_ui/src/core/js/script.dart';
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
  static final Set<Style> _styleRegistry = {};
  static final Set<Script> _scriptRegistry = {};

  static String render(Widget widget) {
    if (widget is TextWidget) {
      return widget.text;
    } else if (widget is StatelessWidget) {
      return render(widget.build());
    }
    // html element widget
    else if (widget is HtmlWidget) {
      final attributes = {...?widget.attributes};
      final children = [...?widget.children];
      if (widget.id != null) {
        attributes['id'] = widget.id!;
      }
      if (widget.className != null) {
        attributes['class'] = widget.className!;
      }

      // Style Processing
      if (widget.style != null) {
        if (widget.style!.selector == null) {
          attributes['dsl-ui-id'] = _IdGenerator.genNumber.toString();
          widget.style!.setSelector('[dsl-ui-id="${attributes['dsl-ui-id']}"]');
        }
        _styleRegistry.add(widget.style!);
      }
      // Script Processing
      if (widget.script != null) {
        // Element မှာ ID မရှိသေးရင် Auto ID တပ်ပေးမယ်
        if (!attributes.containsKey('dsl-ev-id')) {
          attributes['dsl-ev-id'] = _IdGenerator.genNumber.toString();
        }
        widget.script!.setTargetId("[dsl-ev-id='${attributes['dsl-ev-id']}']");
        widget.script!.setElementVarName('element_${attributes['dsl-ev-id']}');
        _scriptRegistry.add(widget.script!);
      }

      // attributes
      final attrs = attributes.entries
          .map((e) => ' ${e.key}="${e.value}"')
          .join('');
      // html result
      final result = children.map((e) => render(e)).join('');

      // single tag or multi tag
      if (widget.selfClosingTag) {
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

  // JS သီးသန့် ထုတ်ယူခြင်း (For script.js file သို့မဟုတ် <script> tag ထဲထည့်ရန်)
  static String generateJsOnly() {
    // JS Code တွေကို IIFE (Immediately Invoked Function Expression) နဲ့
    // အုပ်ပေးတာက Variable Scope မထပ်အောင် ကာကွယ်ပေးပါတယ်
    return _scriptRegistry.map((s) => s.render()).join("\n\n");
  }

  String toHtml(Widget widget) {
    _styleRegistry.clear();
    _scriptRegistry.clear();
    _IdGenerator.clear();
    return HtmlUiEngine.render(widget);
  }
}

import 'package:html_dsl_ui/src/core/js/js_html_event.dart';
import 'package:html_dsl_ui/src/core/js/js_response.dart';
import 'package:html_dsl_ui/src/core/js/js_template.dart';

class Script {
  String? _targetId;
  String? _elementVarNameValue;
  final String _elementVarNamePlaceholder = '{{ele_var_name}}';

  final List<String> _statements = [];
  Script();

  void setTargetId(String id) {
    _targetId = id;
  }

  void setElementVarName(String varName) {
    _elementVarNameValue = varName;
  }

  String get elementVarName => _elementVarNameValue!;

  ///
  /// ### JS: .addEventListener(event, callback)
  /// callback -> `[event]`
  Script addEventListener(JsHtmlEvent event, {required Script callback}) {
    _statements.add(
      '$_elementVarNamePlaceholder.addEventListener("${event.name}", (event) => {',
    );
    _statements.add(callback.renderContentOnly());
    _statements.add('});');
    return this;
  }

  ///
  /// ### JS: .addEventListener(event, callback)
  /// callback -> `[event]`
  Script on(JsHtmlEvent event, {required Script callback}) {
    _statements.add(
      '$_elementVarNamePlaceholder.addEventListener("${event.name}", (event) => {',
    );
    _statements.add(callback.renderContentOnly());
    _statements.add('});');
    return this;
  }

  ///
  /// တခြား element တစ်ခုကို selector နဲ့ ဖမ်းပြီး ခိုင်းချင်တဲ့အခါ
  ///
  /// logic: `const target = document.querySelector(".my-div"); target.innerText = "...";`
  ///
  Script queryAnd(String selector, Script action) {
    final tempVar = "target_${DateTime.now().millisecondsSinceEpoch}";
    _statements.add('const $tempVar = document.querySelector("$selector");');
    _statements.add(
      action.renderContentOnly(tempVar),
    ); // action ထဲက placeholder တွေကို tempVar နဲ့ အစားထိုးမယ်
    return this;
  }

  ///
  /// JS: fetch()
  ///
  /// onCache -> `[error]` js var
  ///
  Script fetch(
    String url, {
    required String jsDataVarName,
    required Script onSuccess,
    JsResponseType fetchResponseType = JsResponseType.json,
    Script? onCatch,
  }) {
    _statements.add('''
    fetch("$url")
      .then(r => {
        if (!r.ok) throw new Error(r.statusText);
        return r.${fetchResponseType.name}();
      })
      .then($jsDataVarName => {
  ''');
    _statements.add(onSuccess.renderContentOnly());
    _statements.add('})');
    if (onCatch != null) {
      _statements.add('.catch((error) => {');
      _statements.add(onCatch.renderContentOnly());
      _statements.add('})');
    }
    _statements.add(';');
    return this;
  }

  ///
  /// ### JS: .innerHTML = value
  ///
  Script setInnerHtml(String html, {bool isJsVar = false}) {
    if (isJsVar) {
      _statements.add('$_elementVarNamePlaceholder.innerHTML = $html;');
    } else {
      _statements.add('$_elementVarNamePlaceholder.innerHTML = "$html";');
    }
    return this;
  }

  // Script Class ထဲမှာ ဒီ method တွေ ထပ်ထည့်ပါ
  Script setDisabled(bool disabled) {
    _statements.add('$_elementVarNamePlaceholder.disabled = $disabled;');
    return this;
  }

  Script setText(String text, {bool isJsVar = false}) {
    if (isJsVar) {
      _statements.add('$_elementVarNamePlaceholder.textContent = $text;');
    } else {
      _statements.add('$_elementVarNamePlaceholder.textContent = "$text";');
    }
    return this;
  }

  // condition: JS condition (ဥပမာ 'e.target.value === ""')
  // trueCase: မှန်ရင် လုပ်ရမယ့် Script
  // falseCase: မှားရင် လုပ်ရမယ့် Script (Optional)
  Script ifBlock(
    String condition, {
    required Script trueCase,
    Script? falseCase,
  }) {
    _statements.add('if ($condition) {');
    _statements.add(
      trueCase.renderContentOnly(
        _elementVarNameValue ?? _elementVarNamePlaceholder,
      ),
    );
    _statements.add('}');

    if (falseCase != null) {
      _statements.add('else {');
      _statements.add(
        falseCase.renderContentOnly(
          _elementVarNameValue ?? _elementVarNamePlaceholder,
        ),
      );
      _statements.add('}');
    }
    return this;
  }

  ///
  /// Js Loop Map
  ///
  Script map(
    String jsDataVar,
    String itemVarName, {
    required JsTemplate template,
  }) {
    _statements.add('if (Array.isArray($jsDataVar)) {');
    _statements.add(
      '$_elementVarNamePlaceholder.innerHTML = $jsDataVar.map(($itemVarName) => `${template.toJsHtml()}`).join("");',
    );
    _statements.add('}');
    return this;
  }

  // Logic: Console log ထုတ်မယ်
  Script log(String message, {bool isJsVar = false}) {
    if (isJsVar) {
      _statements.add('console.log($message);');
    } else {
      _statements.add('console.log(`$message`);');
    }
    return this;
  }

  Script alert(String message, {bool isJsVar = false}) {
    if (isJsVar) {
    } else {
      _statements.add('window.alert($message);');
    }
    _statements.add('window.alert(`$message`);');
    return this;
  }

  String render() {
    if (_targetId == null) return '';

    // selector ကနေ element ကို အရင်ဖမ်းတဲ့ statement ကို အပေါ်ဆုံးက ထားမယ်
    final initLine =
        'const $elementVarName = document.querySelector("$_targetId")';
    // placeholder
    final processStatements = _statements.map(
      (e) => e.replaceAll(_elementVarNamePlaceholder, _elementVarNameValue!),
    );
    return [initLine, ...processStatements].join('\n ');
  }

  // Nested script တွေအတွက်လည်း Placeholder အစားထိုးဖို့ လိုတယ်
  // ဒါပေမဲ့ parent ရဲ့ element name ကို လှမ်းပေးရမယ်
  String renderContentOnly([String? parentVarName]) {
    final targetVar =
        parentVarName ??
        _elementVarNameValue ??
        _elementVarNamePlaceholder; // default တစ်ခုထားပေးခြင်း
    return _statements
        .map((s) => s.replaceAll(_elementVarNamePlaceholder, targetVar))
        .join('\n');
  }
}

import 'package:html_dsl_ui/html_dsl_ui.dart';

class Input extends HtmlWidget {
  final InputType type;
  final String? placeholder;
  final bool disabled;
  Input({
    super.style,
    super.script,
    super.id,
    super.className,
    Map<String, String>? attributes,
    this.type = InputType.text,
    this.placeholder,
    this.disabled = false,
  }) : super(
         'input',
         selfClosingTag: true,
         attributes: {
           'type': type.value,
           if (disabled) 'disable': '',
           'placeholder': ?placeholder,
           ...?attributes,
         },
       );
}

enum InputType {
  text,
  password,
  email,
  number,
  checkbox,
  radio,
  file,
  date,
  datetimeLocal, // 'datetime-local' ဖြစ်ရပါမယ်
  month,
  week,
  time,
  color,
  range,
  search,
  tel,
  url,
  submit,
  reset,
  button,
  hidden,
  image;

  // JS/HTML မှာ သုံးရမယ့် string value ကို ပြန်ထုတ်ပေးမယ်
  String get value {
    if (this == InputType.datetimeLocal) return 'datetime-local';
    return name;
  }
}

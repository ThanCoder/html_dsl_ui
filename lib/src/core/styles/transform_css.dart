import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

extension TransformExtensions on StyleBuilder {
  StyleBuilder rotate(int degree) {
    addStyle('transform', 'rotate(${degree}deg)');
    return this;
  }

  // အနုစိတ်ချင်ရင် transform တိုက်ရိုက်သုံးလို့ရအောင်
  StyleBuilder transformRaw(String value) {
    addStyle('transform', value);
    return this;
  }
}

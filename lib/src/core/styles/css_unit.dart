// Numbers ကို Unit ပြောင်းရန်
import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

extension CSSUnitExtension on num {
  String get px => '${this}px';
  String get em => '${this}em';
  String get rem => '${this}rem';
  String get percent => '$this%';
  String get vh => '${this}vh';
  String get vw => '${this}vw';
}

extension StyleBuilderMgPd on StyleBuilder {
  ///
  /// 0.px
  ///
  StyleBuilder padding(String cssUnitNumber) {
    addStyle('padding', cssUnitNumber);
    return this;
  }

  ///
  /// 0.px
  ///
  StyleBuilder margin(String cssUnitNumber) {
    addStyle('margin', cssUnitNumber);
    return this;
  }
}

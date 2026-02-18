import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

extension WHCssExtensions on StyleBuilder {
  ///
  /// 0.px
  ///
  StyleBuilder width(String cssUnite) {
    addStyle('width', cssUnite);
    return this;
  }

  ///
  /// 0.px
  ///
  StyleBuilder height(String cssUnite) {
    addStyle('height', cssUnite);
    return this;
  }
}

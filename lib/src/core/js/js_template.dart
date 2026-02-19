abstract class JsTemplate {
  const JsTemplate();
  String toJsHtml();
}

class JsTemplateRaw extends JsTemplate {
  final String template;
  const JsTemplateRaw(this.template);

  @override
  String toJsHtml() {
    return template;
  }
}

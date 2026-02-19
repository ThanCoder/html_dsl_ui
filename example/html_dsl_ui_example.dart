import 'dart:io';

import 'package:html_dsl_ui/html_dsl_ui.dart';

void main() async {
  final app = App();
  final html = Html5Layout(
    app,
    title: 'My Title',
    manify: false,
    globalStyle: Style(
      selector: 'body',
      styleBuilder: StyleBuilder().padding(0.px).margin(0.px),
    ),
  ).toHtml;

  final file = File('res.html');
  await file.writeAsString(html);
}

class App extends StatelessWidget {
  @override
  Widget build() {
    return Div(
      attributes: {'id': '5'},
      children: [
        H1(
          style: Style(
            styleBuilder: StyleBuilder().color(Color.fromName(ColorName.green)),
            pseudo: PseudoBuilder().hover(
              StyleBuilder()
                  .color(Color.fromName(ColorName.red))
                  .cursor(Cursor.progress),
            ),
            media: MediaBuilder(),
          ),

          children: [TextWidget('I am H1 Text')],
        ),
        Div(
          children: [
            Button(
              'Fetch Api',

              script: Script().on(
                JsHtmlEvent.click,
                callback: Script()
                    .setText('Loading...')
                    .fetch(
                      'https://jsonplaceholder.typicode.com/posts',
                      jsDataVarName: 'posts',
                      onSuccess: Script()
                          .setText('Fetched')
                          .log('posts', isJsVar: true)
                          .queryAnd(
                            '#fetch-api-result',
                            Script().map(
                              'posts',
                              'item',
                              template: JsTemplateRaw(
                                '<li>Title: \${item.title}</li>',
                              ),
                            ),
                          ),
                      onCatch: Script().setText('error', isJsVar: true),
                    ),
              ),
            ),
            Div(id: 'fetch-api-result', children: []),
          ],
        ),
      ],
    );
  }
}

class PostItemTemplate extends JsTemplate {
  final String jsVarName;
  const PostItemTemplate(this.jsVarName);

  @override
  String toJsHtml() {
    return HtmlUiEngine.render(Card(child: TextWidget('\${$jsVarName.title}')));
  }
}

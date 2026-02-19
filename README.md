# HTML DSL UI Generatator

### Example

```dart
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
        Div(
          children: [
            TextWidget('hello'),
            H1(
              style: Style(
                styleBuilder: StyleBuilder().color(
                  Color.fromName(ColorName.red),
                ),
                pseudo: PseudoBuilder().hover(
                  StyleBuilder()
                      .cursor(Cursor.pointer)
                      .color(Color.hex('#444444')),
                ),
              ),
              children: [TextWidget('i am h1 widget')],
            ),
            UnorderedList(items: [ListItem('name'),ListItem('age')]),
            Column(
              children: [
                H3(children: [TextWidget('column')]),
                H3(children: [TextWidget('column')]),
                H3(children: [TextWidget('column')]),
                H3(children: [TextWidget('column')]),
              ],
            ),
            Row(
              children: [
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
                H3(children: [TextWidget('row')]),
              ],
            ),
            Card(
              child: Img(
                style: Style(
                  styleBuilder: StyleBuilder().width(100.px).height(100.px),
                ),
                src:
                    'https://www.thebiglead.com/wp-content/uploads/2026/02/default-695-1536x1021.jpg',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

```

## Css Style

```dart
 H1(
  style: Style(
    // css style
    styleBuilder: StyleBuilder().color(Color.fromName(ColorName.green)),

    // pseudo class
    pseudo: PseudoBuilder().hover(
      StyleBuilder()
          .color(Color.fromName(ColorName.red))
          .cursor(Cursor.progress),
    ),
    media: MediaBuilder(), //media query
  ),
  children: [TextWidget('I am H1 Text')],
),
```

## QueryAnd

```dart
 Script().queryAnd(
    '#h1', //another element id
    Script().setText('event.target.value', isJsVar: true),
  ),
```

## Input

```dart
Input(
  type: InputType.text,
  placeholder: 'text placeholder',
  script: Script().addEventListener(
    JsHtmlEvent.input,
    callback: Script().queryAnd(
      '#h1',
      Script().setText('event.target.value', isJsVar: true),
    ),
  ),
),
```

## Js Fetch

```dart
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
                  template: JsTemplateRaw('<li>Title: \${item.title}</li>'),
                ),
              ),
          onCatch: Script().setText('error', isJsVar: true),
        ),
  ),
),
```

## Condition

```dart
Button(
  'check condition',
  script: Script().on(
    JsHtmlEvent.click,
    callback: Script().ifBlock(
      'true',
      trueCase: Script().queryAnd('#h1', Script().setText('True')),
      falseCase: Script().queryAnd(
        '#h1',
        Script().setText('False'),
      ),
    ),
  ),
),
```

## JsTemplate

```dart
JsTemplateRaw('<li>Title: \${item.title}</li>')

class PostItemTemplate extends JsTemplate {
  final String jsVarName;
  const PostItemTemplate(this.jsVarName);

  @override
  String toJsHtml() {
    return HtmlUiEngine.render(Card(child: TextWidget('\${$jsVarName.title}')));
  }
}
```

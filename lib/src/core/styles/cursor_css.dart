import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

enum Cursor {
  pointer('pointer'),
  help('help'),
  wait('wait'),
  crosshair('crosshair'),
  notAllowed('not-allowed'),
  zoomIn('zoom-in'),
  auto('auto'),
  none('none'),
  contextMenu('context-menu'),
  progress('progress'),
  cell('cell'),
  text('text'),
  verticalText('vertical-text'),
  alias('alias'),
  copy('copy'),
  move('move'),
  noDrop('no-drop'),
  grab('grab'),
  grabbing('grabbing'),
  eResize('e-resize'),
  nResize('n-resize'),
  neResize('ne-resize'),
  nwResize('nw-resize'),
  sResize('s-resize'),
  seResize('se-resize'),
  swResize('sw-resize'),
  wResize('w-resize'),
  ewResize('ew-resize'),
  nsResize('ns-resize'),
  neswResize('nesw-resize'),
  nwseResize('nwse-resize'),
  colResize('col-resize'),
  rowResize('row-resize'),
  allScroll('all-scroll'),
  zoomOut('zoom-out');

  final String value;
  const Cursor(this.value);
}

extension CursorCssExtension on StyleBuilder {
  StyleBuilder cursor(Cursor cursor) {
    addStyle('cursor', cursor.value);
    return this;
  }
}

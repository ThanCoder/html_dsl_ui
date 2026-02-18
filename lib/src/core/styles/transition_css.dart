import 'package:html_dsl_ui/src/core/styles/style_builder.dart';

class Transition {
  final List<String> cssList;
  const Transition(this.cssList);

  ///* property name | duration */
  factory Transition.applyNameDur(String name, {required Duration duration}) {
    return Transition([name, '${duration.inMilliseconds}ms']);
  }

  ///* property name | duration | delay */
  factory Transition.applyNameDurDelay(
    String name, {
    required Duration duration,
    required Duration delay,
  }) {
    return Transition([
      name,
      '${duration.inMilliseconds}ms',
      '${delay.inMilliseconds}ms',
    ]);
  }

  ///* duration */
  factory Transition.apply(Duration duration) {
    return Transition(['${duration.inMilliseconds}ms']);
  }

  String get css => cssList.join(' ');
}

extension TransitionExtensions on StyleBuilder {
  StyleBuilder transitionApply(Transition transition) {
    addStyle('transition', transition.css);
    return this;
  }

  // အနုစိတ်ချင်ရင် transform တိုက်ရိုက်သုံးလို့ရအောင်
  StyleBuilder transitionRaw(String value) {
    addStyle('transition', value);
    return this;
  }
}

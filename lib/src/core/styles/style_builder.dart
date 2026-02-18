class StyleBuilder {
  final Map<String, String> _styles = {};

  // ၂။ Built-in မရှိတာတွေအတွက် User က Raw Map ထည့်ချင်ရင်
  StyleBuilder addRaw(Map<String, String> rawMap) {
    _styles.addAll(rawMap);
    return this;
  }

  void addStyle(String key, String value) {
    _styles[key] = value;
  }

  // နောက်ဆုံးမှာ Map အဖြစ် ပြန်ထုတ်ပေးမယ်
  Map<String, String> build() => _styles;
}

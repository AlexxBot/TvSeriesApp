import 'package:flutter/services.dart';

void vibrate() {
  Clipboard.setData(const ClipboardData(text: "vibrate"));
  HapticFeedback.heavyImpact();
}

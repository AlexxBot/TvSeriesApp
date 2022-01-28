import 'package:flutter/services.dart';

void vibrate() {
  Clipboard.setData(ClipboardData(text: "vibrate"));
  HapticFeedback.heavyImpact();
}

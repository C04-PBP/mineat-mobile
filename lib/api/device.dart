import 'package:flutter/foundation.dart';

String getDevice() {
  if (kIsWeb) {
    return 'http://localhost:8000';
  } else if (defaultTargetPlatform == TargetPlatform.macOS) {
    return 'http://127.0.0.1:8000';
  } else {
    return 'http://10.0.2.2:8000';
  }
}

final device = getDevice();

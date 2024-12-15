import 'package:flutter/foundation.dart';

String getDevice() {
  if (kIsWeb) {
    return 'http://localhost:8000';
  } else {
    return 'http://10.0.2.2:8000';
  } 
}

final device = getDevice();

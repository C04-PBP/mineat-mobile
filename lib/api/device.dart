import 'package:flutter/foundation.dart';

String getDevice() {
  if (kReleaseMode) {
    return 'https://ragnall-muhammad-mineat.pbp.cs.ui.ac.id/';
  } else if (kIsWeb) {
    return 'http://localhost:8000';
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return 'http://127.0.0.1:8000';
  } else {
    return 'http://10.0.2.2:8000';
  }
}


final device = 'https://ragnall-muhammad-mineat.pbp.cs.ui.ac.id/';

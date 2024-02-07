import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class KillswitchService {
  Future<bool> isKillswitchActive() async {
    var packageInfo = await PackageInfo.fromPlatform();
    var appName = packageInfo.appName;
    http.Response response;

    response = await http
        .get(
          Uri.parse('https://active-obelugnnza-uc.a.run.app/?appName=$appName'),
        )
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () => http.Response('false', 500),
        )
        .onError(
          (error, stackTrace) => http.Response('false', 500),
        );

    var decoded = jsonDecode(response.body);

    if (decoded == true) {
      return true;
    }
    return false;
  }
}

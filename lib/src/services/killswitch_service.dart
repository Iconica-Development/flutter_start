import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

/// A service class to check if a killswitch is active for the current app.
class KillswitchService {
  /// Checks if the killswitch is active for the current app.
  ///
  /// It makes a GET request to a specific URL with the app
  /// name as a query parameter.
  /// If the request fails or times out after 5 seconds,
  /// it defaults to returning 'false'.
  ///
  /// Returns a [Future] that completes with 'true' if the killswitch is active,
  /// and 'false' otherwise.
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

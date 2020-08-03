import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future<void> openUrl(String url) async {
    await launch(url);
  }
}

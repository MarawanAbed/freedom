

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecured {
  static final String twitterApiKey = dotenv.env['TWITTER_API_KEY']!;
  static final String twitterApiSecret = dotenv.env['TWITTER_API_SECRET']!;
  static final String gitHubClientId = dotenv.env['GITHUB_CLIENT_ID']!;
  static final String gitHubClientSecret = dotenv.env['GITHUB_CLIENT_SECRET']!;
  static final String appMessaging = dotenv.env['APP_MESSAGING']!;
}
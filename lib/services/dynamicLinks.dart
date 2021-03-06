import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
    
// The holy grail link https://nowu.page.link/?link=https://now-u.com/campaigns?id=1&apn=com.nowu.app

class DynamicLinkService {
  
  Future handleDynamicLinks() async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
  
    // 2. handle link that has been retrieved
    _handleDeepLink(data);
  
    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      // 3a. handle link that has been retrieved
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');
      //print(deepLink.path);
      //print(deepLink.path == "/campaigns");

      //if (deepLink.path == "/campaigns") {
      //  String campaignId = deepLink.queryParameters['id'];
      //  print("Campaign id is");
      //  print(campaignId);
      //  if (campaignId != null) {
      //    onLink(0, subIndex: int.parse(campaignId));
      //  }
      //}
    }
    else {
      print("Deep link was null");
    }
  }

  Future<Uri> getLink() async {
    PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    print("Data is");
    print(data);
    return data?.link;
  }
}

// Dynamic Links setup
Future <Uri> createDynamicLink(bool short) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: "https://nowu.page.link",
    link: Uri.parse("https://now-u.com"),
    androidParameters: AndroidParameters(
      packageName: "com.nowu.app",
      minimumVersion: 0,
    ),
    //TODO IOS needs fixing
    iosParameters: IosParameters(
      bundleId: "com.google.FirebaseCppDynamicLinksTestApp.dev",
      minimumVersion: '0',
    ),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: "now-u campaigns",
      description: "Each month now-u offers 3 campaings to tackle relevant issues. These campaings provide easy actions for the user to complete in order to empower them to drive socail change.",
      imageUrl: Uri.parse("https://images.unsplash.com/photo-1491382825904-a4c6dca98e8c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
    )
  );
  Uri url;
  if (short) {
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    print(shortLink.toString());
    url = shortLink.shortUrl;
  }
  else {
    url = await parameters.buildUrl();
  }
  return url;
}


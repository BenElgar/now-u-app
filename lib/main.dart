import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app/pages/Tabs.dart';

import 'package:app/assets/components/videoPlayerFlutterSimple.dart';
import 'package:app/assets/SplashScreen.dart';

import 'package:app/models/User.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:app/redux/reducers.dart';
import 'package:app/redux/actions.dart';
import 'package:app/redux/middleware.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

int _currentIndex = 1; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: darkBlue
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

// This is a really annoying color thing --> Makes our fav color into material colour
Map<int, Color> darkBlueMap ={50:Color.fromRGBO(36,35,52, .1),100:Color.fromRGBO(36,35,52, .2),200:Color.fromRGBO(36,35,52, .3),300:Color.fromRGBO(36,35,52, .4),400:Color.fromRGBO(36,35,52, .5),500:Color.fromRGBO(36,35,52, .6),600:Color.fromRGBO(36,35,52, .7),700:Color.fromRGBO(36,35,52, .8),800:Color.fromRGBO(36,35,52, .9),900:Color.fromRGBO(36,35,52, 1),};
MaterialColor darkBlue = MaterialColor(0xFF242334, darkBlueMap);

//List<Widget> _pages = <Widget>[Campaigns(campaigns), Home(), Profile(_user)];

// Dynamic Links setup
Future <Uri> createDynamicLink(bool short) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: "https://nowu.page.link",
    link: Uri.parse("https://now-u."),
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





class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final DevToolsStore<AppState> store = DevToolsStore<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
        middleware: [appStateMiddleware],
    );

    return StoreProvider<AppState>(
      store: store, 
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          fontFamily: 'Raleway',
          primaryTextTheme: TextTheme(
                // Page Header
                title: TextStyle(
                      fontSize: 46, 
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),  
                subtitle: TextStyle(
                      fontSize: 30, 
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),  
                
                headline : TextStyle(
                      fontSize: 31,
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),
                body1: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),
                body2: TextStyle(
                      fontSize: 22, 
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                button : TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                    ),
                display1: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'PeaceSans',
                    ),
                display2: TextStyle(
                      fontSize: 26,
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),
                display3: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(36, 35, 52, 1),
                      fontWeight: FontWeight.w300,
                    ),
                
              ),
          primarySwatch: darkBlue,
          buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.fromSwatch(
                  backgroundColor: Color.fromRGBO(36, 35, 52, 1),
                  ),
                buttonColor: Color.fromRGBO(36, 35, 52, 1), 
                textTheme: ButtonTextTheme.primary
              ),
          primaryColorDark: Color.fromRGBO(36, 35, 52, 1),
          buttonColor: Color.fromRGBO(36, 35, 52, 1),
          textSelectionColor: Colors.white, // Text used on top of 

        ),
        home: 
          StoreBuilder<AppState>(
            onInit: (store) { 
              //store.dispatch(GetCampaingsAction());
              store.dispatch(GetUserDataAction());
            },
            builder: (BuildContext context, Store<AppState> store) =>
              store.state.campaigns == null 
              || store.state.campaigns.getActiveCampaigns() == null
              || store.state.campaigns.activeLength() < 3
              ?
              Container(
                color: Colors.red,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              )
              :
              MyHomePage(store),
          )  
       )
    );
  }
}

class MyHomePage extends StatelessWidget {
  final DevToolsStore<AppState> store;

  MyHomePage(this.store);

  @override 
  Widget build(BuildContext context) {
    return
      StoreConnector<AppState, ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel viewModel) {
            print("Before splash screen user is");
            print(viewModel.user.getName());
            return TabsPage(viewModel);
          },
      );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onepay_sign_auth_dart/my_app_bar.dart';
import 'package:onepay_sign_auth_dart/ui/screen/login_screen.dart';
import 'package:onepay_sign_auth_dart/ui/screen/register_account_screen.dart';
import 'package:onepay_sign_auth_dart/ui/screen/splashscreen.dart';

import 'common/constants/app_constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.orange[200]),
      routes: <String,WidgetBuilder> {
        SPLASH_SCREEN: (BuildContext) => SplashScreen(),
        SIGN_IN: (BuildContext) => LoginPage(),
        SIGN_UP: (BuildContext) => RegisterAccountPage(),
      },
      initialRoute: SPLASH_SCREEN,
    );
  }
}

class MyCustomApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
       children: [
         MyAppBar(
           title: Text('First Screen'),
         ),
         MyHomePage()
       ],
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          "Hello world",
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }

}

class MyStatefullApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateApp();
  }

}

class StateApp extends State<MyStatefullApp> {

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: "Navigation Menu",
          onPressed: null,
        ),
        title: Text("First Screen"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'search',
            onPressed: null,
          )
        ],
      ),
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You have pushed the button this many times:'"
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'add',
        child: Icon(Icons.add),
        onPressed: _incrementCounter,
      ),
    );
  }

}
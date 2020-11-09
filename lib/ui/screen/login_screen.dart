
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onepay_sign_auth_dart/common/constants/app_constant.dart';
import 'package:onepay_sign_auth_dart/ui/widgets/custom_shape.dart';
import 'package:onepay_sign_auth_dart/ui/widgets/form_textfield.dart';
import 'package:onepay_sign_auth_dart/ui/widgets/responsive_ui.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }

}

class LoginScreen extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();

}

class LoginState extends State<LoginScreen> {

  bool _large;
  bool _medium;
  double _width;
  double _height;
  double _pixelRatio;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Material(
        child: Container(
          width: _width,
          height: _height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                clipShape(),
                welcomeTextRow(),
                signInTextRow(),
                formInputRow(),
                forgotPasswordRow(),
                buttonSignIn(),
                signInRow()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: [
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipLogin(),
            child: Container(
              height: _large? _height/4 : (_medium? _height/3.75 : _height/3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent]
                )
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipLogin2(),
            child: Container(
              height: _large? _height/4 : (_medium? _height/3.75 : _height/3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange[200], Colors.pinkAccent
                  ]
                )
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: _large ? _height/30 : (_medium ? _height/25 : _height/20)),
          child: Image.asset(
            'assets/images/login.png',
            width: _width / 3.5,
            height: _height / 3.5,
          ),
        )
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container (
      margin:EdgeInsets.only(top: _height/100, left: _width/20),
      child: Row(
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large ? 60 : (_medium ? 50 : 40)
            ),
          )
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width/15),
      child: Row(
        children: [
          Text(
            'Sign in to your account',
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large ? 20 : (_medium? 17.5 : 15)
            ),
          )
        ],
      ),
    );
  }

  Widget formInputRow() {
    return Container (
      margin: EdgeInsets.only(left: _width/12,right: _width/12,top: _height/15),
      child: Form(
        key: _key,
        child: Column(
          children: [
            emailInputRow(),
            SizedBox(height: _height/ 40.0),
            passwordInputRow()
          ],
        ),
      )
    );
  }

  Widget emailInputRow() {
    return CustomTextFieldLogin (
      hint: 'Email ID',
      textEditingController: emailController,
      icon: Icons.email,
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget passwordInputRow() {
    return CustomTextFieldLogin(
      hint: 'Password',
      icon: Icons.lock,
      obscureText: true,
      keyboardType: TextInputType.text,
      textEditingController: passwordController,
    );
  }

  Widget forgotPasswordRow() {
    return Container(
      margin: EdgeInsets.only(top: _height/40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Forgot your password?',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: _large ? 14 : (_medium ? 12 : 10)
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              print("Navigation recovery password");
            },
            child: Text(
              'Recover',
              style: TextStyle(
                  color: Colors.orange[200],
                  fontSize: _large ? 14 : (_medium ? 12 : 10),
                  fontWeight: FontWeight.w600
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buttonSignIn() {
    return Container(
      margin: EdgeInsets.only(top: _height/15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              print('Hello world');
            },
            padding: EdgeInsets.all(0.0),
            child: Container(
              alignment: Alignment.center,
              width: _large? _width/4 : (_medium? _width/3.75: _width/3.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  gradient: LinearGradient(
                    colors: [Colors.orange[200], Colors.pinkAccent]
                  )
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: _large ? 14 : (_medium ? 12 : 10)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget signInRow() {
    return Container(
      margin: EdgeInsets.only(top: _height/100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: _large ? 14 : (_medium ? 12 : 10),
            ),
          ),
          SizedBox(width: 5.0,),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(SIGN_UP);
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                  fontSize: _large ? 14 : (_medium ? 12 : 10),
                  color: Colors.orange[200] ,
                  fontWeight: FontWeight.w600
              ),
            ),
          )
        ],
      ),
    );
  }
}
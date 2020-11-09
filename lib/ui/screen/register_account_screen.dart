import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onepay_sign_auth_dart/ui/widgets/custom_shape.dart';
import 'package:onepay_sign_auth_dart/ui/widgets/form_textfield.dart';
import 'package:onepay_sign_auth_dart/ui/widgets/responsive_ui.dart';

class RegisterAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterAccountScreen(),
    );
  }
}

class RegisterAccountScreen extends StatefulWidget {
  @override
  RegisterAccountState createState() => new RegisterAccountState();
}

class RegisterAccountState extends State<RegisterAccountScreen> {

  double _width;
  double _height;
  double _ratioPixel;
  bool _large;
  bool _medium;
  bool _checkBoxValue = false;

  GlobalKey<FormState> _key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _ratioPixel = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _ratioPixel);
    _medium = ResponsiveWidget.isScreenMedium(_width, _ratioPixel);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus) {
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
                formSignIn(),
                termFormInput(),
                SizedBox(height: _height/35,),
                buttonSignUp(),
                signUpWithSNS()
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
              height: _large ? _height/5 : (_medium ? _height/4.75 : _height/4.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200],Colors.pinkAccent]
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
              height: _large ? _height/5: (_medium ? _height/4.75 : _height/4.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200],Colors.pinkAccent]
                )
              ),
            ),
          ),
        ),
        Container(
          height: _height/6.25,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: _large ? _height/20 : (_medium ? _height/15 : _height/10)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20.0,
                color: Colors.black38,
                spreadRadius: 0.0,
                offset: Offset(1.0,10.0)
              )
            ]
          ),
          child: GestureDetector(
            onTap: () {
              print('select image');
            },
            child: Icon(Icons.add_a_photo,color: Colors.orange[200],size: _large ? 40 : (_medium ? 35 : 30),),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 5.0),
          child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: () {
            Navigator.of(context).pop();
          }),
        ) ,
      ],
    );
  }

  Widget formSignIn() {
    return Container(
      margin: EdgeInsets.only(top: _large ? _height/30 : (_medium ? _height/25 : _height/20), left: _width/15, right:  _width/15),
      child: Form(
        key: _key,
        child: Column(
          children: [
            firstNameInput(),
            SizedBox(height: _height/50,),
            lastNameInput(),
            SizedBox(height: _height/50,),
            emailInput(),
            SizedBox(height: _height/50,),
            mobieInput(),
            SizedBox(height: _height/50,),
            passwordInput(),
          ],
        ),
      ),
    );
  }
  
  Widget firstNameInput() {
    return CustomTextFieldLogin(
      icon: Icons.person,
      hint: 'First Name',
      keyboardType: TextInputType.text,
      obscureText: false,
    );
  }

  Widget lastNameInput() {
    return CustomTextFieldLogin(
      icon: Icons.person,
      hint: 'Last Name',
      keyboardType: TextInputType.text,
      obscureText: false,
    );
  }

  Widget emailInput() {
    return CustomTextFieldLogin(
      icon: Icons.email,
      hint: 'Email ID',
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
    );
  }

  Widget mobieInput() {
    return CustomTextFieldLogin(
      icon: Icons.phone,
      hint: 'Mobile number',
      keyboardType: TextInputType.phone,
      obscureText: false,
    );
  }

  Widget passwordInput() {
    return CustomTextFieldLogin(
      icon: Icons.phone,
      hint: 'Password',
      keyboardType: TextInputType.text,
      obscureText: true,
    );
  }

  Widget termFormInput() {
    return Container(
      margin: EdgeInsets.only(top: _large ? _height/100 : (_medium ? _height/95 : _height/90)),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: _checkBoxValue,
            onChanged: (bool newValue) {
              setState(() {
                _checkBoxValue = newValue;
              });

            },
            activeColor: Colors.orange[200],
          ),
          Text(
            'I accept all terms and conditions',
            style: TextStyle(
              fontSize: _large ? 12 : (_medium ? 10 : 8),
              color: Colors.black
            ),
          )
        ],
      ),
    );
  }

  Widget buttonSignUp() {
    return RaisedButton(
      onPressed: () {
        print('sign up');
      },
      elevation: 0,
      padding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        width: _large ? _width/4 : (_medium ? _width/3.75 : _width/3.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange[200],Colors.pinkAccent]
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: _large ? 14 : (_medium ? 12 : 10),
            fontWeight: FontWeight.w600
          ),
        ),
        padding: EdgeInsets.all(12.0),
      ),
    );
  }

  Widget signUpWithSNS() {
    return Container(
      margin: EdgeInsets.only(top: _large ? _height/40 : (_medium ? _height/35 : _height/30), bottom: _large ? _height/80 : (_medium ? _height/75 : _height/70)),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Or create using social media',
              style: TextStyle(
                fontSize: _large ? 14 : (_medium ? 12 : 10),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  print('Sign up with Google');
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/googlelogo.png'),
                  radius: 15,
                ),
              ),
              SizedBox(width: 20,),
              GestureDetector(
                onTap: () {
                  print('Sign up with facebook');
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/fblogo.jpg'),
                  radius: 15,
                ),
              ),
              SizedBox(width: 20,),
              GestureDetector(
                onTap: () {
                  print('Sign up with twitter');
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/twitterlogo.jpg'),
                  radius: 15,
                ),
              ),
              SizedBox(width: 20,)
            ],
          )
        ],
      ),
    );
  }
}
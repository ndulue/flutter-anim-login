import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Login(),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int _pageState = 0;

  var _background = Colors.white;
  var _headingColor = Color(0xFFB402B4A);

  double _loginOffset = 0;
  double _loginWidth = 0;
  double _heading = 100;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _loginHeight = 0;

  double _registerHeight = 0;
  double windowWidth = 0;
  double windowHeight = 0;
  double _loginOpacity = 1;

  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible){
        setState(() {
          _keyboardVisible = visible;
        });
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;

    switch(_pageState){
      case 0:
        _background = Colors.white;
        _headingColor = Color(0xFFB402B4A);
        _heading = 100;
        _loginWidth = windowWidth;

        _loginOffset = windowHeight;
        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _background = Color(0xFFB34C59);
        _headingColor = Colors.white;
        _heading = 90;
        _loginWidth = windowWidth;
        _loginOpacity = 1;
        _loginOffset = _keyboardVisible ? 40 : 270;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _background = Color(0xFFB34C59);
        _headingColor = Colors.white;

        _heading = 80;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;

        _loginOffset = _keyboardVisible ? 30 : 240;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 240;

        _loginXOffset = 20;
        _registerYOffset = _keyboardVisible ? 55 : 270;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        break;
    }

    return Stack(
      children: <Widget>[
        AnimatedContainer(
           curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(
            milliseconds: 1500
          ),
          color: _background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  setState(() {
                    _pageState = 0;
                  });
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      AnimatedContainer(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(
                          milliseconds: 1000
                        ),
                        margin: EdgeInsets.only(top: _heading),
                        child: Text(
                            'Welcome',
                            style: TextStyle(
                              color: _headingColor,
                              fontSize: 28
                            ),
                        )
                      ),
                      Container(
                        margin: EdgeInsets.all(
                          20
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32
                        ),
                        child: Text(
                          'Hellpp and welcome to this awesome login animation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _headingColor,
                              fontSize: 16
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                  child: Image.asset(
                    ''
                  )
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      if(_pageState != 0){
                        _pageState = 0;
                      } else {
                        _pageState = 1;
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                       color: Color(0xFFB402B4A),
                       borderRadius: BorderRadius.circular(50)
                    ),
                    child: Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(20),
          width: _loginWidth,
          height: _loginHeight,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(
            milliseconds: 1000
          ),
          transform: Matrix4.translationValues(_loginXOffset, _loginOffset, 1),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_loginOpacity),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Login To Continue",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                  InputWithIcon(
                      icon: Icons.mail,
                      hint: "Email Address"
                  ),
                  SizedBox(height: 20),
                  InputWithIcon(
                      icon: Icons.vpn_key,
                      hint: "Password"
                  )

                ],
              ),
              Column(
                children: <Widget>[
                  PrimaryBtn(
                    btnText: "Login",
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _pageState = 2;
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Create new Account",
                    ),
                  )

                ],
              ),
            ],
          ),
        ),
        AnimatedContainer(
          height: _registerHeight,
          padding: EdgeInsets.all(32),
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(
              milliseconds: 1000
          ),
          transform: Matrix4.translationValues(0, _registerYOffset, 1),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Create a New Account',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                  InputWithIcon(
                      icon: Icons.email,
                      hint: "Email Address"
                  ),
                  SizedBox(height: 20),
                  //InputWithIcon(
                  //    icon: Icons.person,
                  //    hint: "Full Name"
                  //),
                  //SizedBox(height: 20),
                  InputWithIcon(
                      icon: Icons.vpn_key,
                      hint: "Password"
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      PrimaryBtn(
                        btnText: "Login",
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _pageState = 1;
                          });
                        },
                        child: OutlineBtn(
                          btnText: "Back to login",
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}


class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;

  InputWithIcon({this.icon, this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFBC7C7C7),
          width: 2
        ),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            child: Icon(
              widget.icon,
              size: 20,
              color: Color(0xFFBB98989),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                border: InputBorder.none,
                hintText: widget.hint
              ),
            )
          )
        ],
      ),
    );
  }
}



class PrimaryBtn extends StatefulWidget {

  final String btnText;
  PrimaryBtn({
    this.btnText
  });

  @override
  _PrimaryBtnState createState() => _PrimaryBtnState();
}

class _PrimaryBtnState extends State<PrimaryBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFB40284A),
        borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15
          ),
        ),
      ),
    );
  }
}


class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({
    this.btnText
  });

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFB40284A),
            width: 2
          ),
          borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Color(0xFFB40284A),
              fontSize: 15
          ),
        ),
      ),
    );
  }
}

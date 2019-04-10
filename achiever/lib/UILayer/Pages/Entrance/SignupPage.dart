import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/Login/Signup.dart';
import 'package:achiever/BLLayer/Models/Login/Login.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';
import 'package:achiever/BLLayer/Services/AuthService.dart';
import 'package:quiver/strings.dart';

class SignupPage extends StatefulWidget {
  final _authService = new AuthService();
  SignupPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final formKey = new GlobalKey<FormState>();
  final buttonKey = new GlobalKey();
  final emailKey = new GlobalKey();

  String nickname, password, password2, email;

  bool loginInProgress = false;
  
  bool loginTaken = true;
  String _lastTakenLogin = '';

  bool _autoValidate = false;

  final _emailFocusNode = new FocusNode();
  final _password2FocusNode = new FocusNode();

  Future<Null> _ensureEmailVisible() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (_password2FocusNode.hasFocus && emailKey.currentContext != null)
      Scrollable.ensureVisible(buttonKey.currentContext, duration: const Duration(milliseconds: 300));
  }

  Future<Null> _ensureButtonVisible() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (_emailFocusNode.hasFocus && buttonKey.currentContext != null)
      Scrollable.ensureVisible(buttonKey.currentContext, duration: const Duration(milliseconds: 300));
  }

  @override
  void initState() {
      _emailFocusNode.addListener(_ensureButtonVisible);
      _password2FocusNode.addListener(_ensureEmailVisible);
      super.initState();
    }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_ensureButtonVisible);
    _emailFocusNode.removeListener(_ensureEmailVisible);
    super.dispose();
  }

  void validate() async {
    final form = formKey.currentState;
    form.save();

    if (form.validate()){
      
      final signupModel = Signup(nickname, password, email, '');

      setState(() {
              loginInProgress = true;
            });

      try {
        await widget._authService.signup(signupModel);
        Navigator.of(context).pushNamedAndRemoveUntil('/', (x) => false);
      }
      catch (e) {
        loginTaken = true;
        _lastTakenLogin = nickname;
        setState(() {
                  _autoValidate = true;
                  loginInProgress = false;
                });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final signupButton = new Container(
			margin: EdgeInsets.only(top: 52.0),
      child: AchieverButton(56, new Text('ЗАРЕГИСТРИРОВАТЬСЯ', style: TextStyle(
					color: Colors.white,
					fontSize: 18.0)), validate),
		);

    final credsForm = new Form(
			key: formKey,
			child: new Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
				//decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 1.0)),
				child: new Column(
					children: <Widget>[
						new Container(
							margin: EdgeInsets.only(top: 50.0),
							child:	new TextFormField(
								decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 12.0),
									labelText: 'Никнейм',
								),
								onSaved: (val) => nickname = val,
                autovalidate: _autoValidate,
                validator: (val) {
                  if (isBlank(nickname)) {
                    return 'Никнейм пустой';
                  }
                  if (loginTaken && val == _lastTakenLogin) {
                    return 'Никнейм занят';
                  }
                },
							)
						),
            new Container(
              margin: EdgeInsets.only(top: 32.0),
              child: new TextFormField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 12.0),
									labelText: 'Пароль',
                ),
                obscureText: true,
                onSaved: (val) => password = val,
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 32.0),
              child: new TextFormField(
                focusNode: _password2FocusNode,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 12.0),
									labelText: 'Повторите пароль',
                ),
                obscureText: true,
                validator: (val) {
                  if (password2 != password)
                    return 'Пароли не совпадают!';
                },
                onSaved: (val) => password2 = val,
              ),
            ),
            new Container(
              key: emailKey,
              margin: EdgeInsets.only(top: 32.0),
              child: new TextFormField(
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 12.0),
                  labelText: 'E-mail',
                ),
                //obscureText: true,
                onSaved: (val) => email = val,
              ),
            ),
            new Container(
              key: buttonKey,
              child: !loginInProgress ? signupButton : 
                new Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()
                  )
                )
            )
          ]
        )
      )
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            credsForm,
            //new Expanded(child: new Container(),),
            new Container(
              width: 310.0,
              margin: EdgeInsets.only(top: 22.0),
              //decoration: new BoxDecoration(border: Border.all(color: Colors.black)),
              child: new Text('Регистрируясь в Achiever вы соглашаетесь с правилами и условиями сервиса',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w100,
                  color: Color.fromARGB(255, 102, 102, 102)
                ),
              )
            )
          ],
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/Login/Signup.dart';
import 'package:achiever/BLLayer/Services/AuthService.dart';
import 'package:quiver/strings.dart';
import 'package:achiever/UILayer/UIKit/AchieverCheckbox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:achiever/UILayer/UIKit/NoOpacityMaterialPageRoute.dart';

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
  bool _policyAcepted = true;

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
    _password2FocusNode.removeListener(_ensureEmailVisible);
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

    final signupButton = _buildButton(context);

    final credsForm = new Form(
			key: formKey,
			child: new Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
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
          ]
        )
      )
    );

    final buttonContainer = Container(
      key: buttonKey,
      margin: EdgeInsets.only(top: 24, left: 16, right: 16),
      child: !loginInProgress ? signupButton : 
        new Container(
          child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator()
          )
        )
    );

    return new Scaffold(
      appBar: _buildAppBar(context),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            credsForm,
            _buildPolicyCheckbox(context),
            buttonContainer
          ],
        )
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final button = Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          //color: Color.fromARGB(255, 242, 242, 242)
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 202, 255, 1),
              Color.fromRGBO(0, 142, 255, 1)
            ]
          )
        ),
        height: 56,
        width: MediaQuery.of(context).size.width - 16 * 2,
        child: Center(
          widthFactor: 1,
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text('Зарегистрироваться', style: TextStyle(
              fontSize: 13,
              letterSpacing: 0.22,
              fontWeight: FontWeight.w500,
              color: Colors.white
            )),
          ),
        ),
      ),
    );

    if (_policyAcepted) {
      return GestureDetector(
        child: button,
        onTap: validate,
      );
    }
    
    return Opacity(
      opacity: 0.2,
      child: button,
    );
  }

  Widget _buildPolicyCheckbox(BuildContext context) {
    final checkbox = AchieverCheckbox(
      value: _policyAcepted,
      onChanged: (val) {
        setState((){
          _policyAcepted = val;
        }); 
      },
    );

    final text = RichText(
      text: TextSpan(
        children: [
          TextSpan(text: 'Я принимаю ', style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            letterSpacing: 0,
            color: Color.fromRGBO(102, 102, 102, 1)
          )),
          TextSpan(text: 'политику конфиденциальности', style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            letterSpacing: 0,
            color: Color.fromRGBO(64, 123, 224, 1)
          ), recognizer: TapGestureRecognizer()..onTap = () {
            Navigator.of(context).push(NoOpacityMaterialPageRoute(
              builder: (_) => _buildWebView(context),
              settings: RouteSettings(name: 'policy')
            ));
          })
        ]
      )
    );

    return Container(
      margin: EdgeInsets.only(top: 56, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          checkbox,
          Container(
            margin: EdgeInsets.only(left: 12),
            child: text,
          )
        ],
      ),
    );
  }

  Widget _buildWebView(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      url: 'https://www.notion.so/furycateur/deb541ab271a4e70bcabe86dc4140bc2',
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 1,
      title: Text('Регистрация', style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 21,
        letterSpacing: 0.34,
        color: Color.fromRGBO(51, 51, 51, 1)
      )),
    );
  }
}
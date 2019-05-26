import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Redux/Login/LoginActions.dart';
import 'package:achiever/BLLayer/Redux/Models/LoadingStatus.dart';
import 'LoginViewModel.dart';

import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';

class LoginPage extends StatefulWidget {

	@override
	State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('Вход', style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 21,
          letterSpacing: 0.34,
          color: Color.fromRGBO(51, 51, 51, 1)
        )),
      ),
      body: StoreConnector<AppState, LoginViewModel>(
        onInit: (store) {
          store.dispatch(ClearErrorsAction());
        },
        converter: (store) => LoginViewModel.fromStore(store),
        builder: (_, viewModel) => _buildLayout(viewModel),
      ),
    );
  }

  Widget _buildLayout(LoginViewModel viewModel) {

    final loginButton = Container(
			margin: EdgeInsets.only(top: 32.0),
      child: AchieverButton.createDefault(new Text('ВОЙТИ', style: TextStyle(
					color: Colors.white,
					fontSize: 18.0)), 
          viewModel.login)
		);

		final credsForm = Container(
      child: Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child:	new TextField(
              decoration: InputDecoration(
                labelStyle: new TextStyle(
                  fontSize: 12.0
                ),
                labelText: 'Никнейм',
              ),
              onChanged: (nickname) {
                viewModel.updateNickname(nickname);
              },
            )
          ),
          new TextField(
            decoration: InputDecoration(
              labelStyle: new TextStyle(
                fontSize: 12.0
              ),
              labelText: 'Пароль',
            ),
            obscureText: true,
            onChanged: (password) {
              viewModel.updatePassword(password);
            },
          ),
          viewModel.loadingStatus == LoadingStatus.loading ? Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator()))
          : loginButton
        ]
      )
    );

    return Container(
      margin: const EdgeInsets.only(left: 20.0, top: 43.0, right: 15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          credsForm
        ]
      )
    );
  }
}

/*

class _LoginPageState extends State<LoginPage> {
	final formKey = new GlobalKey<FormState>();
	BuildContext _ctx;
	String login, password;
	bool loginInProgress = false;

	Future submit() async {
		final form = formKey.currentState;
		form.save();

		setState(() {
				  loginInProgress = true;
				});

		try	{
			await widget._authService.authenticate(Login(login, password));
			
      Navigator.of(_ctx).pushReplacementNamed('/routes');
		}
		catch (exception) {
			setState(() {
				loginInProgress = false;
				});
		}
	}

	@override
	Widget build(BuildContext context) {
		_ctx = context;
		
		final loginButton = new Container(
			margin: EdgeInsets.only(top: 32.0),
      child: AchieverButton.createDefault(new Text('ВОЙТИ', style: TextStyle(
					color: Colors.white,
					fontSize: 18.0)), submit)
		);

		final credsForm = new Form(
			key: formKey,
			child: new Container(
				//decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 1.0)),
				child: new Column(
					children: <Widget>[
						new Container(
              //decoration: BoxDecoration(border: Border.all(width: 1.0)),
							padding: EdgeInsets.only(bottom: 10.0),
							child:	new TextFormField(
								decoration: InputDecoration(
                  labelStyle: new TextStyle(
                    fontSize: 12.0
                  ),
                  labelText: 'Никнейм'
								),
								onSaved: (val) => login = val,
							)
						),
						new TextFormField(
							decoration: InputDecoration(
                labelStyle: new TextStyle(
                  fontSize: 12.0
                ),
								labelText: 'Пароль',
							),
							obscureText: true,
							onSaved: (val) => password = val,
						),
						!loginInProgress ? loginButton : Container(
								margin: EdgeInsets.only(top: 20.0),
								child: Align(
									alignment: Alignment.center,
									child: CircularProgressIndicator()))
					]
				)
			)
		);

		return new Scaffold(
			body: new 
		);
	}
}*/
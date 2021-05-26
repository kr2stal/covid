import 'package:covid19_app/api/login_model.dart';
import 'package:covid19_app/progressHUD.dart';
import 'package:covid19_app/screens/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/all.dart';

class signupScreen extends StatefulWidget {
  @override
  _signupScreen createState() => _signupScreen();
}

class _signupScreen extends State<signupScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hiddenPassword = true;
  LoginRequestModel requestModel;
  bool isApiCallProcess = false;

  @override
  void initState() {
    requestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ]),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Covid SignUp",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      textSection(),
                    ],
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }

  Future<void> postUser() async {
    http.Response response;
    var data1;
    User user;
    try {
      response =
          await http.post(Uri.parse("https://82b3497a8713.ngrok.io/covid/user"),
              headers: {'Content-type': 'application/json'},
              body: jsonEncode({
                "email": emailController.text,
                'password': passwordController.text,
                'local': '서울'
              }));

      int statusCode = response.statusCode;

      if (statusCode == 200) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("SignUp success"),
        ));
        data1 = json.decode(response.body);
        localData = data1["local"];
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StatsScreen()));
        return;
      }
    } catch (e) {
      print(e);
    }

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("SignUp error"),
    ));

    return;
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          txtEmail("Email", Icons.email),
          SizedBox(height: 50.0),
          txtPassword("Password", Icons.lock),
          SizedBox(height: 50.0),
          txtLocal("Local", Icons.map),
        ],
      ),
    );
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController localController = new TextEditingController();

  TextFormField txtLocal(String title, IconData icon) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (input) => requestModel.email = input,
      validator: (input) =>
          !input.contains("@") ? "Email id should be valid" : null,
      decoration: InputDecoration(
        hintText: "Email Address",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
        prefixIcon: Icon(Icons.email, color: Theme.of(context).accentColor),
      ),
    );
  }

  TextFormField txtEmail(String title, IconData icon) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (input) => requestModel.email = input,
      validator: (input) =>
          !input.contains("@") ? "Email id should be valid" : null,
      decoration: InputDecoration(
        hintText: "Email Address",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
        prefixIcon: Icon(Icons.email, color: Theme.of(context).accentColor),
      ),
    );
  }

  TextFormField txtPassword(String title, IconData icon) {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (input) => requestModel.email = input,
      validator: (input) => !input.contains("@")
          ? "Password should be more than 3 characters"
          : null,
      obscureText: hiddenPassword,
      decoration: InputDecoration(
        hintText: "Password",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
        prefixIcon: Icon(Icons.lock, color: Theme.of(context).accentColor),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hiddenPassword = !hiddenPassword;
            });
          },
          color: Theme.of(context).accentColor.withOpacity(0.4),
          icon: Icon(
            hiddenPassword ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );
  }
}

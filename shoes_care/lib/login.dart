import 'package:flutter/material.dart';
import 'package:shoes_care/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:shoes_care/app_theme.dart';
import 'package:rules/rules.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogPageState();
  }
}

class LogPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Rule get emailControllerRule {
    return Rule(
      emailController.text,
      name: 'E-mail',
      isEmail: true,
      isRequired: true,
    );
  }
  Rule get passwordControllerRule {
    return Rule(
      passwordController.text,
      name: 'Password',
      minLength: 6,
      isRequired: true,
    );
  }
  bool get isContinueBtnEnabled {
    final groupRule = GroupRule(
      [emailControllerRule, passwordControllerRule],
      name: 'Sign in button',
      requiredAll: true,
    );

    return !groupRule.hasError;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 600,
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black26,
                      offset: new Offset(0.0, 2.0),
                      blurRadius: 25.0,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32))),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppTheme.maroon,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Welcome to Shoes n Care.',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Let\'s get started',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 32, bottom: 8),
                    child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            emailController.text = value;
                          });
                        },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'E-Mail Address',
                        errorText: emailControllerRule?.error ?? null,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: TextField(
                      onChanged: (String value) {
                        setState(() {
                          passwordController.text = value;
                        });
                      },
                      obscureText: true,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: passwordControllerRule?.error ?? null,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: isContinueBtnEnabled ? AppTheme.maroon : Colors.grey, shape: BoxShape.circle),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () async {
                            if (isContinueBtnEnabled) {
                              print(emailController.text +
                                  passwordController.text);
                              var isSuccess = await context.read<AuthenticationService>().signIn(
                                  email: emailController.text,
                                  password: passwordController.text);
                              if(isSuccess != "Signed In"){
                                var snackBar = SnackBar(
                                    content: Text(
                                        isSuccess));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else{
                                Navigator.of(context).pushReplacementNamed('/home');
                              }
                            }
                          },
                          icon: Icon(Icons.arrow_forward),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}

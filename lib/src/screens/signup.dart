import '../../config/ui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/app_config.dart' as config;
class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _showPassword = false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.Colors().mainColor(1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  margin: EdgeInsets.symmetric(vertical: 65, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 10), blurRadius: 20)
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Text('Sign Up', style: Theme.of(context).textTheme.displayMedium),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: Theme.of(context).textTheme.bodyLarge!.merge(
                                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.text,
                        obscureText: !_showPassword,
                        decoration: new InputDecoration(
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.bodyLarge!.merge(
                                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.padlock_1,
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                            icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.text,
                        obscureText: !_showPassword,
                        decoration: new InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: Theme.of(context).textTheme.bodyLarge!.merge(
                                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.padlock_1,
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            color: Theme.of(context).focusColor.withOpacity(0.4),
                            icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      TextButton(
                        // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/SignIn');
                        },
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.titleMedium!.merge(
                                TextStyle(color: Theme.of(context).primaryColor),
                              ),
                        ),
                        // color: Theme.of(context).accentColor,
                        // shape: StadiumBorder(),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Or using social media',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 20),

                    ],
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/SignIn');
              },
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: [
                    TextSpan(text: 'Already have an account ?'),
                    TextSpan(text: ' Sign In', style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

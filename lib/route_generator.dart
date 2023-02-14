import 'package:flutter/material.dart';
import 'package:ingorala/src/screens/profilepage.dart';
import 'src/models/route_argument.dart';

import 'src/screens/otp.dart';
import 'src/screens/signin.dart';
import 'src/screens/signup.dart';
import 'src/screens/splashScreen.dart';
import 'src/screens/tabs.dart';
import 'src/screens/utilitie.dart';
import 'src/screens/unit.dart';
import 'src/screens/mapnit.dart';
import 'src/screens/maps.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignInWidget());
        case '/otp':
        return MaterialPageRoute(builder: (_) => otp(map: args as Map));
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());  
      case '/Tabs':
        return MaterialPageRoute(builder: (_) => TabsWidget());
      case '/Utilities':
        return MaterialPageRoute(builder: (_) => UtilitieWidget(routeArgument: args as RouteArgument,));
      // case '/Languages':
      //   return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Unit':
        return MaterialPageRoute(builder: (_) => Unit());
      case '/Maps':
        return MaterialPageRoute(builder: (_) => DaftarUnit());
       case '/Map':
        return MaterialPageRoute(builder: (_) => Location());
      // case '/Legend':
      //   return MaterialPageRoute(builder: (_) => Home());
      case '/Profile':
        return MaterialPageRoute(builder: (_) => ProfileWidget());
      // case '/Categories':
      //   return MaterialPageRoute(builder: (_) => CategoriesWidget());
      // case '/Categorie':
      //   return MaterialPageRoute(builder: (_) => CategorieWidget(routeArgument: args as  RouteArgument,));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

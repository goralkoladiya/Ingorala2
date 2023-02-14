import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import '../models/utilities.dart';

// Not Used it an optional grid
class FavoriteGridItemWidget extends StatelessWidget {
  Utilitie? utilitie;
  String? heroTag;

  FavoriteGridItemWidget({this.heroTag, this.utilitie}) ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Utilitie',
            arguments: new RouteArgument(argumentsList: [this.utilitie, this.heroTag], id: this.utilitie!.id));
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(50),
            alignment: AlignmentDirectional.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Hero(
                    tag: heroTag! + utilitie!.id,
                    child: Container(
                      
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(this.utilitie!.image), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  utilitie!.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  utilitie!.available.toString(),
                  style: Theme.of(context).textTheme.displayLarge,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 40,
            child: TextButton(
              // padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(
                Icons.favorite,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              // color: Theme.of(context).accentColor.withOpacity(0.9),
              // shape: StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

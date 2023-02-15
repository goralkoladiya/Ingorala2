import 'dart:io';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingorala/src/screens/singlelist.dart';

import '../MyProvider.dart';

import 'dart:math' as math;
class alphabet extends StatefulWidget {
  const alphabet({Key? key}) : super(key: key);

  @override
  State<alphabet> createState() => _alphabetState();
}

class _alphabetState extends State<alphabet> {
  MyProvider m=Get.put(MyProvider());
  List<String> alpha=['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 7),
            child:GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              shrinkWrap: true,
              primary: false,
              itemCount:alpha.length,
              itemBuilder: (context, index) {
                return OpenContainer(
                  closedBuilder: (context, action) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Theme.of(context).hintColor
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                                ]),
                            child: Center(
                              child:Text(
                                "${alpha[index].toUpperCase()}",
                                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    print(alpha[index]);
                    m.searchcontactList.value=m.tempcontactList.where((element) =>
                        element.e_name.toString().toLowerCase().startsWith(alpha[index].toLowerCase())).toList();
                    m.searchtempcontactList.value=m.searchcontactList.value;
                    print(m.searchcontactList.value);
                   return StatefulBuilder(builder: (context, setState) {
                     return SingleList();
                   },);
                  },
                  transitionDuration: Duration(seconds: 1),
                );
              },
            ),
          ),
        ),
      ],
    );

  }
}

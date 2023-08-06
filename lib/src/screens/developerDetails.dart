import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingorala/src/MyProvider.dart';
import 'package:readmore/readmore.dart';

class developerDetails extends StatefulWidget {
  const developerDetails({Key? key}) : super(key: key);

  @override
  State<developerDetails> createState() => _developerDetailsState();
}

class _developerDetailsState extends State<developerDetails> {
  MyProvider m=Get.put(MyProvider());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        Image.network("https://ingoralajagani.cdmi.in/creative.png",color:Color(0xff2D6064) ,),
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipPath(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 150,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Text("Creative Design & Multimedia Institute \n${m.developerarealist[index]}",style: Theme.of(context).textTheme.bodyMedium,)
                          ),
                          ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: ReadMoreText(
                                "${m.developeraddlist[index]}\n\n+91 9427280713", style: Theme.of(context).textTheme.caption!.merge(
                                      TextStyle(fontWeight:  FontWeight.w600))
                              )
                          ),
                        ],
                      ),
                    ),
                    clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                  ),
                )

            );
          },
            itemCount: m.developerarealist.length,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../MyProvider.dart';

class AdvBannerScreen extends StatefulWidget {
  const AdvBannerScreen({Key? key}) : super(key: key);

  @override
  State<AdvBannerScreen> createState() => _AdvBannerScreenState();
}

class _AdvBannerScreenState extends State<AdvBannerScreen> {
  MyProvider m=Get.put(MyProvider());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ClipPath(
            child: Container(
              child: Column(
                children: <Widget>[
                  Image.network(
                    "${m.serverUrl.value}/${m.advBannerListResult!.result![index].image}",
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: ReadMoreText(
                      m.advBannerListResult!.result![index].note!,
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Theme.of(context).hintColor.withOpacity(1)),
                      lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Theme.of(context).hintColor.withOpacity(1)),
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
      itemCount: m.advBannerListResult!.result!.length,
    );
  }
}
/*
Column(
            children: <Widget>[
              Image.network(
                "${m.serverUrl}/${m.advBannerListResult!.result![index].image}",
                height: 170,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "${m.advBannerListResult!.result![index].note}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          )
 */
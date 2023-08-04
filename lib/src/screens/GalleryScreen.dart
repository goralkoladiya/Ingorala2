import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingorala/src/screens/GalleryImageView.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../MyProvider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  MyProvider m = Get.put(MyProvider());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: EdgeInsets.symmetric(vertical: 15),
      shrinkWrap: true,
      primary: false,
      itemCount: m.galleryList!.result!.length,
      itemBuilder: (context, index) {
        return OpenContainer(
          closedBuilder: (context, action) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Theme.of(context).hintColor),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.15),
                              offset: Offset(0, 3),
                              blurRadius: 10)
                        ]),
                    child: Image.network(
                      "${m.serverUrl.value}/" +
                          m.galleryList!.result![index].image!,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                            "${m.serverUrl.value}/profile/profile.png");
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
          openBuilder: (context, action) {
            return GalleryImageView(index);
          },
          transitionDuration: Duration(seconds: 1),
        );
      },
    );
  }
}
/*
PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage("${m.serverUrl.value}/"+m.galleryList!.result![index].image!),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          heroAttributes: PhotoViewHeroAttributes(tag: m.galleryList!.result![index].id!),
        );
      },
      itemCount: m.galleryList!.result!.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      ),
      backgroundDecoration: BoxDecoration(
        color: Colors.black,
      ),
      pageController: pageController,
      onPageChanged: onPageChanged,
    )
 */

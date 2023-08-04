import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingorala/src/MyProvider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryImageView extends StatefulWidget {
 int index;
 GalleryImageView(this.index);

  @override
  State<GalleryImageView> createState() => _GalleryImageViewState();
}

class _GalleryImageViewState extends State<GalleryImageView> {
  int currentIndex =0;
  MyProvider m=Get.put(MyProvider());

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
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
      pageController: PageController(initialPage: widget.index),
      onPageChanged: onPageChanged,
    );
  }
}

import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageGalleryPage extends StatelessWidget {
  final AdModel adModel;
  const ImageGalleryPage({super.key, required this.adModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'صور الاعلان', isHaveBackButton: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          itemCount: adModel.images!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImageViewerPage(
                      imageUrls: adModel.images!
                          .map((e) =>
                              "${EndPoints.adImageUrl}${e.attachmentName}")
                          .toList(),
                      initialIndex: index,
                      adModel: adModel,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                        '${EndPoints.adImageUrl}${adModel.images![index].attachmentName}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ImageViewerPage extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final AdModel adModel;

  const ImageViewerPage({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
    required this.adModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صور الاعلان'),
      ),
      body: PhotoViewGallery.builder(
        itemCount: imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
                '${EndPoints.adImageUrl}${adModel.images![index].attachmentName}'),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}

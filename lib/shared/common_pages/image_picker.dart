import 'dart:io';
import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerGrid extends StatefulWidget {
  final int maxImages;
  final int forWitchFeature; // 1--> Property 2--> Cars

  const ImagePickerGrid({
    super.key,
    required this.maxImages,
    required this.forWitchFeature,
  });

  @override
  _ImagePickerGridState createState() => _ImagePickerGridState();
}

class _ImagePickerGridState extends State<ImagePickerGrid> {
  List<XFile> _images = [];
  int? _mainImageIndex;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();

    if (pickedImages.isNotEmpty) {
      setState(() {
        _images.addAll(pickedImages);
        if (_images.length > widget.maxImages) {
          _images = _images.sublist(0, widget.maxImages);
        }
        if (_mainImageIndex == null && _images.isNotEmpty) {
          _mainImageIndex = 0;
        }
      });
    }
  }

  void _setMainImage(int index) {
    setState(() {
      _mainImageIndex = index;
    });
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);

      // إذا تم حذف الصورة الرئيسية، اجعل أول صورة متبقية هي الرئيسية
      if (_mainImageIndex == index) {
        _mainImageIndex = _images.isNotEmpty ? 0 : null;
      } else if (_mainImageIndex != null && index < _mainImageIndex!) {
        _mainImageIndex = _mainImageIndex! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 2,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: const Icon(Icons.arrow_back_ios),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: TextWidget(
                text: 'أضف الصور',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            ButtonWidget(
              onTap: _pickImages,
              text: 'اختر صور',
              color: AppColors.primary,
              colorText: Colors.white,
              borderRadius: 8,
              paddingVertical: 12,
              fontSize: 16,
              height: 0,
              width: 0.7,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // شبكة 2x2
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: _mainImageIndex == index
                                ? Colors.blue
                                : Colors.grey,
                            width: _mainImageIndex == index ? 3 : 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            File(_images[index].path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      if (_mainImageIndex == index)
                        Positioned(
                          top: 4,
                          left: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'صورة رئيسية',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _setMainImage(index),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _mainImageIndex == index
                                  ? Colors.blue.withOpacity(0.7)
                                  : Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _mainImageIndex == index
                                  ? 'تم الضبط'
                                  : 'ضبط كصورة رئيسية',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      // 🛑 زر حذف الصورة
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _images.isEmpty
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                if (widget.forWitchFeature == 1) {
                  propertyAddAdCubit.addAllImages(_images);
                  Navigator.pop(context);
                } else if (widget.forWitchFeature == 2) {} // for cars
              },
              child: const Icon(Icons.check, color: Colors.black, size: 32),
            ),
    );
  }
}

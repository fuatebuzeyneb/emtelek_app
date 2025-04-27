import 'dart:io';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CircleProfileImageWidget extends StatefulWidget {
  final double heightAndWidth;
  final bool showEditImage;
  const CircleProfileImageWidget({
    super.key,
    required this.heightAndWidth,
    required this.showEditImage,
  });

  @override
  State<CircleProfileImageWidget> createState() =>
      _CircleProfileImageWidgetState();
}

class _CircleProfileImageWidgetState extends State<CircleProfileImageWidget> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        BlocProvider.of<ProfileCubit>(context).editImage = _selectedImage;
        print('editImage: ${BlocProvider.of<ProfileCubit>(context).editImage}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.heightAndWidth,
          width: widget.heightAndWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: _selectedImage != null
                  ? FileImage(_selectedImage!) as ImageProvider
                  : BlocProvider.of<ProfileCubit>(context)
                              .accountData
                              ?.data
                              ?.image ==
                          null
                      ? NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/009/292/244/large_2x/default-avatar-icon-of-social-media-user-vector.jpg',
                        )
                      : NetworkImage(
                          "${EndPoints.userImageUrl}${BlocProvider.of<ProfileCubit>(context).accountData!.data!.image!}",
                        ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        widget.showEditImage == false
            ? const SizedBox()
            : Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

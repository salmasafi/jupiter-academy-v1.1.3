// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../../core/cubit/jupiter_cubit.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/styles.dart';
import '../../../core/widgets/build_appbar_method.dart';
import '../../login/logic/models/user_model.dart';

class ImageChangeBuilder extends StatefulWidget {
  final UserModel userModel;
  const ImageChangeBuilder({
    super.key,
    required this.userModel,
  });

  @override
  State<ImageChangeBuilder> createState() => _ImageChangeBuilderState();
}

class _ImageChangeBuilderState extends State<ImageChangeBuilder> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (image == null) {
      return;
    }

    setState(() {
      showSpinner = true;
    });

    var uri = Uri.parse(
        '${APiService.baseURL}/User/changeProfilePic/${widget.userModel.id}');
    var request = http.MultipartRequest('POST', uri);

    var mimeTypeData =
        lookupMimeType(image!.path, headerBytes: [0xFF, 0xD8])?.split('/');
    if (mimeTypeData == null || mimeTypeData.length != 2) {
      return;
    }

    var multipartFile = await http.MultipartFile.fromPath(
      'picture',
      image!.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );
    request.files.add(multipartFile);

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        var responseBody = await http.Response.fromStream(response);
        print(responseBody.body);
        await BlocProvider.of<JupiterCubit>(context)
            .changeImage(widget.userModel.id);
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        var responseBody = await http.Response.fromStream(response);
        print(responseBody.body);
      }
    } catch (e) {
      print('Error uploading image: $e');
    } finally {
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: buildAppBar(),
        body: Center(
          //'Profile picture is succecfully changed',
              //'An error occured, Profile picture is failed to change, try again'
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image == null
                  ? SizedBox(
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Upload an image',
                          style: Styles.style25,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: screenHeight * 0.3,
                      width: screenHeight * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(screenHeight),
                        clipBehavior: Clip.antiAlias,
                        child: Image.file(
                          image!,
                          height: screenHeight * 0.3,
                          width: screenHeight * 0.3,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              SizedBox(height: screenHeight * 0.05),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.07,
                  child: const Center(
                    child: Text(
                      'Pick an image',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            uploadImage();
            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            height: screenHeight * 0.07,
            color: myPurple,
            child: const Center(
              child: Text(
                'Upload the image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

 /* Future<void> getImage() async {
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
        setState(() {});
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
 */
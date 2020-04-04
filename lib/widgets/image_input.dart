import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  File uploadedImage;
  Function setImage;
  String image_url;

  ImageInput(this.uploadedImage, this.setImage, this.image_url);

  @override
  ImageInputState createState() =>
      ImageInputState(uploadedImage, setImage, image_url);
}

class ImageInputState extends State<ImageInput> {
  File uploadedImage;
  Function setImage;
  String image_url;

  ImageInputState(this.uploadedImage, this.setImage, this.image_url);

  @override
  void initState() {
    super.initState();
  }

  Future selectImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      uploadedImage = image;
    });
    print("Image selected");
    setImage(uploadedImage);
  }

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: <Widget>[
        showImage(),
        SizedBox(
          height: 20.0,
        ),
        OutlineButton(
          onPressed: selectImage,
          child: Text("Select Image"),
        ),
      ],
    ));
  }

  Widget showImage() {
    print(image_url);
    return Container(
        height: 200.0,
        child: (uploadedImage == null
            ? (image_url == null
                ? Image.network(
                    'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                    height: 200.0,
                  )
                : Image.network(
                    image_url,
                    fit: BoxFit.cover,
                    height: 200.0,
                  ))
            : Image.file(
                uploadedImage,
                fit: BoxFit.cover,
                height: 200.0,
              )));
  }
}

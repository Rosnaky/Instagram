import "dart:typed_data";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:instagram_flutter/models/user.dart";
import "package:instagram_flutter/providers/UserProvider.dart";
import "package:instagram_flutter/resources/FirestoreMethods.dart";
import "package:instagram_flutter/utils/Colours.dart";
import "package:instagram_flutter/utils/Utils.dart";
import "package:provider/provider.dart";

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _image;
  final TextEditingController _captionTextEditingController =
      TextEditingController();
  bool _isLoading = false;

  void postImage(String uuid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String result = await FirestoreMethods().uploadPost(
          _captionTextEditingController.text,
          _image!,
          uuid,
          username,
          profImage);
      setState(() {
        _isLoading = false;
      });
      if (result == "Success") {
        showSnackBar(context, "Posted successfully");
      } else {
        showSnackBar(context, result);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    clearImage();
  }

  void clearImage() {
    setState(() {
      _image = null;
    });
  }

  void dispose() {
    _captionTextEditingController.dispose();
    super.dispose();
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create Post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Photo with camera"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.camera);
                  setState(() {
                    _image = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Photo from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _image = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _image == null
        ? Center(
            child: IconButton(
                icon: Icon(Icons.upload),
                onPressed: () => _selectImage(context)),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back), onPressed: clearImage),
              title: Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () =>
                        postImage(user.uid, user.username, user.photoURL),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Post",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ))
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(
                      user.photoURL,
                    )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        controller: _captionTextEditingController,
                        decoration: InputDecoration(
                            hintText: "Write a caption.",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(_image!),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter)),
                          )),
                    ),
                    const Divider()
                  ],
                )
              ],
            ),
          );
  }
}

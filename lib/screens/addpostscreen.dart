import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/utils/color.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('create a post'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(8),
                child: Text('Take a Photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                    print('file assigned');
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(8),
                child: Text('Choose a Photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                    print('file assigned');
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(8),
                child: Text('Cancel'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Scaffold(
            body: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.upload,
                  size: 65,
                ),
                onPressed: () {
                  _selectImage(context);
                },
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  clearImage();
                },
              ),
              title: Text('Post to'),
              actions: [
                TextButton(
                  onPressed: () => postImage(
                      uid: user.uid,
                      username: user.username,
                      profImage: user.photoUrl),
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            body: Column(children: [
              isLoading ? LinearProgressIndicator() : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Write a caption',
                        border: InputBorder.none,
                      ),
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
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(_file!),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          );
  }

  void postImage(
      {required String uid,
      required String username,
      required String profImage}) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, uid, _file!, username, profImage);
      if (res == 'success') {
        showSnackBar(context, 'posted!');
        setState(() {
          isLoading = false;
        });
        clearImage();
      } else {
        showSnackBar(context, res);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }
}

import 'package:dd_study_22_ui/data/services/data_service.dart';
import 'package:dd_study_22_ui/ui/widgets/common/cam_widget.dart';
import 'package:dd_study_22_ui/ui/widgets/roots/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  final _dataService = DataService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  _ViewModel({required this.context}) {}
}

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ViewModel(context: context),
      child: const NewPost(),
    );
  }
}

class _NewPostState extends State<NewPost> {
  String? _imagePath;
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descTec = TextEditingController();

  pickImage(ImageSource src) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: src);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No image selected');
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);

                  //...
                  //
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  //...
                  //
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppViewModel>();

    return _file == null
        ? Center(
            child: GestureDetector(
              onTap: () => _selectImage(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.upload,
                      size: 40,
                    ),
                  ),
                  Text('Новый пост'),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ))
              ],
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      foregroundImage: appModel.avatar?.image,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Описание...',
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
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                                'https://sun9-11.userapi.com/impg/wPqMpSWx3JEE6WfVHXF4Z-zuxhNp2vqzuP6oTQ/COkVpGkOswQ.jpg?size=604x603&quality=95&sign=416e47b3f8d475343afe1ae0863430fd&type=album'),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.center,
                          )),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}

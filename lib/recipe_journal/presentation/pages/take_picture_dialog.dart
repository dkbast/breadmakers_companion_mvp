import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TakePictureDialog extends StatefulWidget {
  final CameraDescription camera;
  final Function saveImagePath;

  TakePictureDialog(
      {Key key, @required this.camera, @required this.saveImagePath})
      : super(key: key);

  @override
  _TakePictureDialogState createState() => _TakePictureDialogState();
}

class _TakePictureDialogState extends State<TakePictureDialog> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            // TODO take a square picture
            await _controller.takePicture(path);
            widget.saveImagePath(path);
            Navigator.pop(context);
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

class CameraProvider extends ChangeNotifier {
  CameraDescription camera;

  CameraProvider({@required this.camera});
}

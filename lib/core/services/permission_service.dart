import 'package:permission_handler/permission_handler.dart';

class PermissionService {
//
  Future<bool> _requestPermission() async {
    var result = await Permission.accessNotificationPolicy.request();
    // ignore: unrelated_type_equality_checks
    if (result == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestPermission({Function? onPermissionDenied}) async {
    var granted = await _requestPermission();
    if (!granted) {
      onPermissionDenied!();
    }
    return granted;
  }
}

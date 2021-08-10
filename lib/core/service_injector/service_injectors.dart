import 'package:silencer/core/services/service_exports.dart';

class ServiceInjector {
  DatabaseService databaseService = DatabaseService();
  TimerService timerService = TimerService();
  SocketService socketService = SocketService();
  PermissionService permissionService = PermissionService();
  SoundService soundService = SoundService();
}

ServiceInjector si = ServiceInjector();

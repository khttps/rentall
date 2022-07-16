import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmanager/workmanager.dart';

class WorkerUtils {
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      if (task == 'task-identifier') {
        final user = FirebaseAuth.instance.currentUser!;
      }
      return Future.value(true);
    });
  }
}

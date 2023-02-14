import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart';
import 'contacts.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// Two Boxes: one for Tasks, one for Tags.
  late final Box<contacts> contactbox;

  /// A stream of all tasks ordered by date.
  late final Stream<Query<contacts>> tasksStream;

  ObjectBox._create(this.store) {
    contactbox = Box<contacts>(store);
    final qBuilder = contactbox.query();
    tasksStream = qBuilder.watch(triggerImmediately: true);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}


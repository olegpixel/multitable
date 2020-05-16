import 'package:sembast/sembast.dart';
import 'package:multitables/datastore/db.dart';
import 'package:multitables/models/test_group.dart';

class TestGroupDao {
  static const String TEST_GROUPS_STORE_NAME = 'test_groups';
  final _groupStore = intMapStoreFactory.store(TEST_GROUPS_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(TestGroup group) async {
    await _groupStore.add(await _db, group.toJson());
  }

  Future update(TestGroup group) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(group.id));
    await _groupStore.update(
      await _db,
      group.toJson(),
      finder: finder,
    );
  }

  Future<List<TestGroup>> getAllSorted() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('order'),
    ]);

    final recordSnapshots = await _groupStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<User> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final group = TestGroup.fromJson(snapshot.value);
      // An ID is a key of a record from the database.
      group.id = snapshot.key;
      return group;
    }).toList();
  }
}

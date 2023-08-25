import 'package:openral_core/src/model/ral_method.dart';

abstract class RalMethodRepository {
  /// Returns the [RalMethod] with the given uid. Looks for 'identity.UID' == uid in the database.
  ///
  /// throws Exception if no [RalMethod] with the given uid exists in the repository.
  Future<RalMethod> getByUid(String uid);

  /// Returns all [RalMethod]s with the given ralType. Looks for 'template.RALType' == ralType in the database.
  Future<List<RalMethod>> getByRalType(String ralType);

  /// Creates a new [RalMethod] in the database. If [overrideIfExists] is true, the [RalMethod] will be overwritten if it already exists. Otherwise, an error will be thrown.
  Future<void> create(RalMethod ralMethod, {required bool overrideIfExists});

  Future<void> deleteByUid(String uid);

  /// updates the given [RalMethod]
  /// the modification must be done in the [modificationFunc] function, which provides an update to date version of the [RalMethod] as a parameter, to avoid overwriting changes
  Future<void> updateMethod({
    required RalMethod ralMethod,
    required RalMethod Function(RalMethod method) modificationFunc,
  }) async {
    await updateByUid(
      uid: ralMethod.identity.uid,
      modificationFunc: modificationFunc,
    );
  }

  /// updates the given RalMethod with the given uid
  /// the modification must be done in the [modificationFunc] function, which provides an update to date version of the [RalMethod] as a parameter, to avoid overwriting changes
  Future<void> updateByUid({
    required String uid,
    required RalMethod Function(RalMethod object) modificationFunc,
  }) async {
    //Note: if the specific implementation of [RalMethodRepository] supports transactions, this should be done in a transaction

    final object = await getByUid(uid);

    final modifiedObject = modificationFunc(object);

    await create(
      modifiedObject,
      overrideIfExists: true,
    );
  }
}

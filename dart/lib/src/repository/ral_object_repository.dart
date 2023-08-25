import 'package:openral_core/src/model/ral_object.dart';
import 'package:openral_core/src/model/specific_properties.dart';

typedef SpecificPropertiesTransform<S extends SpecificProperties> = S Function(SpecificProperties properties);

abstract class RalObjectRepository {
  /// Returns the [RalObject] with the given uid. Looks for 'identity.UID' == uid in the database.
  ///
  /// If [specificPropertiesTransform] is not null, the [SpecificProperties] of the [RalObject] will be transformed to the given type.
  Future<RalObject> getByUid(String uid, {SpecificPropertiesTransform? specificPropertiesTransform});

  /// Returns all [RalObject]s with the given containerId. Looks for 'currentGeolocation.container.UID' == containerId in the database.
  Future<List<RalObject>> getByContainerId(String containerId);

  /// Returns all [RalObject]s with the given ralType. Looks for 'template.RALType' == ralType in the database.
  Future<List<RalObject>> getByRalType(String ralType);

  /// Creates a new [RalObject] in the database. If [overrideIfExists] is true, the [RalObject] will be overwritten if it already exists. Otherwise, an error will be thrown.
  Future<void> create(RalObject ralObject, {required bool overrideIfExists});

  Future<void> deleteByUid(String uid);

  /// updates the given [RalObject]
  /// the modification must be done in the [modificationFunc] function, which provides an update to date version of the [RalObject] as a parameter, to avoid overwriting changes
  Future<void> updateObject({
    required RalObject ralObject,
    required RalObject Function(RalObject object) modificationFunc,
  }) async {
    await updateByUid(
      uid: ralObject.identity.uid,
      modificationFunc: modificationFunc,
    );
  }

  /// updates the given RalObject with the given uid
  /// the modification must be done in the [modificationFunc] function, which provides an update to date version of the [RalObject] as a parameter, to avoid overwriting changes
  Future<void> updateByUid({
    required String uid,
    required RalObject Function(RalObject object) modificationFunc,
  }) async {
    //Note: if the specific implementation of [RalObjectRepository] supports transactions, this should be done in a transaction

    final object = await getByUid(uid);

    final modifiedObject = modificationFunc(object);

    await create(
      modifiedObject,
      overrideIfExists: true,
    );
  }
}

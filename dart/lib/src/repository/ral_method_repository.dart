import 'package:openral_core/src/model/ral_method.dart';

abstract class RalMethodRepository {
  /// Returns the [RalMethod] with the given uid. Looks for 'identity.UID' == uid in the database.
  ///
  /// Returns null if no method is found with the given uid.
  RalMethod? getByUid(String uid);

  /// Returns all [RalMethod]s with the given ralType. Looks for 'template.RALType' == ralType in the database.
  List<RalMethod> getByRalType(String ralType);

  /// Creates a new [RalObject] in the database. If [overrideIfExists] is true, the [RalObject] will be overwritten if it already exists. Otherwise, an error will be thrown.
  Future<void> create(RalMethod ralMethod, {required bool overrideIfExists});
}

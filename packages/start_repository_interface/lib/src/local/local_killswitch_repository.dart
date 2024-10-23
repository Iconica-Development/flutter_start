import "package:start_repository_interface/src/interfaces/killswitch_repository_interface.dart";

/// The local killswitch repository.
class LocalKillswitchRepository implements KillswitchRepositoryInterface {
  @override
  Future<bool> isKillswitchActive() async => false;
}

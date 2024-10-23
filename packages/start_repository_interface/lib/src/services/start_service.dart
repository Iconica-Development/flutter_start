import "package:start_repository_interface/src/interfaces/killswitch_repository_interface.dart";
import "package:start_repository_interface/src/local/local_killswitch_repository.dart";

/// Start service.
class StartService {
  /// The start service constructor.
  StartService({
    KillswitchRepositoryInterface? killswitchRepositoryInterface,
  }) : killswitchRepositoryInterface =
            killswitchRepositoryInterface ?? LocalKillswitchRepository();

  /// The killswitch repository interface.
  final KillswitchRepositoryInterface? killswitchRepositoryInterface;

  /// Check if the killswitch is active.
  Future<bool> isKillswitchActive() async =>
      killswitchRepositoryInterface!.isKillswitchActive();
}

/// Killswitch repository interface
// ignore: one_member_abstracts
abstract class KillswitchRepositoryInterface {
  /// Checks if the killswitch is active for the current app.
  Future<bool> isKillswitchActive();
}

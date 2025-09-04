import 'package:fit_track/features/fit_track/modals/userModal.dart';
import 'package:fit_track/features/fit_track/services/userServices/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepositoryProvider = StateProvider((ref) => Userrepo());

final currentUserStreamProvider = StreamProvider<Usermodal?>((ref) {
  return ref.read(userRepositoryProvider).streamCurrentUser();
});

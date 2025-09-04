import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/features/fit_track/modals/userModal.dart';
import 'package:fit_track/features/fit_track/services/userServices/profile_services.dart';
import 'package:riverpod/riverpod.dart';

final passwordhideProvider = StateProvider<bool>((ref) => false);
final isFormValidProvider = StateProvider<bool>((ref) => false);
final signUpControllerProvider =
    StateNotifierProvider<Signupcontroller, AsyncValue>((ref) {
      return Signupcontroller(ProfileServices());
    });

class Signupcontroller extends StateNotifier<AsyncValue<void>> {
  final ProfileServices profileServices;
  Signupcontroller(this.profileServices) : super(AsyncValue.data(null));
  //firebase signup
  Future signUp(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final firebaseAuth = FirebaseAuth.instance;
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw 'User creation failed';
      }
      final usermodal = Usermodal(
        userId: user.uid,
        name: '',
        email: email,
        dateOfBirth: '',
        weight: 0,
        height: 0,
        targetSteps: 0,
        logSteps: 0,
      );
      await profileServices.createUser(usermodal);
      state = const AsyncValue.data(null);
      return true;
    } on FirebaseAuthException catch (error, stack) {
      state = AsyncValue.error(error.message.toString(), stack);
      return false;
    } catch (e, stack) {
      state = AsyncValue.error('unable to sign up', stack);
      return false;
    }
  }
}

import 'package:cash_prow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/profile_providers.dart';

class ProfileState {
  final bool uploading;
  final String? error;

  const ProfileState({this.uploading = false, this.error});
}

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() => const ProfileState();

  Future<void> uploadProfilePicture() async {
    state = const ProfileState(uploading: true);

    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.gallery);

      if (file == null) {
        state = const ProfileState(uploading: false);
        return;
      }

      final remote = ref.read(profileRemoteDataSourceProvider);
      await remote.uploadProfilePicture(file.path);

      // ✅ refresh user by calling /me again
      await ref.read(authControllerProvider.notifier).loadSession();

      state = const ProfileState(uploading: false);
    } catch (e) {
      state = ProfileState(uploading: false, error: e.toString());
    }
  }
}

final profileControllerProvider =
    NotifierProvider<ProfileController, ProfileState>(ProfileController.new);

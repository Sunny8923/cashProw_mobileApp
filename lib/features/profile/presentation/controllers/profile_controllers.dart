import 'dart:io';

import 'package:cash_prow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../providers/profile_providers.dart';

class ProfileState {
  final bool uploading;
  final bool updating;
  final bool otpLoading;
  final String? error;

  const ProfileState({
    this.uploading = false,
    this.updating = false,
    this.otpLoading = false,
    this.error,
  });

  ProfileState copyWith({
    bool? uploading,
    bool? updating,
    bool? otpLoading,
    String? error,
  }) {
    return ProfileState(
      uploading: uploading ?? this.uploading,
      updating: updating ?? this.updating,
      otpLoading: otpLoading ?? this.otpLoading,
      error: error,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() => const ProfileState();

  // ================= PROFILE PICTURE =================

  Future<void> uploadProfilePicture() async {
    try {
      state = state.copyWith(uploading: true, error: null);

      final picker = ImagePicker();

      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (picked == null) {
        state = state.copyWith(uploading: false);
        return;
      }

      // 👉 Open circular crop screen
      final cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        compressFormat: ImageCompressFormat.jpg, // 🔥 important
        compressQuality: 90,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Picture',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: true,
            cropStyle: CropStyle.circle,
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
          IOSUiSettings(
            title: 'Crop Profile Picture',
            cropStyle: CropStyle.circle,
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
        ],
      );

      if (cropped == null) {
        state = state.copyWith(uploading: false);
        return;
      }

      final remote = ref.read(profileRemoteDataSourceProvider);

      // 👉 Upload only cropped image
      await remote.uploadProfilePicture(cropped.path);

      // 👉 Refresh user session to get new image url
      await ref.read(authControllerProvider.notifier).loadSession();

      state = state.copyWith(uploading: false);
    } catch (e) {
      state = state.copyWith(uploading: false, error: e.toString());
    }
  }

  // ================= UPDATE PROFILE =================

  Future<void> updateProfile({
    String? address,
    String? occupation,
    double? salary,
  }) async {
    try {
      state = state.copyWith(updating: true, error: null);

      final remote = ref.read(profileRemoteDataSourceProvider);

      await remote.updateProfile(
        address: address,
        occupation: occupation,
        salary: salary,
      );

      await ref.read(authControllerProvider.notifier).loadSession();

      state = state.copyWith(updating: false);
    } catch (e) {
      state = state.copyWith(updating: false, error: e.toString());
    }
  }

  // ================= EMAIL OTP =================

  Future<void> requestEmailOtp(String email) async {
    try {
      state = state.copyWith(otpLoading: true, error: null);

      final remote = ref.read(profileRemoteDataSourceProvider);

      await remote.requestChangeEmail(email);

      state = state.copyWith(otpLoading: false);
    } catch (e) {
      state = state.copyWith(otpLoading: false, error: e.toString());
    }
  }

  Future<bool> verifyEmailOtp(String email, String otp) async {
    try {
      state = state.copyWith(otpLoading: true, error: null);

      final remote = ref.read(profileRemoteDataSourceProvider);

      await remote.verifyChangeEmail(newEmail: email, otp: otp);

      await ref.read(authControllerProvider.notifier).loadSession();

      state = state.copyWith(otpLoading: false);

      return true; // ✅ OTP SUCCESS
    } catch (e) {
      state = state.copyWith(otpLoading: false, error: e.toString());

      return false; // ❌ OTP FAILED
    }
  }
}

final profileControllerProvider =
    NotifierProvider<ProfileController, ProfileState>(ProfileController.new);

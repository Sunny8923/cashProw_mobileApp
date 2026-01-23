import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/token_storage.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/me_usecase.dart';
import '../providers/auth_providers.dart';

class AuthState {
  final bool isLoading;
  final UserModel? user;
  final String? token;
  final String? error;

  const AuthState({this.isLoading = false, this.user, this.token, this.error});

  AuthState copyWith({
    bool? isLoading,
    UserModel? user,
    bool clearUser = false,
    String? token,
    bool clearToken = false,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: clearUser ? null : (user ?? this.user),
      token: clearToken ? null : (token ?? this.token),
      error: error,
    );
  }
}

class AuthController extends Notifier<AuthState> {
  late final LoginUseCase _loginUseCase;
  late final MeUseCase _meUseCase;
  late final TokenStorage _tokenStorage;

  @override
  AuthState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    _meUseCase = ref.read(meUseCaseProvider);
    _tokenStorage = ref.read(tokenStorageProvider);
    return const AuthState();
  }

  /// ✅ Called from SplashScreen
  /// - reads token from storage
  /// - validates by calling /me
  /// - sets user in state if valid
  Future<void> loadSession() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final savedToken = await _tokenStorage.getToken();

      if (savedToken == null || savedToken.isEmpty) {
        // no token stored -> go login
        state = state.copyWith(isLoading: false);
        return;
      }

      // ✅ token exists, validate session
      final user = await _meUseCase();

      state = state.copyWith(
        isLoading: false,
        token: savedToken,
        user: user,
        error: null,
      );
    } catch (e) {
      // token invalid -> clear
      await _tokenStorage.clearToken();

      state = state.copyWith(
        isLoading: false,
        clearUser: true,
        clearToken: true,
        error: null,
      );
    }
  }

  /// ✅ Login API call
  /// - saves token in secure storage
  /// - updates state
  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final res = await _loginUseCase(
        LoginRequestModel(email: email, password: password),
      );

      // ✅ save token permanently
      await _tokenStorage.saveToken(res.token);

      // ✅ update state with token + user
      state = state.copyWith(
        isLoading: false,
        user: res.user,
        token: res.token,
        error: null,
      );
    } catch (e) {
      final msg = e.toString().replaceFirst("Exception: ", "");
      state = state.copyWith(isLoading: false, error: msg);
    }
  }

  /// ✅ Logout
  /// - clears token from storage
  /// - clears user/token from state
  Future<void> logout() async {
    await _tokenStorage.clearToken();

    state = state.copyWith(
      clearUser: true,
      clearToken: true,
      isLoading: false,
      error: null,
    );
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

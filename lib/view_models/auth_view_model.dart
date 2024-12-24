import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/custom-exception.dart';
import '../base/provider/api_provider_imp.dart';
import '../configs/contants.dart';
import '../model/auth.dart';
import '../repositories/login_repo/login_repo_imp.dart';
import '../utilities/hive_utils.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginRepoImp _apiService;

  AuthNotifier(this._apiService)
      : super(AuthState(status: AuthStatus.unauthenticated)) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await HiveUtils.getValue<String?>(
        Contant.AUTHENTICATION, Contant.AUTHEN_TOKEN);
    if (token != null) {
      state = AuthState(status: AuthStatus.authenticated, token: token);
    }
  }

  Future<void> authenticationLogin(String email, String password) async {
    try {
      state = AuthState(status: AuthStatus.loading);
      final information = await _apiService.getInformation(email, password);
      state = AuthState(
        status: AuthStatus.authenticated,
        token: information.authToken, // Use actual token from API
      );
      await HiveUtils.putValue<String?>(
          Contant.AUTHENTICATION, Contant.AUTHEN_TOKEN, information.authToken);
    } on ECException catch (e) {
      state = state = AuthState(
          status: AuthStatus.authenticated, errorMessage: e.toString());
    }
  }

  void logout() {
    HiveUtils.closeAll();
    state = AuthState(status: AuthStatus.unauthenticated);
  }
}

final apiServiceProvider = Provider<LoginRepoImp>((ref) {
  return LoginRepoImp(ApiProviderImp());
});
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(apiServiceProvider));
});

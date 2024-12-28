import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/page/home/navigation.dart';
import 'package:smart_farm_application/page/onBoarding/onboarding_screen.dart';

import '../components/loading_widget.dart';
import '../configs/contants.dart';
import '../view_models/auth_view_model.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    switch (authState.status) {
      case AuthStatus.authenticated:
        return const NavigationScreen();
      case AuthStatus.loading:
        return const LoadingWidget();
      case AuthStatus.error:
        return const OnBoardingScreen();
      default:
        return const OnBoardingScreen();
    }
  }
}

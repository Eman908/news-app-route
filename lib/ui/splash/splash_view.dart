import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/core/utils/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    animationControl();
    navigatorControl();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          AnimatedBuilder(
            animation: _animationController,
            builder:
                (context, child) => Transform.scale(
                  scale: _animation.value,
                  child: Image.asset(
                    context.provider.isDark(context)
                        ? Assets.assetsImagesNewsLogo
                        : Assets.assetsImagesLogoLight,
                  ),
                ),
          ),
          const Spacer(),
          Image.asset(
            context.provider.isDark(context)
                ? Assets.assetsImagesNewsBranding
                : Assets.assetsImagesBrandingLight,
          ),
        ],
      ),
    );
  }

  void navigatorControl() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
      }
    });
  }

  void animationControl() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }
}

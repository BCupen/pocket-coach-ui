import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final bool useSafeArea;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final String? backgroundImage;

  const AppScaffold({
    super.key,
    required this.child,
    this.useSafeArea = true,
    this.appBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = child;

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      extendBodyBehindAppBar: backgroundImage != null,
      appBar: appBar,
      backgroundColor: backgroundColor ?? Colors.black,
      floatingActionButton: floatingActionButton,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (backgroundImage != null)
            Image.asset(backgroundImage!, fit: BoxFit.cover),
          if (backgroundImage != null)
            Container(color: Colors.black.withOpacity(0.5)),
          content,
        ],
      ),
    );
  }
}

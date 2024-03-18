import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Star icon
class StarIcon extends ConsumerWidget {
  const StarIcon({super.key});

  // * Keys for testing using find.byKey()
  static const StarIconKey = Key('star');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Center(
          child: IconButton(
            key: StarIconKey,
            icon: const Icon(Icons.star),
            onPressed: () => context.goNamed(AppRoute.star.name),
          ),
        ),
      ],
    );
  }
}

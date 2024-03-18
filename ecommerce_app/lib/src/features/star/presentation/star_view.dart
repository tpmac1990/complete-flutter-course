import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// part 'star_view.g.dart';


class StarViewScreen extends ConsumerWidget {
  const StarViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(title: const Text('Star')),
      body: const Center(child: Text('hello, World!')),
    );
  }
}
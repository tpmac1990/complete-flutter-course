import 'package:ecommerce_app/src/features/star/data/fake_members_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class StarViewScreen extends ConsumerWidget {
  const StarViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // final counter = ref.watch(counterProvider);
    // final memberName = ref.watch(memberProvider);
    final bamsName = ref.watch(bamsProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                // 'Value: $counter',
                // memberName,
                bamsName['name'],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // ref.read(counterProvider.notifier).increment();
              // ref.read(memberProvider.notifier).setName('kelly');
              ref.read(bamsProvider.notifier).setName('kelly');
            },
            child: const Text('Click Me'),
          ),
        ],
      ),
    );
  }
}

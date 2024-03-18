import 'package:ecommerce_app/src/features/star/data/fake_members_repository.dart';
import 'package:ecommerce_app/src/features/star/domain/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// part 'star_view.g.dart';


class StarViewScreen extends ConsumerWidget {
  const StarViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final member = ref.watch(membersRepositoryProvider);
    final memberNow = member.currentMember?.name ?? 'mike';

    ref.read(membersRepositoryProvider).currentMember = const Member(id: 94, name: 'john', hobby: Hobby.running);

    return Scaffold(
      appBar: AppBar(title: const Text('Star')),
      body: Center(child: Text(memberNow)),
    );
  }
}
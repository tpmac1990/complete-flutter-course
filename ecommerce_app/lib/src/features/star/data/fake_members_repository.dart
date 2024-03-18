import 'package:ecommerce_app/src/features/star/domain/member.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_members_repository.g.dart';

class FakeMembersRepository {
  FakeMembersRepository();

  final _member = InMemoryStore<Member?>(null);

  set currentMember(Member? newMember) => _member.value = newMember;

  Member? get currentMember => _member.value;
}

@riverpod
FakeMembersRepository membersRepository(MembersRepositoryRef ref) {
  return FakeMembersRepository();
}

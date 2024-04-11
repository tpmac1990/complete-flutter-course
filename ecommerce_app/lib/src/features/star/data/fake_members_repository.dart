import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_members_repository.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

@riverpod
class Member extends _$Member {
  @override
  String build() {
    return 'john';
  }

  void setName(name) {
    state = name;
  }
}

@riverpod
class Bams extends _$Bams {
  @override
  Map<String, dynamic> build() {
    return {
      'name': 'frank',
      'age': 88,
    };
  }

  void setName(name) {
    state = {...state,
      'name': 'kelly',
    };
  }
}

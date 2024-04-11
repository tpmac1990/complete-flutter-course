import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_place_popup_repository.g.dart';


@riverpod
class TargetPlace extends _$TargetPlace {
  @override
  Map<String, dynamic> build() {
    return {
      'number': 0,
    };
  }

  void setPlaceNumber(number) {
    state = {...state,
      'number': number,
    };
  }
}

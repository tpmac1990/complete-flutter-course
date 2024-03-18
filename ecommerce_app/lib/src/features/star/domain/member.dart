import 'package:ecommerce_app/src/exceptions/app_exception.dart';

/// Member status
enum Hobby { soccer, football, running }

/// Helper method to get the order status from String
extension HobbyString on Hobby {
  static Hobby fromString(String string) {
    if (string == 'soccer') return Hobby.soccer;
    if (string == 'football') return Hobby.football;
    if (string == 'running') return Hobby.running;
    throw ParseOrderFailureException(string);
  }
}

/// Model class representing a member.
class Member {
  const Member({
    required this.id,
    required this.name,
    required this.hobby,
  });

  /// Unique member ID
  final int id;
  final String name;
  final Hobby hobby;
}

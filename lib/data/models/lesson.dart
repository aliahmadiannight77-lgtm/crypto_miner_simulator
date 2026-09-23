/// Represents an educational lesson in the game.
///
/// Lessons provide educational content about cryptocurrency,
/// blockchain and related concepts.
///
/// Educational progress is stored locally.
class Lesson {
  final String id;
  final String title;
  final String description;
  final String content;

  /// Category of the lesson.
  ///
  /// Examples:
  /// - bitcoin
  /// - ethereum
  /// - blockchain
  /// - wallet
  /// - exchange
  /// - stablecoin
  /// - mining
  /// - security
  final String category;

  /// Estimated reading time in minutes.
  final int estimatedMinutes;

  /// Virtual XP awarded after completing the lesson.
  final int xpReward;

  /// Display order inside its category.
  final int order;

  /// Whether the user has completed the lesson.
  final bool isCompleted;

  /// Time when the lesson was completed.
  final DateTime? completedAt;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    required this.estimatedMinutes,
    required this.xpReward,
    required this.order,
    required this.isCompleted,
    required this.completedAt,
  });

  /// Returns true when the lesson has not been completed.
  bool get isPending => !isCompleted;

  /// Returns true when the lesson has a completion timestamp.
  bool get hasCompletionDate => completedAt != null;

  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    String? content,
    String? category,
    int? estimatedMinutes,
    int? xpReward,
    int? order,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      category: category ?? this.category,
      estimatedMinutes:
          estimatedMinutes ?? this.estimatedMinutes,
      xpReward: xpReward ?? this.xpReward,
      order: order ?? this.order,
      isCompleted:
          isCompleted ?? this.isCompleted,
      completedAt:
          completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'category': category,
      'estimatedMinutes': estimatedMinutes,
      'xpReward': xpReward,
      'order': order,
      'isCompleted': isCompleted,
      'completedAt':
          completedAt?.toUtc().toIso8601String(),
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    final id = _readRequiredString(
      map,
      'id',
    );

    final title = _readRequiredString(
      map,
      'title',
    );

    final description = _readRequiredString(
      map,
      'description',
    );

    final content = _readRequiredString(
      map,
      'content',
    );

    final category = _readRequiredString(
      map,
      'category',
    );

    final estimatedMinutes = _readInt(
      map,
      'estimatedMinutes',
    );

    final xpReward = _readInt(
      map,
      'xpReward',
    );

    final order = _readInt(
      map,
      'order',
    );

    final isCompleted = _readBool(
      map,
      'isCompleted',
    );

    final completedAt = _readNullableDateTime(
      map,
      'completedAt',
    );

    if (estimatedMinutes <= 0) {
      throw FormatException(
        'Estimated lesson time must be greater than zero.',
      );
    }

    if (xpReward < 0) {
      throw FormatException(
        'Lesson XP reward cannot be negative.',
      );
    }

    if (order < 0) {
      throw FormatException(
        'Lesson order cannot be negative.',
      );
    }

    if (isCompleted && completedAt == null) {
      throw FormatException(
        'Completed lesson must have a completion date.',
      );
    }

    if (!isCompleted && completedAt != null) {
      throw FormatException(
        'Incomplete lesson cannot have a completion date.',
      );
    }

    return Lesson(
      id: id,
      title: title,
      description: description,
      content: content,
      category: category,
      estimatedMinutes: estimatedMinutes,
      xpReward: xpReward,
      order: order,
      isCompleted: isCompleted,
      completedAt: completedAt,
    );
  }

  static String _readRequiredString(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is! String || value.trim().isEmpty) {
      throw FormatException(
        'Field "$key" must be a non-empty string.',
      );
    }

    return value.trim();
  }

  static int _readInt(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is int) {
      return value;
    }

    if (value is num) {
      if (value.isFinite && value == value.toInt()) {
        return value.toInt();
      }
    }

    if (value is String) {
      final parsed = int.tryParse(value);

      if (parsed != null) {
        return parsed;
      }
    }

    throw FormatException(
      'Field "$key" must contain a valid integer.',
    );
  }

  static bool _readBool(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is bool) {
      return value;
    }

    if (value is String) {
      final normalized = value.trim().toLowerCase();

      if (normalized == 'true') {
        return true;
      }

      if (normalized == 'false') {
        return false;
      }
    }

    throw FormatException(
      'Field "$key" must contain a valid boolean.',
    );
  }

  static DateTime? _readNullableDateTime(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value.toUtc();
    }

    if (value is String) {
      final parsed = DateTime.tryParse(value);

      if (parsed != null) {
        return parsed.toUtc();
      }
    }

    throw FormatException(
      'Field "$key" must contain a valid ISO-8601 date '
      'or null.',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! Lesson) {
      return false;
    }

    return id == other.id &&
        title == other.title &&
        description == other.description &&
        content == other.content &&
        category == other.category &&
        estimatedMinutes == other.estimatedMinutes &&
        xpReward == other.xpReward &&
        order == other.order &&
        isCompleted == other.isCompleted &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      content,
      category,
      estimatedMinutes,
      xpReward,
      order,
      isCompleted,
      completedAt,
    );
  }

  @override
  String toString() {
    return 'Lesson('
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'category: $category, '
        'estimatedMinutes: $estimatedMinutes, '
        'xpReward: $xpReward, '
        'order: $order, '
        'isCompleted: $isCompleted, '
        'completedAt: $completedAt'
        ')';
  }
}
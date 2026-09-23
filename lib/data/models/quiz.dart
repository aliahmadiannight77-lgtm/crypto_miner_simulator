/// Represents an educational quiz.
///
/// A quiz belongs to the educational system of the game and can be
/// associated with a lesson or a specific educational topic.
///
/// Answer evaluation and scoring belong to the domain layer.
class Quiz {
  final String id;
  final String title;
  final String description;
  final String category;
  final String? lessonId;
  final List<QuizQuestion> questions;
  final int xpReward;
  final int passingScore;
  final bool isCompleted;
  final int bestScore;
  final DateTime? completedAt;

  const Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.lessonId,
    required this.questions,
    required this.xpReward,
    required this.passingScore,
    required this.isCompleted,
    required this.bestScore,
    required this.completedAt,
  });

  int get questionCount => questions.length;

  int get maximumScore => questions.length;

  bool get hasQuestions => questions.isNotEmpty;

  bool get hasLesson => lessonId != null;

  bool get hasXpReward => xpReward > 0;

  bool get hasCompletedAttempt => completedAt != null;

  bool get hasPassingScore =>
      bestScore >= passingScore;

  double get bestScorePercent {
    if (maximumScore <= 0) {
      return 0;
    }

    return (bestScore / maximumScore) * 100;
  }

  Quiz copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? lessonId,
    List<QuizQuestion>? questions,
    int? xpReward,
    int? passingScore,
    bool? isCompleted,
    int? bestScore,
    DateTime? completedAt,
  }) {
    return Quiz(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      lessonId: lessonId ?? this.lessonId,
      questions: List<QuizQuestion>.unmodifiable(
        questions ?? this.questions,
      ),
      xpReward: xpReward ?? this.xpReward,
      passingScore: passingScore ?? this.passingScore,
      isCompleted: isCompleted ?? this.isCompleted,
      bestScore: bestScore ?? this.bestScore,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'lessonId': lessonId,
      'questions': questions
          .map((question) => question.toMap())
          .toList(),
      'xpReward': xpReward,
      'passingScore': passingScore,
      'isCompleted': isCompleted,
      'bestScore': bestScore,
      'completedAt':
          completedAt?.toUtc().toIso8601String(),
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    final id = _readRequiredString(map, 'id');
    final title = _readRequiredString(map, 'title');
    final description =
        _readRequiredString(map, 'description');
    final category =
        _readRequiredString(map, 'category');

    final lessonId =
        _readNullableString(map, 'lessonId');

    final questions =
        _readQuestions(map, 'questions');

    final xpReward = _readInt(map, 'xpReward');
    final passingScore =
        _readInt(map, 'passingScore');
    final isCompleted =
        _readBool(map, 'isCompleted');
    final bestScore =
        _readInt(map, 'bestScore');

    final completedAt =
        _readNullableDateTime(map, 'completedAt');

    if (questions.isEmpty) {
      throw FormatException(
        'Quiz must contain at least one question.',
      );
    }

    if (xpReward < 0) {
      throw FormatException(
        'Quiz XP reward cannot be negative.',
      );
    }

    if (passingScore < 0 ||
        passingScore > questions.length) {
      throw FormatException(
        'Quiz passing score is outside the valid range.',
      );
    }

    if (bestScore < 0 ||
        bestScore > questions.length) {
      throw FormatException(
        'Quiz best score is outside the valid range.',
      );
    }

    if (isCompleted && completedAt == null) {
      throw FormatException(
        'Completed quiz must have a completion date.',
      );
    }

    if (!isCompleted && completedAt != null) {
      throw FormatException(
        'Incomplete quiz cannot have a completion date.',
      );
    }

    return Quiz(
      id: id,
      title: title,
      description: description,
      category: category,
      lessonId: lessonId,
      questions: List<QuizQuestion>.unmodifiable(
        questions,
      ),
      xpReward: xpReward,
      passingScore: passingScore,
      isCompleted: isCompleted,
      bestScore: bestScore,
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

  static String? _readNullableString(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value == null) {
      return null;
    }

    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }

    throw FormatException(
      'Field "$key" must contain a non-empty string '
      'or null.',
    );
  }

  static List<QuizQuestion> _readQuestions(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is! List) {
      throw FormatException(
        'Field "$key" must contain a list.',
      );
    }

    return value.map((item) {
      if (item is! Map) {
        throw FormatException(
          'Each quiz question must be a map.',
        );
      }

      return QuizQuestion.fromMap(
        Map<String, dynamic>.from(item),
      );
    }).toList();
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
      final normalized =
          value.trim().toLowerCase();

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

    if (other is! Quiz) {
      return false;
    }

    return id == other.id &&
        title == other.title &&
        description == other.description &&
        category == other.category &&
        lessonId == other.lessonId &&
        _listEquals(questions, other.questions) &&
        xpReward == other.xpReward &&
        passingScore == other.passingScore &&
        isCompleted == other.isCompleted &&
        bestScore == other.bestScore &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      category,
      lessonId,
      Object.hashAll(questions),
      xpReward,
      passingScore,
      isCompleted,
      bestScore,
      completedAt,
    );
  }

  @override
  String toString() {
    return 'Quiz('
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'category: $category, '
        'lessonId: $lessonId, '
        'questionCount: ${questions.length}, '
        'xpReward: $xpReward, '
        'passingScore: $passingScore, '
        'isCompleted: $isCompleted, '
        'bestScore: $bestScore, '
        'completedAt: $completedAt'
        ')';
  }

  static bool _listEquals(
    List<QuizQuestion> first,
    List<QuizQuestion> second,
  ) {
    if (identical(first, second)) {
      return true;
    }

    if (first.length != second.length) {
      return false;
    }

    for (var i = 0; i < first.length; i++) {
      if (first[i] != second[i]) {
        return false;
      }
    }

    return true;
  }
}

/// Represents a single question inside a quiz.
class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });

  int get optionCount => options.length;

  bool get hasExplanation =>
      explanation.trim().isNotEmpty;

  QuizQuestion copyWith({
    String? id,
    String? question,
    List<String>? options,
    int? correctOptionIndex,
    String? explanation,
  }) {
    return QuizQuestion(
      id: id ?? this.id,
      question: question ?? this.question,
      options: List<String>.unmodifiable(
        options ?? this.options,
      ),
      correctOptionIndex:
          correctOptionIndex ?? this.correctOptionIndex,
      explanation:
          explanation ?? this.explanation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': List<String>.from(options),
      'correctOptionIndex': correctOptionIndex,
      'explanation': explanation,
    };
  }

  factory QuizQuestion.fromMap(
    Map<String, dynamic> map,
  ) {
    final id =
        Quiz._readRequiredString(map, 'id');

    final question =
        Quiz._readRequiredString(map, 'question');

    final options =
        _readOptions(map, 'options');

    final correctOptionIndex =
        Quiz._readInt(
          map,
          'correctOptionIndex',
        );

    final explanation =
        Quiz._readRequiredString(
          map,
          'explanation',
        );

    if (options.length < 2) {
      throw FormatException(
        'Quiz question must have at least two options.',
      );
    }

    if (correctOptionIndex < 0 ||
        correctOptionIndex >= options.length) {
      throw FormatException(
        'Correct option index is outside the valid range.',
      );
    }

    return QuizQuestion(
      id: id,
      question: question,
      options: List<String>.unmodifiable(
        options,
      ),
      correctOptionIndex: correctOptionIndex,
      explanation: explanation,
    );
  }

  static List<String> _readOptions(
    Map<String, dynamic> map,
    String key,
  ) {
    final value = map[key];

    if (value is! List) {
      throw FormatException(
        'Field "$key" must contain a list.',
      );
    }

    final options = <String>[];

    for (final item in value) {
      if (item is! String || item.trim().isEmpty) {
        throw FormatException(
          'Every quiz option must be a non-empty string.',
        );
      }

      options.add(item.trim());
    }

    return options;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! QuizQuestion) {
      return false;
    }

    return id == other.id &&
        question == other.question &&
        _listEquals(options, other.options) &&
        correctOptionIndex ==
            other.correctOptionIndex &&
        explanation == other.explanation;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      question,
      Object.hashAll(options),
      correctOptionIndex,
      explanation,
    );
  }

  @override
  String toString() {
    return 'QuizQuestion('
        'id: $id, '
        'question: $question, '
        'optionCount: ${options.length}, '
        'correctOptionIndex: $correctOptionIndex'
        ')';
  }

  static bool _listEquals(
    List<String> first,
    List<String> second,
  ) {
    if (identical(first, second)) {
      return true;
    }

    if (first.length != second.length) {
      return false;
    }

    for (var i = 0; i < first.length; i++) {
      if (first[i] != second[i]) {
        return false;
      }
    }

    return true;
  }
}
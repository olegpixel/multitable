class TestGroup {
  int id; // automatically generated & unique

  final String title; // for FE
  final String description; // for FE
  final String groupClass; // e.g. exam / practice
  final int order; // for sorting
  final List<String> problemsClass;
  final double progress;
  final bool isTimed; // enable/disable countdown for test

  TestGroup(
      {this.title,
      this.description,
      this.groupClass,
      this.order,
      this.problemsClass,
      this.progress,
      this.isTimed});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'groupClass': groupClass,
      'order': order,
      'problemsClass': List<dynamic>.from(problemsClass.map((x) => x)),
      'progress': progress,
      'isTimed': isTimed,
    };
  }

  static TestGroup fromJson(Map<String, dynamic> map) {
    return TestGroup(
      title: map['title'],
      description: map['description'],
      groupClass: map['groupClass'],
      order: map['order'],
      problemsClass: List<String>.from(map["problemsClass"].map((x) => x)),
      progress: map['progress'],
      isTimed: map['isTimed'],
    );
  }
}

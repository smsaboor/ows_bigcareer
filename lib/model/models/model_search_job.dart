class ModelSearchJob {
  final String stateId;
  final String salary;
  final String keyword;
  final String education;
  const ModelSearchJob({
    required this.stateId,
    required this.salary,
    required this.keyword,
    required this.education,
  });

  ModelSearchJob copy({
    String? stateId,
    String? salary,
    String? keyword,
    String? education,
  }) =>
      ModelSearchJob(
        stateId: stateId ?? this.stateId,
        salary: salary ?? this.salary,
        keyword: keyword ?? this.keyword,
        education: education ?? this.education,
      );

  static ModelSearchJob fromJson(Map<String, dynamic> json) => ModelSearchJob(
    stateId: json['stateId'],
    salary: json['salary'],
    keyword: json['keyword'],
    education: json['education'],
  );

  Map<String, dynamic> toJson() => {
    'stateId': stateId,
    'salary': salary,
    'keyword': keyword,
    'education': education,
  };
}
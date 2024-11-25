class Jobs{
  final String title;
  final String postDate;
  final String vacancy;
  final String lastDate;
  final String likes;
  final String comments;

  Jobs(this.title, this.postDate, this.vacancy, this.lastDate, this.likes, this.comments);
  factory Jobs.fromJson(Map<String, dynamic> data) {
    return Jobs(
      data['title'],
      data['postDate'],
      data['vacancy'],
      data['lastDate'],
      data['likes'],
      data['comments'],
    );
  }
}
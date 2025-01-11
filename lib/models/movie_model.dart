// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieModel {
  final String title;
  final String imageurl;
  final String summary;
  final String language;
  final String type;
  final String status;

  MovieModel({
    required this.title,
    required this.imageurl,
    required this.summary,
    required this.language,
    required this.type,
    required this.status,
  });

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
      title: map['show']['name'],
      imageurl: map['show']['image']?['original'] ?? '',
      summary: map['show']['summary'],
      language: map['show']['language'] ?? 'English',
      type: map['show']['type'] ?? '',
      status: map['show']['status'] ?? 'Running',
    );
  }
}

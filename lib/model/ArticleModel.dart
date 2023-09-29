import 'dart:convert';

class ArticleModel {
  String? id; // Makale ID'si
  String title;
  String detail;
  String articleImage;
  int categoryId;
  String userId;
  int? readCount = 0;
  String date;
  String readTime;
  int? likesCount;
  String?source;

  ArticleModel({
     this.id,
    required this.title,
    required this.detail,
    required this.articleImage,
    required this.categoryId,
    required this.userId,
    this.readCount,
    required this.date,
    required this.readTime,
    this.likesCount,
     this.source,
  });



  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'detail': detail});
    result.addAll({'articleImage': articleImage});
    result.addAll({'categoryId': categoryId});
    result.addAll({'userId': userId});
    if(readCount != null){
      result.addAll({'readCount': readCount});
    }
    result.addAll({'date': date});
    result.addAll({'readTime': readTime});
    if(likesCount != null){
      result.addAll({'likesCount': likesCount});
    }
    result.addAll({'source': source});
  
    return result;
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      detail: map['detail'] ?? '',
      articleImage: map['articleImage'] ?? '',
      categoryId: map['categoryId']?.toInt() ?? 0,
      userId: map['userId'] ?? '',
      readCount: map['readCount']?.toInt(),
      date: map['date'] ?? '',
      readTime: map['readTime'] ?? '',
      likesCount: map['likesCount']?.toInt(),
      source: map['source'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) => ArticleModel.fromMap(json.decode(source));
}

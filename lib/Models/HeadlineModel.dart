class HeadlineModel {
  late String status;
  late List<HeadlineData> articles;
  HeadlineModel(this.status, this.articles);
  HeadlineModel.fromJson(Map<String, dynamic> map) {
    status = map['status'];
    articles = [];
    if (map['articles'] != null && map['articles'] != []) {
      map['articles'].forEach((e) {
        articles.add(HeadlineData.fromJson(e));
      });
    }
  }
}

class HeadlineData {
  Map<String, String?>? source;
  String? author;
  String? title;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  HeadlineData(this.source, this.author, this.title, this.url, this.urlToImage,
      this.publishedAt, this.content);
  HeadlineData.fromJson(Map<String, dynamic> map) {
    source = {};
    source!['id'] = map['source']['id'];
    source!['name'] = map['source']['name'];
    author = map['author'];
    title = map['title'];
    url = map['url'];
    urlToImage = map['urlToImage'];
    publishedAt = map['publishedAt'];
    content = map['content'];
  }
  toJson() {
    return {
      'source': {"id": source!["id"], "name": source!["name"]},
      'author': author,
      'title': title,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content
    };
  }
}

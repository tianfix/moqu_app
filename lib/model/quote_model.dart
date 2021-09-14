class QuoteModel {
  
  final String text;
  final String author;

  QuoteModel({this.text, this.author});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      text: json['text'],
      author: json['author']
    );
  }
}
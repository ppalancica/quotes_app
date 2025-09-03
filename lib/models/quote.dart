class Quote {
  final int id;
  final String quote;
  final String author;
  bool isFavorite;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
    this.isFavorite = false,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      quote: json['quote'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'quote': quote,
    'author': author,
    'isFavorite': isFavorite,
  };
}
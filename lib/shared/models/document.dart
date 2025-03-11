class Document {
  final String name;
  final String? url;

  const Document({required this.name, this.url});

  factory Document.fromFirestore(Map<String, dynamic>? data) {
    return Document(name: data?["name"], url: data?["url"]);
  }

  static Map<String, Object?> toFirestore(Document document) {
    return {"name": document.name, "url": document.url};
  }
}

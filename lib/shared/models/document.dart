class Document {
  final String name;
  final String? url;

  const Document({required this.name, this.url});

  static Map<String, Object?> toFirestore(Document document) {
    return {"name": document.name, "url": document.url};
  }
}

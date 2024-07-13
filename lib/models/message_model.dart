class Message {
  final String text;
  final String sender;
  final String imageUrl;

  Message({required this.text, required this.sender, this.imageUrl = ''});
}
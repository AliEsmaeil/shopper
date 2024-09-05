class Faq {
  int id;
  String question;
  String answer;

  Faq({required this.id, required this.answer, required this.question});
  Faq.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answer = json['answer'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'answer': answer,
      };
}

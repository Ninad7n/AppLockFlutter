import 'dart:convert';

SavedQaModel saveQaModelFromJson(String str) =>
    SavedQaModel.fromJson(json.decode(str));

String saveQaModelToJson(SavedQaModel data) => json.encode(data.toJson());

class SavedQaModel {
  SavedQaModel({
    this.question,
    this.answer,
  });

  String? question;
  String? answer;

  factory SavedQaModel.fromJson(Map<String, dynamic> json) => SavedQaModel(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}

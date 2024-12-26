import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResults = false;
  List<int> answers =
      List.filled(4, 0); // Table des réponses (0 => non correct, 1 => correct)

  final List<Map<String, dynamic>> questions = [
    {
      "text":
          "Quel widget Flutter est utilisé pour créer une interface utilisateur réactive qui peut changer en fonction de l'état de l'application ?",
      "options": [
        "StatelessWidget",
        "StatefulWidget",
        "InheritedWidget",
        "BuildContext"
      ],
      "answer": "StatefulWidget",
      "imageUrl": "assets/images/quiz_image_1.png"
    },
    {
      "text":
          "Quel package Flutter est couramment utilisé pour la gestion des états dans une application Flutter ?",
      "options": ["Provider", "Flutter Bloc", "Riverpod", "All of the above"],
      "answer": "All of the above",
      "imageUrl": "assets/images/quiz_image_2.png"
    },
    {
      "text":
          "Quel est le but principal de la méthode `initState()` dans un StatefulWidget ?",
      "options": [
        "Construire le widget",
        "Initialiser les variables d'état",
        "Mettre à jour l'interface utilisateur",
        "Gérer les événements"
      ],
      "answer": "Initialiser les variables d'état",
      "imageUrl": "assets/images/quiz_image_3.png"
    },
    {
      "text":
          "Quel widget Flutter est utilisé pour afficher une liste défilante d'éléments ?",
      "options": ["Column", "Row", "ListView", "GridView"],
      "answer": "ListView",
      "imageUrl": "assets/images/quiz_image_4.png"
    }
  ];

  void handleAnswerOptionClick(String option) {
    setState(() {
      if (option == questions[currentQuestionIndex]['answer']) {
        answers[currentQuestionIndex] = 1; // Marquer la réponse comme correcte
      } else {
        answers[currentQuestionIndex] =
            0; // Marquer la réponse comme incorrecte
      }
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        showResults = true;
        calculateScore();
      }
    });
  }

  void goBack() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  void skipQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        showResults = true;
        calculateScore();
      }
    });
  }

  void calculateScore() {
    setState(() {
      score = answers.reduce((a, b) =>
          a + b); // Calculer le score en sommant les réponses correctes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showResults
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quiz terminé !',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Votre score est $score sur ${questions.length}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentQuestionIndex = 0;
                          score = 0;
                          showResults = false;
                          answers = List.filled(
                              4, 0); // Réinitialiser la table des réponses
                        });
                      },
                      child: Text('Recommencer le quiz'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Couleur pour recommencer
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    questions[currentQuestionIndex]['imageUrl'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Text(
                    questions[currentQuestionIndex]['text'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ...questions[currentQuestionIndex]['options'].map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () => handleAnswerOptionClick(option),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          option,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: currentQuestionIndex > 0 ? goBack : null,
                        child: Text('Précédent'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange, // Couleur pour précédent
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: skipQuestion,
                        child: Text('Ignorer'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey, // Couleur pour ignorer
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

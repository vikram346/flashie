import 'package:flashie/services/auth.dart';
import 'package:flutter/material.dart';

// import 'dummy_data/card_ddetails.dart';

class CardPage extends StatefulWidget {
  const new({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  bool new_card = false;
  bool loaded = false;
  String? topicTitle;
  int? topicId;
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  List<dynamic> card = [];
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(!loaded){
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    topicId = args['id'] as int;
    topicTitle = args['title'] as String;}
    loaded = true;
    loadcards();

  }

  Future<void> loadcards() async {
    try {
      final result = await AuthService.fetchcards(set_id: topicId!);
      // debugPrint("Fetched sets: $result");
      if (!mounted) return;
      setState(() {
        card = result;
      });
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      // backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text(
          topicTitle!,
          style: TextStyle(color: Colors.white),
          maxLines: 1,
        ),
        backgroundColor: Colors.black26,
      ),
      body: Column(
        children: [
          card.isEmpty? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 90),
                      child: Center(child: const Text("No Card found", style: TextStyle(color: Colors.white, fontSize: 26),),),
                    ):
          // Padding(padding: EdgeInsetsGeometry.only(left: 62)),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: card.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                // childAspectRatio: 1,
                // mainAxisExtent: 250
              ),
              itemBuilder: (context, index) {
                final cards = card[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      new_card = false;
                    });
                    Navigator.pushNamed(
                      context,
                      "/details",
                      arguments: {
                        "question": cards["question"],
                        "answer": cards["answer"],
                      },
                    );
                  },
                  child: GestureDetector(
                    onLongPress: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete card?"),
                            content: const Text(
                              "Are you Sure you want to delete card?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirm != true) return;
                      try {
                        await AuthService.deleteCard(id: cards["id"]);
                        await loadcards();
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Card deleted successfully"),
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 75, 75, 75),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${cards['question']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${cards['answer']}",
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (new_card)
            Container(
              width: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  TextField(
                    controller: questionController,
                    decoration: InputDecoration(
                      focusColor: Colors.white30,
                      labelText: "Set Question",
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.blueGrey,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: answerController,
                    decoration: InputDecoration(
                      focusColor: Colors.white30,
                      labelText: "Set Answer",
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.blueGrey,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (!new_card) {
            setState(() {
              new_card = true;
            });
            return;
          }
          final question = questionController.text.trim();
          final answer = answerController.text.trim();
          if (question.isEmpty || answer.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "fill the required field",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
            return;
          }
          try {
            await AuthService.addCard(
              question: question,
              answer: answer,
              set_id: topicId!
            );
            if (!mounted) return;
            questionController.clear();
            answerController.clear();
            setState(() {
              new_card = false;
            });
            await loadcards();
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Card added succefully",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  e.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
        backgroundColor: Colors.blueAccent,
        label: Text(
          new_card ? "Submit" : "Add New Card",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

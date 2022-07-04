import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:foodolist/models/footer_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          title: SvgPicture.asset(
            "assets/logo.svg",
            semanticsLabel: "Le logo de l'application Foodlolist",
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton(
                  onPressed: null,
                  child: Text("Nouvelle recette",
                      style: Theme.of(context).textTheme.button)),
            )
          ],
        ),
        backgroundColor: const Color(0xFFFFF4DB),
        body: const RecipesInformations(),
        bottomNavigationBar: const FooterBar());
  }
}

String _createTagsString(List tags) {
  var textTag = "";

  for (var i = 0; i < tags.length; i++) {
    textTag += tags[i];

    if (i != (tags.length - 1)) {
      textTag += " - ";
    }
  }
  return textTag;
}

class RecipesInformations extends StatefulWidget {
  const RecipesInformations({Key? key}) : super(key: key);

  @override
  State<RecipesInformations> createState() => _RecipesInformationsState();
}

class _RecipesInformationsState extends State<RecipesInformations> {
  final Stream<QuerySnapshot> _recipesStream =
      FirebaseFirestore.instance.collection("recipes").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _recipesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Chargement recettes");
        }

        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            List tags = List.from(document["tags"]);

            return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF011200)),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                margin: const EdgeInsets.only(
                    bottom: 32, left: 16, right: 16, top: 8),
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["title"],
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Row(children: [
                          Expanded(
                              child: Text(
                            _createTagsString(tags),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ))
                        ])
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Voir le détail",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ))
                  ],
                ));
          }).toList(),
        );
      },
    );
  }
}

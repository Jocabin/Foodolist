import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class FooterBar extends StatelessWidget {
  const FooterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Créée par",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF011200)),
          ),
          TextButton(
            onPressed: () async {
              if (!await launchUrl(Uri.parse("https://github.com/Jocabin"),
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch';
              }
            },
            child: Text("Jocabin", style: Theme.of(context).textTheme.button),
          ),
        ],
      ),
    );
  }
}

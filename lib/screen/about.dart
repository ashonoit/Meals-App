import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Text(
              'Created with ❤️ by Ayush',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              'Contact us:',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Icon(
                    FontAwesomeIcons.instagram,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () => launchUrlString(
                      'https://www.instagram.com/ashonoit/?hl=en'),
                ),
                const SizedBox(width: 6),
                InkWell(
                  child: Icon(
                    FontAwesomeIcons.linkedin,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () => launchUrlString(
                      'https://www.linkedin.com/in/ayush-tomar-591866259'),
                ),
                const SizedBox(width: 6),
                InkWell(
                  child: Icon(
                    FontAwesomeIcons.github,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () => launchUrlString('https://github.com/ashonoit'),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              'Version 1.0',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

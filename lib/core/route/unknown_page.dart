import 'package:flutter/material.dart';
import 'package:handheld_beta/core/components/app_back_button.dart';
import 'package:handheld_beta/core/components/network_image.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Unknown Page'),
      ),
      body: Column(
        children: [
          const Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.all(12), //AppDefaults.padding
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const AspectRatio(
                aspectRatio: 1 / 1,
                child: NetworkImageWithLoader(
                  'https://i.imgur.com/mVeoFh5.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12), //AppDefaults.padding
            child: Column(
              children: [
                Text(
                  'oppss!! something wrong',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12, ////AppDefaults.padding
                  ),
                  child: Text(
                    'Sorry, something went wrong\nplease try again .',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12 * 2), ////AppDefaults.padding
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Try Again'),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

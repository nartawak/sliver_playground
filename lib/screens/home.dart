import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_playground/screens/apple_tv_detail/apple_tv_detail_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 500,
          child: ListView(
            children: [
              ListTile(
                title: const Text('Go to Apple TV detail'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AppleTvDetailScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

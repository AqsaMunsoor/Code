import 'package:flutter/material.dart';

import 'disease_screen.dart';

class AlopethicScreen extends StatelessWidget {
  const AlopethicScreen({super.key});

  get disease => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alopethic Medicine'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                if (disease == DiseaseType.Alopecia)
                  const ListTile(
                    title: Text('Alopecia'),
                    subtitle: Text('Description of alopecia'),
                  ),
                const ListTile(
                  title: Text('Alopecia 2'),
                  subtitle: Text('Description of alopecia 2'),
                ),
                const ListTile(
                  title: Text('Alopecia 3'),
                  subtitle: Text('Description of alopecia 3'),
                ),
                if (disease == DiseaseType.Dandruff)
                  const ListTile(
                    title: Text('Dandruff'),
                    subtitle: Text('Description of Dandrufff'),
                  ),
                const ListTile(
                  title: Text('Dandruff 2'),
                  subtitle: Text('Description of Dandrufff 2'),
                ),
                const ListTile(
                  title: Text('Dandruff 3'),
                  subtitle: Text('Description of Dandrufff 3'),
                ),
                if (disease == DiseaseType.Seborrheic)
                  const ListTile(
                    title: Text('Seborrheic'),
                    subtitle: Text('Description of Seborrheic'),
                  ),
                const ListTile(
                  title: Text('Seborrheic 2'),
                  subtitle: Text('Description of Seborrheic 2'),
                ),
                const ListTile(
                  title: Text('Seborrheic 3'),
                  subtitle: Text('Description of Seborrheic 3'),
                ),
                if (disease == DiseaseType.Folliculitis)
                  const ListTile(
                    title: Text('Folliculitis'),
                    subtitle: Text('Description of Folliculitis'),
                  ),
                const ListTile(
                  title: Text('Folliculitis 2'),
                  subtitle: Text('Description of Folliculitis 2'),
                ),
                const ListTile(
                  title: Text('Folliculitis 3'),
                  subtitle: Text('Description of Folliculitis 3'),
                ),
                if (disease != DiseaseType.Alopecia &&
                    disease != DiseaseType.Dandruff &&
                    disease != DiseaseType.Seborrheic &&
                    disease != DiseaseType.Folliculitis)
                  const ListTile(
                    title: Text('Healthy'),
                    subtitle: Text('Description of Healthy'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: AlopethicScreen(),
    ),
  );
}

import 'package:flutter/material.dart';

import 'disease_screen.dart';

class AlopethicScreen extends StatelessWidget {
  const AlopethicScreen({super.key});

  get disease => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alopethic Medicine'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                if (disease == DiseaseType.Alopecia)
                  ListTile(
                    title: Text('Alopecia'),
                    subtitle: Text('Description of alopecia'),
                  ),
                ListTile(
                  title: Text('Alopecia 2'),
                  subtitle: Text('Description of alopecia 2'),
                ),
                ListTile(
                  title: Text('Alopecia 3'),
                  subtitle: Text('Description of alopecia 3'),
                ),
                if (disease == DiseaseType.Dandruff)
                  ListTile(
                    title: Text('Dandruff'),
                    subtitle: Text('Description of Dandrufff'),
                  ),
                ListTile(
                  title: Text('Dandruff 2'),
                  subtitle: Text('Description of Dandrufff 2'),
                ),
                ListTile(
                  title: Text('Dandruff 3'),
                  subtitle: Text('Description of Dandrufff 3'),
                ),
                if (disease == DiseaseType.Seborrheic)
                  ListTile(
                    title: Text('Seborrheic'),
                    subtitle: Text('Description of Seborrheic'),
                  ),
                ListTile(
                  title: Text('Seborrheic 2'),
                  subtitle: Text('Description of Seborrheic 2'),
                ),
                ListTile(
                  title: Text('Seborrheic 3'),
                  subtitle: Text('Description of Seborrheic 3'),
                ),
                if (disease == DiseaseType.Folliculitis)
                  ListTile(
                    title: Text('Folliculitis'),
                    subtitle: Text('Description of Folliculitis'),
                  ),
                ListTile(
                  title: Text('Folliculitis 2'),
                  subtitle: Text('Description of Folliculitis 2'),
                ),
                ListTile(
                  title: Text('Folliculitis 3'),
                  subtitle: Text('Description of Folliculitis 3'),
                ),
                if (disease != DiseaseType.Alopecia &&
                    disease != DiseaseType.Dandruff &&
                    disease != DiseaseType.Seborrheic &&
                    disease != DiseaseType.Folliculitis)
                  ListTile(
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
    MaterialApp(
      home: AlopethicScreen(),
    ),
  );
}
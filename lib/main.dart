import 'package:avatars/consts.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'dart:math'; // Import for Random class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String faceShape = AppAssets.faceShape1;
  String hairStyle = ""; // Default to empty
  String eyesShape = AppAssets.eyeShape1;
  String mouthShape = AppAssets.mouthShape1;
  String noseShape = AppAssets.noseShape1;
  String earShape = AppAssets.ear1;
  String beardShape = ""; // Default to empty
  String glasses = ""; // Default to empty
  String accessorie = ""; // Default to empty

  String selectedShape = "Face";
  final List<String> avatarShapes = [
    "Face",
    "Hair",
    "Beard",
    "Eyes",
    "Glasses",
    "Accessorie",
    "Mouth",
    "Nose",
    "Ears",
  ];

  final Random _random = Random(); // Random number generator

  // Function to generate a random avatar
  void generateRandomAvatar() {
    setState(() {
      faceShape = _getRandomItem(AppAssets.faceShapes);
      hairStyle = _getRandomItem([""] + AppAssets.hairStyles);
      eyesShape = _getRandomItem(AppAssets.eyeShapes);
      mouthShape = _getRandomItem(AppAssets.mouthShapes);
      noseShape = _getRandomItem(AppAssets.noseShapes);
      earShape = _getRandomItem(AppAssets.ears);
      beardShape = _getRandomItem([""] + AppAssets.beards);
      glasses = _getRandomItem([""] + AppAssets.glasses);
      accessorie = _getRandomItem([""] + AppAssets.accessories);
    });
  }

  // Helper function to pick a random item from a list
  String _getRandomItem(List<String> items) {
    return items[_random.nextInt(items.length)];
  }

  Widget _buildAvatarPart(String asset,
      {double? width, double? height, AlignmentGeometry? alignment}) {
    if (asset.isEmpty) {
      return const SizedBox
          .shrink(); // Return an empty widget if the asset is empty
    }
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: SvgPicture.asset(
          asset,
          fit: BoxFit.fitWidth,
          alignment: alignment ?? Alignment.center,
        ),
      ),
    );
  }

  Widget _buildSelectionList(List<String> items, String selectedItem,
      Function(String) onItemSelected) {
    // Add an empty option to the list of items
    final List<String> itemsWithEmpty = [""] + items;

    return Container(
      height: 100,
      color: Colors.grey.shade300,
      child: ListView.separated(
        itemCount: itemsWithEmpty.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemBuilder: (context, index) {
          final item = itemsWithEmpty[index];
          return Center(
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color:
                      selectedItem == item ? Colors.black : Colors.transparent,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () => onItemSelected(item),
                child: Center(
                  child: item.isEmpty
                      ? const Icon(Icons.close,
                          size: 30) // Show an icon for the empty option
                      : SvgPicture.asset(item),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Avatar Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: generateRandomAvatar, // Call the random avatar function
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(height: 25),
          Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildAvatarPart(faceShape,
                    width: 155, alignment: Alignment.bottomCenter),
                Positioned(
                    top: 14,
                    left: 84,
                    child:
                        _buildAvatarPart(hairStyle, width: 180, height: 200)),
                Positioned(
                    top: 100,
                    left: 100,
                    child:
                        _buildAvatarPart(eyesShape, width: 150, height: 150)),
                Positioned(
                    top: 185,
                    left: 100,
                    child:
                        _buildAvatarPart(mouthShape, width: 150, height: 150)),
                Positioned(
                    top: 120,
                    left: 100,
                    child:
                        _buildAvatarPart(noseShape, width: 150, height: 150)),
                Positioned(
                    top: 100,
                    left: 72.5,
                    child: _buildAvatarPart(earShape, width: 205, height: 150)),
                Positioned(
                    top: 105,
                    left: 95,
                    child: _buildAvatarPart(glasses, width: 160, height: 150)),
                Positioned(
                    top: 200,
                    left: 105,
                    child:
                        _buildAvatarPart(beardShape, width: 140, height: 150)),
                Positioned(
                    top: 5,
                    left: 100,
                    child: _buildAvatarPart(accessorie, width: 150)),
              ],
            ),
          ),
          Column(
            children: [
              Visibility(
                visible: selectedShape == "Face",
                child: _buildSelectionList(AppAssets.faceShapes, faceShape,
                    (item) => setState(() => faceShape = item)),
              ),
              Visibility(
                visible: selectedShape == "Hair",
                child: _buildSelectionList(AppAssets.hairStyles, hairStyle,
                    (item) => setState(() => hairStyle = item)),
              ),
              Visibility(
                visible: selectedShape == "Eyes",
                child: _buildSelectionList(AppAssets.eyeShapes, eyesShape,
                    (item) => setState(() => eyesShape = item)),
              ),
              Visibility(
                visible: selectedShape == "Mouth",
                child: _buildSelectionList(AppAssets.mouthShapes, mouthShape,
                    (item) => setState(() => mouthShape = item)),
              ),
              Visibility(
                visible: selectedShape == "Nose",
                child: _buildSelectionList(AppAssets.noseShapes, noseShape,
                    (item) => setState(() => noseShape = item)),
              ),
              Visibility(
                visible: selectedShape == "Ears",
                child: _buildSelectionList(AppAssets.ears, earShape,
                    (item) => setState(() => earShape = item)),
              ),
              Visibility(
                visible: selectedShape == "Beard",
                child: _buildSelectionList(AppAssets.beards, beardShape,
                    (item) => setState(() => beardShape = item)),
              ),
              Visibility(
                visible: selectedShape == "Glasses",
                child: _buildSelectionList(AppAssets.glasses, glasses,
                    (item) => setState(() => glasses = item)),
              ),
              Visibility(
                visible: selectedShape == "Accessorie",
                child: _buildSelectionList(AppAssets.accessories, accessorie,
                    (item) => setState(() => accessorie = item)),
              ),
              const SizedBox(height: 5),
              Container(
                height: 50,
                color: Colors.grey.shade300,
                child: ListView.separated(
                  itemCount: avatarShapes.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                  itemBuilder: (context, index) {
                    return Center(
                      child: InkWell(
                        onTap: () =>
                            setState(() => selectedShape = avatarShapes[index]),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: selectedShape == avatarShapes[index]
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(avatarShapes[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

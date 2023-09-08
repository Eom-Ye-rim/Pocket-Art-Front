import 'dart:io';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ManipulationPage(),
    );
  }
}

class ManipulationPage extends StatefulWidget {
  @override
  _ManipulationPageState createState() => _ManipulationPageState();
}

class _ManipulationPageState extends State<ManipulationPage> {
  ARKitController? arkitController;
  ARKitNode? imageNode;
  ARKitNode? textNode;
  bool isDragging = false;
  Vector3? lastPosition;
  List<ARKitNode> addedNodes = [];
  List<File> pickedImages = [];
  double scale = 1.0;
  double previousScale = 1.0;
  bool isSphere = false;
  List<String> predefinedImages = [
    'images/gogh1.jpeg',
    'images/gogh2.jpeg',
    'images/gogh3.jpeg',
    'images/gogh4.jpeg',
    'images/gogh5.jpeg',
    'images/star.jpeg',
  ];

  List<String> predefinedImages2 = [
    'images/ko1.jpeg',
    'images/ko2.jpeg',
    'images/ko3.jpeg',
    'images/ko4.jpeg',
    'images/ko5.jpeg',
    'images/ko6.jpeg',
  ];

  bool showButtons = false;

  void _showButtons() {
    setState(() {
      showButtons = true;
    });
  }

  void _hideButtons() {
    setState(() {
      showButtons = false;
    });
  }

  void _toggleButtons() {
    setState(() {
      showButtons = !showButtons;
    });
  }

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            child: GestureDetector(
              onTap: () {
                _hideButtons();
              },
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              child: ARKitSceneView(
                onARKitViewCreated: _onARKitViewCreated,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _toggleButtons();
              _showPredefinedImages();
            },
            child: Icon(Icons.photo),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              _toggleShape();
              // Handle the shape toggle button click
            },
            child: Icon(Icons.transform),
          ),
        ],
      ),
    );
  }

  void _onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    addNode();
  }

  void addNode() {
    final defaultImage = AssetImage('images/star.jpeg');

    final defaultMaterial = ARKitMaterial(
      diffuse: ARKitMaterialImage(defaultImage.assetName),
      doubleSided: true,
    );

    final defaultGeometry = ARKitPlane(
      width: 0.5,
      height: 0.5,
      materials: [defaultMaterial],
    );

    final defaultNode = ARKitNode(
      geometry: defaultGeometry,
      position: Vector3(0, 0, -0.7),
    );
    arkitController?.add(defaultNode);
    imageNode = defaultNode;
    addedNodes.add(defaultNode);
  }

  void _onPanStart(DragStartDetails details) {
    if (imageNode != null) {
      isDragging = true;
      lastPosition = imageNode!.position;
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (isDragging && imageNode != null) {
      final currentPosition = imageNode!.position;
      final newPosition = vector.Vector3(
        currentPosition.x + details.delta.dx / 1000,
        currentPosition.y - details.delta.dy / 1000,
        currentPosition.z,
      );

      imageNode!.position = newPosition;

      // Update position for newly added images
      for (final node in addedNodes) {
        if (node != imageNode && node.geometry is ARKitPlane) {
          final nodePosition = node.position;
          final newNodePosition = vector.Vector3(
            nodePosition.x - details.delta.dx / 1000,
            nodePosition.y + details.delta.dy / 1000,
            nodePosition.z,
          );

          node.position = newNodePosition;
        }
      }
    }
  }

  void _showPredefinedImages() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final int imagesPerPage = 9;
        final int pageCount = (predefinedImages.length / imagesPerPage).ceil();

        return Container(
          height: 300, // Increase the height of the container
          decoration: ShapeDecoration(
            color: Color(0x33EEEEEE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      // Handle 동양풍 button click
                    },
                    backgroundColor: Color(0x4D000000),
                    child: Text(
                      '동양풍',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(width: 40),
                  FloatingActionButton(
                    onPressed: () {
                      // Handle 서양풍 button click
                    },
                    backgroundColor: Color(0x4D000000),
                    child: Text(
                      '서양풍',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(width: 40),
                  FloatingActionButton(
                    onPressed: () {
                      // Handle 앨범 button click
                    },
                    backgroundColor: Color(0x4D000000),
                    child: Text(
                      '앨범',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ClipRRect(
                  child: PageView.builder(
                    itemCount: pageCount,
                    itemBuilder: (context, pageIndex) {
                      final startIndex = pageIndex * imagesPerPage;
                      final endIndex = (startIndex + imagesPerPage) < predefinedImages.length
                          ? (startIndex + imagesPerPage)
                          : predefinedImages.length;
                      final pageImages = predefinedImages.sublist(startIndex, endIndex);

                      return Container(
                        color: Color(0x0),//백그라운드
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: GridView.count(
                          crossAxisCount: 3,
                          padding: EdgeInsets.all(8),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 42,
                          children: List.generate(pageImages.length, (index) {
                            final imagePath = pageImages[index];
                            final caption = _getCaptionForImagePath(imagePath);
                            return GestureDetector(
                              onTap: () {
                                _addImageNode(imagePath);
                                Navigator.pop(context);
                              },
                              child: GridTile(
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.0,
                                      child: Image.asset(
                                        imagePath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      caption,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> _showUserPhotoAlbum() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _addImageNode(pickedImage.path);
    }
  }

  void _addImageNode(String imagePath) {
    // Remove previous image node and text node if they exist
    if (imageNode != null) {
      arkitController?.remove(imageNode!.name);
      addedNodes.remove(imageNode);
    }

    final imageNodePosition = imageNode?.position ?? vector.Vector3.zero();
    final material = ARKitMaterial(
      diffuse: ARKitMaterialImage(imagePath),
      doubleSided: true,
    );

    final geometry = isSphere
        ? ARKitSphere(radius: 0.15, materials: [material])
        : ARKitPlane(width: 0.5, height: 0.5, materials: [material]);

    final node = ARKitNode(
      geometry: geometry,
      position: imageNodePosition + vector.Vector3(0.5, 0, 0),
    );

    arkitController?.add(node);
    imageNode = node;
    addedNodes.add(node);

    // Add text node
    final textGeometry = ARKitText(
      text: '', // Customize the text content as desired
      extrusionDepth: 1,
      materials: [ARKitMaterial(
        diffuse: ARKitMaterialColor(Color(0xffb3b3b3)),
      )],
    );

    final textNodePosition = imageNode!.position + vector.Vector3(0, -0.15, 0); // Adjust the position of the text node relative to the image node
    final textNode = ARKitNode(
      geometry: textGeometry,
      position: textNodePosition,
      eulerAngles: vector.Vector3.zero(),
    );

    arkitController?.add(textNode);
    addedNodes.add(textNode);
  }

  void _toggleShape() {
    setState(() {
      isSphere = !isSphere;
      if (imageNode != null) {
        final imagePath = (imageNode?.geometry?.materials.value?.first?.diffuse as ARKitMaterialImage?)?.image;
        final material = ARKitMaterial(
          diffuse: ARKitMaterialImage(imagePath ?? ''),
          doubleSided: true,
        );

        final geometry = isSphere
            ? ARKitSphere(radius: 0.25, materials: [material])
            : ARKitPlane(width: 0.5, height: 0.5, materials: [material]);

        final newNode = ARKitNode(
          geometry: geometry,
          position: imageNode!.position,
        );

        for (final node in addedNodes) {
          arkitController?.remove(node.name);
        }
        addedNodes.clear();

        arkitController?.remove(imageNode!.name);
        arkitController?.add(newNode);
        imageNode = newNode;
        addedNodes.add(newNode);
      }
    });
  }

  String _getCaptionForImagePath(String imagePath) {
    // You can implement logic to retrieve captions based on image paths here
    // For now, let's use a simple approach by extracting the filename without extension as the caption
    final filename = imagePath.split('/').last;
    final caption = filename.split('.').first;
    return caption;
  }
}
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_ar_example/main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:arkit_plugin/arkit_plugin.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;
// import 'package:flutter/material.dart';
//
// class SecondRoute extends StatelessWidget {
//   const SecondRoute({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: ManipulationPage(),
//     );
//   }
// }
//
//
//
// class ManipulationPage extends StatefulWidget {
//   @override
//   _ManipulationPageState createState() => _ManipulationPageState();
// }
//
// class _ManipulationPageState extends State<ManipulationPage> {
//   ARKitController? arkitController;
//   ARKitNode? imageNode;
//   bool isDragging = false;
//   vector.Vector3? lastPosition;
//   List<ARKitNode> addedNodes = [];
//
//   List<File> pickedImages = [];
//
//   @override
//   void dispose() {
//     arkitController?.dispose();
//     super.dispose();
//   }
//
//   //context:  지금 위젯이 누구인지 알려줌
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Manipulation Sample'),
//       leading: IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const FirstRoute()),);
//       },),),
//       body: Container(
//         child: GestureDetector(
//           onPanStart: _onPanStart,
//           onPanUpdate: _onPanUpdate,
//           onPanEnd: _onPanEnd,
//           child: ARKitSceneView(
//             onARKitViewCreated: _onARKitViewCreated,
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _pickImagesFromGallery,
//         child: Icon(Icons.photo),
//       ),
//     );
//   }
//
//   void _onARKitViewCreated(ARKitController arkitController) {
//     this.arkitController = arkitController;
//     addNode();
//   }
//
//   void addNode() {
//     final defaultImage = AssetImage('images/italy.jpeg');
//
//     final defaultMaterial = ARKitMaterial(
//       diffuse: ARKitMaterialImage(defaultImage.assetName),
//       doubleSided: true,
//     );
//
//     final defaultGeometry = ARKitSphere(
//       radius: 0.1,
//       materials: [defaultMaterial],
//     );
//
//     final defaultNode = ARKitNode(
//       geometry: defaultGeometry,
//       position: vector.Vector3(0, 0, -0.5),
//     );
//
//     arkitController?.add(defaultNode);
//     imageNode = defaultNode;
//     addedNodes.add(defaultNode);
//   }
//
//   void _onPanStart(DragStartDetails details) {
//     if (imageNode != null) {
//       isDragging = true;
//       lastPosition = imageNode!.position;
//     }
//   }
//
//   void _onPanUpdate(DragUpdateDetails details) {
//     if (isDragging && imageNode != null) {
//       final currentPosition = imageNode!.position;
//       final newPosition = vector.Vector3(
//         currentPosition.x + details.delta.dx / 1000,
//         currentPosition.y - details.delta.dy / 1000,
//         currentPosition.z,
//       );
//
//       imageNode!.position = newPosition;
//
//       // Update position for newly added images
//       for (final node in addedNodes) {
//         if (node != imageNode && node.geometry is ARKitSphere) {
//           final nodePosition = node.position;
//           final newNodePosition = vector.Vector3(
//             nodePosition.x - details.delta.dx / 1000,  // Reverse the direction of movement
//             nodePosition.y + details.delta.dy / 1000,  // Reverse the direction of movement
//             nodePosition.z,
//           );
//
//           node.position = newNodePosition;
//         }
//       }
//     }
//   }
//
//
//   void _onPanEnd(DragEndDetails details) {
//     isDragging = false;
//     lastPosition = null;
//   }
//
//   Future<void> _pickImagesFromGallery() async {
//     final picker = ImagePicker();
//     final pickedFiles = await picker.pickMultiImage();
//
//     if (pickedFiles != null) {
//       setState(() {
//         pickedImages =
//             pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
//       });
//
//       for (final imageFile in pickedImages) {
//         final imageNodePosition = imageNode?.position ?? vector.Vector3.zero();
//         final material = ARKitMaterial(
//           diffuse: ARKitMaterialImage(imageFile.path),
//           doubleSided: true,
//         );
//
//         final geometry = ARKitSphere(
//           radius: 0.1,
//           materials: [material],
//         );
//
//         final node = ARKitNode(
//           geometry: geometry,
//           position: imageNodePosition + vector.Vector3(0.2, 0, 0),
//         );
//
//         arkitController?.add(node);
//         addedNodes.add(node);
//       }
//     }
//   }
// }



//
//
// // class MyHomePage extends StatefulWidget {
// //    MyHomePage({Key?key, required this.title}):super(key: key);
// //
// //   // This widget is the home page of your application. It is stateful, meaning
// //   // that it has a State object (defined below) that contains fields that affect
// //   // how it looks.
// //
// //   // This class is the configuration for the state. It holds the values (in this
// //   // case the title) provided by the parent (in this case the App widget) and
// //   // used by the build method of the State. Fields in a Widget subclass are
// //   // always marked "final".
// //
// //   final String title;
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(title: Text(widget.title)),
// //         body: ARKitSceneView(
// //           onARKitViewCreated: (controller) => arView(controller),)
// //     );
// //   }
// // }
// //
// // void arView(ARKitController controller){
// //
// //       final nodeAr = ARKitNode(
// //         geometry: ARKitSphere(
// //             materials: [
// //               ARKitMaterial(
// //                   diffuse:ARKitMaterialProperty.image("images/change.png"),
// //                   doubleSided: true,
// //               ),
// //             ],
// //           radius: 1
// //         ),
// //         position: Vector3(0,0,0),
// //       );
// //       controller.add(nodeAr);
// //   }
//
// // import 'package:flutter/material.dart';
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:vector_math/vector_math_64.dart';
// //
// // void main() => runApp(MaterialApp(home: MyApp()));
// //
// // class MyApp extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }
// //
// // class _MyAppState extends State<MyApp> {
// //   late ARKitController arkitController;
// //
// //   @override
// //   void dispose() {
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //       appBar: AppBar(title: const Text('ARKit in Flutter')),
// //       body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated));
// //
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     final node = ARKitNode(
// //         geometry: ARKitSphere(radius: 0.1), position: Vector3(0, 0, -0.5));
// //     this.arkitController.add(node);
// //   }
// // }
//
//
//
//
//
// //panorama
// import 'package:arkit_plugin/arkit_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart';
//
// void main() => runApp(MaterialApp(home: PanoramaPage()));
//
// class PanoramaPage extends StatefulWidget {
//   @override
//   _PanoramaPageState createState() => _PanoramaPageState();
// }
//
// class _PanoramaPageState extends State<PanoramaPage> {
//   late ARKitController arkitController;
//
//   @override
//   void dispose() {
//     arkitController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(title: const Text('Panorama Sample')),
//     body: Container(
//       child: ARKitSceneView(
//         onARKitViewCreated: onARKitViewCreated,
//       ),
//     ),
//   );
//
//   void onARKitViewCreated(ARKitController arkitController) {
//     this.arkitController = arkitController;
//
//     final material = ARKitMaterial(
//       diffuse: ARKitMaterialProperty.image('images/museum.jpeg'),
//       doubleSided: true,
//     );
//     final sphere = ARKitSphere(
//       materials: [material],
//       radius: 1,
//     );
//
//     final node = ARKitNode(
//       geometry: sphere,
//       position: Vector3.zero(),
//       eulerAngles: Vector3.zero(),
//     );
//     this.arkitController.add(node);
//   }
// }
//

//
// //
// // import 'dart:async';
// //
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // void main() {
// //   runApp(ImageDetectionPage());
// // }
// //
// // class ImageDetectionPage extends StatefulWidget {
// //   @override
// //   _ImageDetectionPageState createState() => _ImageDetectionPageState();
// // }
// //
// // class _ImageDetectionPageState extends State<ImageDetectionPage> {
// //   late ARKitController arkitController;
// //   Timer? timer;
// //   bool anchorWasFound = false;
// //
// //   @override
// //   void dispose() {
// //     timer?.cancel();
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //     appBar: AppBar(title: const Text('Image Detection Sample')),
// //     body: Container(
// //       child: Stack(
// //         fit: StackFit.expand,
// //         children: [
// //           ARKitSceneView(
// //             detectionImagesGroupName: 'AR Resources',
// //             onARKitViewCreated: onARKitViewCreated,
// //           ),
// //           anchorWasFound
// //               ? Container()
// //               : Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Text(
// //               'Point the camera at the earth image from the article about Earth on Wikipedia.',
// //               style: Theme.of(context)
// //                   .textTheme
// //                   .headlineSmall
// //                   ?.copyWith(color: Colors.white),
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// //
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
// //   }
// //
// //   void onAnchorWasFound(ARKitAnchor anchor) {
// //     if (anchor is ARKitImageAnchor) {
// //       setState(() => anchorWasFound = true);
// //
// //       final material = ARKitMaterial(
// //         lightingModelName: ARKitLightingModel.lambert,
// //         diffuse: ARKitMaterialProperty.image('images/change.jpeg'),
// //       );
// //       final sphere = ARKitSphere(
// //         materials: [material],
// //         radius: 0.1,
// //       );
// //
// //       final earthPosition = anchor.transform.getColumn(3);
// //       final node = ARKitNode(
// //         geometry: sphere,
// //         position:
// //         vector.Vector3(earthPosition.x, earthPosition.y, earthPosition.z),
// //         eulerAngles: vector.Vector3.zero(),
// //       );
// //       arkitController.add(node);
// //
// //       timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
// //         final old = node.eulerAngles;
// //         final eulerAngles = vector.Vector3(old.x + 0.01, old.y, old.z);
// //         node.eulerAngles = eulerAngles;
// //       });
// //     }
// //   }
// // }
//
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // void main() {
// //   runApp(BodyTrackingPage());
// // }
// //
// // class BodyTrackingPage extends StatefulWidget {
// //   @override
// //   _BodyTrackingPageState createState() => _BodyTrackingPageState();
// // }
// //
// // class _BodyTrackingPageState extends State<BodyTrackingPage> {
// //   late ARKitController arkitController;
// //   ARKitNode? hand;
// //
// //   @override
// //   void dispose() {
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //     appBar: AppBar(title: const Text('Body Tracking Sample')),
// //     body: ARKitSceneView(
// //       configuration: ARKitConfiguration.bodyTracking,
// //       onARKitViewCreated: onARKitViewCreated,
// //     ),
// //   );
// //
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
// //     this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
// //   }
// //
// //   void _handleAddAnchor(ARKitAnchor anchor) {
// //     if (!(anchor is ARKitBodyAnchor)) {
// //       return;
// //     }
// //     final transform =
// //     anchor.skeleton.modelTransformsFor(ARKitSkeletonJointName.leftHand);
// //     hand = _createSphere(transform!);
// //     arkitController.add(hand!, parentNodeName: anchor.nodeName);
// //   }
// //
// //   ARKitNode _createSphere(Matrix4 transform) {
// //     final position = vector.Vector3(
// //       transform.getColumn(3).x,
// //       transform.getColumn(3).y,
// //       transform.getColumn(3).z,
// //     );
// //     return ARKitReferenceNode(
// //       url: 'models.scnassets/dash.dae',
// //       scale: vector.Vector3.all(0.5),
// //       position: position,
// //     );
// //   }
// //
// //   void _handleUpdateAnchor(ARKitAnchor anchor) {
// //     if (anchor is ARKitBodyAnchor && mounted) {
// //       final transform =
// //       anchor.skeleton.modelTransformsFor(ARKitSkeletonJointName.leftHand)!;
// //       final position = vector.Vector3(
// //         transform.getColumn(3).x,
// //         transform.getColumn(3).y,
// //         transform.getColumn(3).z,
// //       );
// //       hand?.position = position;
// //     }
// //   }
// // }
//
//
// //
// // import 'dart:math' as math;
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //        home:  VideoPage(),
// //     );
// //   }
// // }
// //
// //
// // class VideoPage extends StatefulWidget {
// //   @override
// //   _VideoPageState createState() => _VideoPageState();
// // }
// //
// // class _VideoPageState extends State<VideoPage> {
// //   late ARKitController arkitController;
// //   late ARKitMaterialVideo _video;
// //   bool _isPlaying = true;
// //
// //   @override
// //   void dispose() {
// //     _video.dispose();
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //       appBar: AppBar(title: const Text('Video Sample')),
// //       body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () async {
// //           if (_isPlaying) {
// //             await _video.pause();
// //           } else {
// //             await _video.play();
// //           }
// //           setState(() => _isPlaying = !_isPlaying);
// //         },
// //         child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
// //       ));
// //
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //
// //     _video = ARKitMaterialProperty.video(
// //       width: 640,
// //       height: 320,
// //       filename: 'london.mp4',
// //     );
// //     final material = ARKitMaterial(
// //       diffuse: _video,
// //       doubleSided: true,
// //     );
// //
// //     final sphere = ARKitSphere(materials: [material], radius: 1);
// //
// //     final node = ARKitNode(geometry: sphere);
// //     node.eulerAngles = vector.Vector3(0, 0, math.pi); // rotate the node
// //
// //     this.arkitController.add(node);
// //   }
// // }
//
//
// // import 'dart:math' as math;
// // import 'package:flutter/material.dart';
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// // import 'package:collection/collection.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       debugShowCheckedModeBanner: false,
// //       home: ManipulationPage(),
// //     );
// //   }
// // }
// //
// // class ManipulationPage extends StatefulWidget {
// //   @override
// //   _ManipulationPageState createState() => _ManipulationPageState();
// // }
// //
// // class _ManipulationPageState extends State<ManipulationPage> {
// //   ARKitController? arkitController;
// //   ARKitNode? imageNode;
// //   bool isDragging = false;
// //   Offset dragStartPosition = Offset.zero;
// //   vector.Vector3? initialNodePosition;
// //
// //   @override
// //   void dispose() {
// //     arkitController?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //     appBar: AppBar(title: const Text('Manipulation Sample')),
// //     body: Container(
// //       child: ARKitSceneView(
// //         onARKitViewCreated: onARKitViewCreated,
// //         enableTapRecognizer: true,
// //         onARTap: _onTapHandler,
// //         onARTrackingState: _onARTrackingState,
// //       ),
// //     ),
// //   );
// //
// //   void onARKitViewCreated(ARKitController controller) {
// //     arkitController = controller;
// //     addNode();
// //   }
// //
// //   void addNode() async {
// //     final imageFilePath = 'assets/images/earth_texture.jpg'; // Path to the image asset
// //
// //     final material = ARKitMaterial(
// //       diffuse: ARKitMaterialProperty.image(imageFilePath),
// //     );
// //
// //     final plane = ARKitPlane(
// //       width: 0.2, // Adjust the size as needed
// //       height: 0.2, // Adjust the size as needed
// //       materials: [material],
// //     );
// //
// //     final node = ARKitNode(
// //       geometry: plane,
// //       position: vector.Vector3(0, 0, -0.5),
// //     );
// //
// //     arkitController?.add(node);
// //     imageNode = node;
// //   }
// //
// //   void _onTapHandler(List<ARKitTestResult> results) {
// //     if (results.isEmpty) return;
// //
// //     final tapResult = results.first;
// //
// //     if (tapResult.type == ARKitTestResultType.plane) {
// //       final position = tapResult.worldTransform.getColumn(3);
// //       imageNode?.position = vector.Vector3(position.x, position.y, position.z);
// //       initialNodePosition = imageNode?.position;
// //     }
// //   }
// //
// //   void _onARTrackingState(ARKitTrackingState state) {
// //     if (state == ARKitTrackingState.normal) {
// //       // Reset dragging state and position when AR tracking state is normal
// //       isDragging = false;
// //       initialNodePosition = null;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onPanStart: _onPanStart,
// //       onPanUpdate: _onPanUpdate,
// //       onPanEnd: _onPanEnd,
// //       child: Scaffold(
// //         appBar: AppBar(title: const Text('Manipulation Sample')),
// //         body: Container(
// //           child: ARKitSceneView(
// //             onARKitViewCreated: onARKitViewCreated,
// //             enableTapRecognizer: true,
// //             onARTap: _onTapHandler,
// //             onARTrackingState: _onARTrackingState,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void _onPanStart(DragStartDetails details) {
// //     final RenderBox box = context.findRenderObject() as RenderBox;
// //     final offset = box.globalToLocal(details.globalPosition);
// //     dragStartPosition = offset;
// //     if (imageNode != null) {
// //       isDragging = true;
// //     }
// //   }
// //
// //   void _onPanUpdate(DragUpdateDetails details) {
// //     if (isDragging && imageNode != null) {
// //       final RenderBox box = context.findRenderObject() as RenderBox;
// //       final offset = box.globalToLocal(details.globalPosition);
// //       final delta = offset - dragStartPosition;
// //       final translation = vector.Vector3(delta.dx, delta.dy, 0);
// //       imageNode!.position = initialNodePosition! + translation / 300;
// //     }
// //   }
// //
// //   void _onPanEnd(DragEndDetails details) {
// //     isDragging = false;
// //     initialNodePosition = imageNode?.position;
// //   }
// // }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // class ManipulationPage extends StatefulWidget {
// //   @override
// //   _ManipulationPageState createState() => _ManipulationPageState();
// // }
// //
// // class _ManipulationPageState extends State<ManipulationPage> {
// //   ARKitController? _arKitController;
// //   ARKitNode? _imageNode;
// //
// //   @override
// //   void dispose() {
// //     _arKitController?.dispose();
// //     super.dispose();
// //   }
// //
// //   void _onARKitViewCreated(ARKitController controller) {
// //     _arKitController = controller;
// //     _loadImage();
// //   }
// //
// //   void _loadImage() async {
// //     final image = await _arKitController?.referenceImagesManager.addReferenceImageFromAsset('assets/images/your_image.png');
// //
// //     if (image != null) {
// //       final material = ARKitMaterial(
// //         diffuse: ARKitMaterialProperty(
// //           image: image,
// //         ),
// //       );
// //
// //       final geometry = ARKitPlane(
// //         width: image.physicalSize.width,
// //         height: image.physicalSize.height,
// //         materials: [material],
// //       );
// //
// //       final node = ARKitNode(
// //         geometry: geometry,
// //         position: vector.Vector3(0, 0, -1), // Adjust the initial position as needed
// //       );
// //
// //       _imageNode = node;
// //       _arKitController?.add(node);
// //     }
// //   }
// //
// //   void _onPanUpdate(DragUpdateDetails details) {
// //     if (_imageNode != null) {
// //       final translation = details.delta;
// //       _imageNode?.position.value += vector.Vector3(translation.dx, -translation.dy, 0);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Manipulation Sample')),
// //       body: ARKitSceneView(
// //         onARKitViewCreated: _onARKitViewCreated,
// //         enableTapRecognizer: true,
// //         planeDetection: ARPlaneDetection.horizontal,
// //         showFeaturePoints: false,
// //         onPanUpdate: _onPanUpdate,
// //       ),
// //     );
// //   }
// // }
// //
//
//
//
// // import 'dart:math' as math;
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// // import 'package:collection/collection.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //        home:  ManipulationPage(),
// //     );
// //   }
// // }
// //
// // class ManipulationPage extends StatefulWidget {
// //   @override
// //   _ManipulationPageState createState() => _ManipulationPageState();
// // }
// //
// // class _ManipulationPageState extends State<ManipulationPage> {
// //   late ARKitController arkitController;
// //   ARKitNode? boxNode;
// //
// //   @override
// //   void dispose() {
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //     appBar: AppBar(title: const Text('Manipulation Sample')),
// //     body: Container(
// //       child: ARKitSceneView(
// //         enablePinchRecognizer: true,
// //         enablePanRecognizer: true,
// //         enableRotationRecognizer: true,
// //         onARKitViewCreated: onARKitViewCreated,
// //       ),
// //     ),
// //   );
// //
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     this.arkitController.onNodePinch = (pinch) => _onPinchHandler(pinch);
// //     this.arkitController.onNodePan = (pan) => _onPanHandler(pan);
// //     this.arkitController.onNodeRotation =
// //         (rotation) => _onRotationHandler(rotation);
// //     addNode();
// //   }
// //
// //   void addNode() {
// //     final material = ARKitMaterial(
// //       lightingModelName: ARKitLightingModel.physicallyBased,
// //       diffuse: ARKitMaterialProperty.color(
// //         Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
// //             .withOpacity(1.0),
// //       ),
// //     );
// //     final box =
// //     ARKitBox(materials: [material], width: 0.1, height: 0.1, length: 0.1);
// //
// //     final node = ARKitNode(
// //       geometry: box,
// //       position: vector.Vector3(0, 0, -0.5),
// //     );
// //     arkitController.add(node);
// //     boxNode = node;
// //   }
// //
// //   void _onPinchHandler(List<ARKitNodePinchResult> pinch) {
// //     final pinchNode = pinch.firstWhereOrNull(
// //           (e) => e.nodeName == boxNode?.name,
// //     );
// //     if (pinchNode != null) {
// //       final scale = vector.Vector3.all(pinchNode.scale);
// //       boxNode?.scale = scale;
// //     }
// //   }
// //
// //   void _onPanHandler(List<ARKitNodePanResult> pan) {
// //     final panNode = pan.firstWhereOrNull((e) => e.nodeName == boxNode?.name);
// //     if (panNode != null) {
// //       final old = boxNode?.eulerAngles;
// //       final newAngleY = panNode.translation.x * math.pi / 180;
// //       boxNode?.eulerAngles =
// //           vector.Vector3(old?.x ?? 0, newAngleY, old?.z ?? 0);
// //     }
// //   }
// //
// //   void _onRotationHandler(List<ARKitNodeRotationResult> rotation) {
// //     final rotationNode = rotation.firstWhereOrNull(
// //           (e) => e.nodeName == boxNode?.name,
// //     );
// //     if (rotationNode != null) {
// //       final rotation = boxNode?.eulerAngles ??
// //           vector.Vector3.zero() + vector.Vector3.all(rotationNode.rotation);
// //       boxNode?.eulerAngles = rotation;
// //     }
// //   }
// // }
// //
// //
//
// //박스 드래그
// // import 'dart:math' as math;
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       home: ManipulationPage(),
// //     );
// //   }
// // }
// //
// // class ManipulationPage extends StatefulWidget {
// //   @override
// //   _ManipulationPageState createState() => _ManipulationPageState();
// // }
// //
// // class _ManipulationPageState extends State<ManipulationPage> {
// //   late ARKitController arkitController;
// //   ARKitNode? boxNode;
// //   bool isDragging = false;
// //   vector.Vector3? lastPosition;
// //
// //   @override
// //   void dispose() {
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Manipulation Sample')),
// //       body: Container(
// //         child: GestureDetector(
// //           onPanStart: _onPanStart,
// //           onPanUpdate: _onPanUpdate,
// //           onPanEnd: _onPanEnd,
// //           child: ARKitSceneView(
// //             onARKitViewCreated: _onARKitViewCreated,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void _onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     addNode();
// //   }
// //
// //   void addNode() {
// //     final material = ARKitMaterial(
// //       lightingModelName: ARKitLightingModel.physicallyBased,
// //       diffuse: ARKitMaterialProperty.color(
// //         Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
// //       ),
// //     );
// //     final box = ARKitBox(materials: [material], width: 0.1, height: 0.1, length: 0.1);
// //
// //     final node = ARKitNode(
// //       geometry: box,
// //       position: vector.Vector3(0, 0, -0.5),
// //     );
// //     arkitController.add(node);
// //     boxNode = node;
// //   }
// //
// //   void _onPanStart(DragStartDetails details) {
// //     if (boxNode != null) {
// //       isDragging = true;
// //       lastPosition = boxNode!.position;
// //     }
// //   }
// //
// //   void _onPanUpdate(DragUpdateDetails details) {
// //     if (isDragging && boxNode != null) {
// //       final dx = details.delta.dx / 300;
// //       final dy = -details.delta.dy / 300;
// //       final newPosition = vector.Vector3(
// //         lastPosition!.x + dx,
// //         lastPosition!.y + dy,
// //         boxNode!.position.z, // Maintain the original z position
// //       );
// //       boxNode!.position = newPosition;
// //     }
// //   }
// //
// //   void _onPanEnd(DragEndDetails details) {
// //     isDragging = false;
// //     lastPosition = null;
// //   }
// // }
//
//
//
// //Image drag
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       home: ManipulationPage(),
// //     );
// //   }
// // }
// //
// // class ManipulationPage extends StatefulWidget {
// //   @override
// //   _ManipulationPageState createState() => _ManipulationPageState();
// // }
// //
// // class _ManipulationPageState extends State<ManipulationPage> {
// //   late ARKitController arkitController;
// //   ARKitNode? imageNode;
// //   bool isDragging = false;
// //   vector.Vector3? lastPosition;
// //
// //   @override
// //   void dispose() {
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Manipulation Sample')),
// //       body: Container(
// //         child: GestureDetector(
// //           onPanStart: _onPanStart,
// //           onPanUpdate: _onPanUpdate,
// //           onPanEnd: _onPanEnd,
// //           child: ARKitSceneView(
// //             onARKitViewCreated: _onARKitViewCreated,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void _onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     addNode();
// //   }
// //
// //   void addNode() {
// //     final imageTexture = ARKitMaterialProperty.image('images/italy.jpeg');
// //
// //     final material = ARKitMaterial(
// //       diffuse: imageTexture,
// //       doubleSided: true,
// //     );
// //
// //     final geometry = ARKitSphere(
// //       radius: 0.1,
// //       materials: [material],
// //     );
// //
// //     final node = ARKitNode(
// //       geometry: geometry,
// //       position: vector.Vector3(0, 0, -0.5),
// //     );
// //
// //     arkitController.add(node);
// //     imageNode = node;
// //   }
// //
// //   void _onPanStart(DragStartDetails details) {
// //     if (imageNode != null) {
// //       isDragging = true;
// //       lastPosition = imageNode!.position;
// //     }
// //   }
// //
// //   void _onPanUpdate(DragUpdateDetails details) {
// //     if (isDragging) {
// //       final currentPosition = imageNode?.position ?? vector.Vector3.zero();
// //       final newPosition = vector.Vector3(
// //         currentPosition.x + details.delta.dx / 1000,
// //         currentPosition.y - details.delta.dy / 1000,
// //         currentPosition.z,
// //       );
// //       imageNode?.position = newPosition;
// //     }
// //   }
// //
// //   void _onPanEnd(DragEndDetails details) {
// //     isDragging = false;
// //     lastPosition = null;
// //   }
// // }
// //
//
//
// // import 'dart:typed_data';
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// // import 'package:image_picker/image_picker.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       home: ManipulationPage(),
// //     );
// //   }
// // }
// //
// // class ManipulationPage extends StatefulWidget {
// //   @override
// //   _ManipulationPageState createState() => _ManipulationPageState();
// // }
// //
// // class _ManipulationPageState extends State<ManipulationPage> {
// //   late ARKitController arkitController;
// //   ARKitNode? imageNode;
// //   bool isDragging = false;
// //   vector.Vector3? lastPosition;
// //
// //   @override
// //   void dispose() {
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Manipulation Sample')),
// //       body: Container(
// //         child: GestureDetector(
// //           onPanStart: _onPanStart,
// //           onPanUpdate: _onPanUpdate,
// //           onPanEnd: _onPanEnd,
// //           child: ARKitSceneView(
// //             onARKitViewCreated: _onARKitViewCreated,
// //           ),
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _pickImageFromGallery,
// //         child: Icon(Icons.photo),
// //       ),
// //     );
// //   }
// //
// //   void _onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     addNode();
// //   }
// //
// //   void addNode() {
// //     final material = ARKitMaterial(
// //       diffuse: ARKitMaterialImage(
// //         'images/italy.jpeg'),
// //
// //         doubleSided: true,
// //     );
// //
// //     final geometry = ARKitSphere(
// //     radius: 0.1,
// //     materials: [material],
// //     );
// //
// //     final node = ARKitNode(
// //     geometry: geometry,
// //     position: vector.Vector3(0, 0, -0.5),
// //     );
// //
// //     arkitController.add(node);
// //     imageNode = node;
// //   }
// //
// //   Future<Uint8List> _getImageBytes(String imagePath) async {
// //     final imageBytes = await rootBundle.load(imagePath);
// //     return imageBytes.buffer.asUint8List();
// //   }
// //
// //   void _onPanStart(DragStartDetails details) {
// //     if (imageNode != null) {
// //       isDragging = true;
// //       lastPosition = imageNode!.position;
// //     }
// //   }
// //
// //   void _onPanUpdate(DragUpdateDetails details) {
// //     if (isDragging) {
// //       final currentPosition = imageNode?.position ?? vector.Vector3.zero();
// //       final newPosition = vector.Vector3(
// //         currentPosition.x + details.delta.dx / 1000,
// //         currentPosition.y - details.delta.dy / 1000,
// //         currentPosition.z,
// //       );
// //       imageNode?.position = newPosition;
// //     }
// //   }
// //
// //   void _onPanEnd(DragEndDetails details) {
// //     isDragging = false;
// //     lastPosition = null;
// //   }
// //
// //   void _pickImageFromGallery() async {
// //     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
// //     if (pickedImage != null) {
// //       // Use the picked image and add it as a material to the ARKit node
// //       // Here, you can call a function to process the picked image and update the ARKit node's material
// //     }
// //   }
// // }
//
//
// // import 'dart:async';
// //
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       home: ImageDetectionPage(),
// //     );
// //   }
// // }
// // class ImageDetectionPage extends StatefulWidget {
// //   @override
// //   _ImageDetectionPageState createState() => _ImageDetectionPageState();
// // }
// //
// // class _ImageDetectionPageState extends State<ImageDetectionPage> {
// //   late ARKitController arkitController;
// //   Timer? timer;
// //   bool anchorWasFound = false;
// //
// //   @override
// //   void dispose() {
// //     timer?.cancel();
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //     appBar: AppBar(title: const Text('Image Detection Sample')),
// //     body: Container(
// //       child: Stack(
// //         fit: StackFit.expand,
// //         children: [
// //           ARKitSceneView(
// //             detectionImagesGroupName: 'AR Resources',
// //             onARKitViewCreated: onARKitViewCreated,
// //           ),
// //           anchorWasFound
// //               ? Container()
// //               : Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Text(
// //               'Point the camera at the earth image from the article about Earth on Wikipedia.',
// //               style: Theme.of(context)
// //                   .textTheme
// //                   .headlineSmall
// //                   ?.copyWith(color: Colors.white),
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// //
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
// //   }
// //
// //   void onAnchorWasFound(ARKitAnchor anchor) {
// //     if (anchor is ARKitImageAnchor) {
// //       setState(() => anchorWasFound = true);
// //
// //       final material = ARKitMaterial(
// //         lightingModelName: ARKitLightingModel.lambert,
// //         diffuse: ARKitMaterialProperty.image('earth.jpg'),
// //       );
// //       final sphere = ARKitSphere(
// //         materials: [material],
// //         radius: 0.1,
// //       );
// //
// //       final earthPosition = anchor.transform.getColumn(3);
// //       final node = ARKitNode(
// //         geometry: sphere,
// //         position:
// //         vector.Vector3(earthPosition.x, earthPosition.y, earthPosition.z),
// //         eulerAngles: vector.Vector3.zero(),
// //       );
// //       arkitController.add(node);
// //
// //       timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
// //         final old = node.eulerAngles;
// //         final eulerAngles = vector.Vector3(old.x + 0.01, old.y, old.z);
// //         node.eulerAngles = eulerAngles;
// //       });
// //     }
// //   }
// // }
//
//
//
//
// // import 'dart:async';
// //
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// // import 'package:url_launcher/url_launcher.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       home: ImageDetectionPage(),
// //     );
// //   }
// // }
// //
// // class ImageDetectionPage extends StatefulWidget {
// //   @override
// //   _ImageDetectionPageState createState() => _ImageDetectionPageState();
// // }
// //
// // class _ImageDetectionPageState extends State<ImageDetectionPage> {
// //   late ARKitController arkitController;
// //   Timer? timer;
// //   bool anchorWasFound = false;
// //
// //   @override
// //   void dispose() {
// //     timer?.cancel();
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //     appBar: AppBar(title: const Text('Image Detection Sample')),
// //     body: Container(
// //       child: Stack(
// //         fit: StackFit.expand,
// //         children: [
// //           ARKitSceneView(
// //             detectionImagesGroupName: 'AR Resources',
// //             onARKitViewCreated: onARKitViewCreated,
// //           ),
// //           anchorWasFound
// //               ? Container()
// //               : Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Text(
// //               'Point the camera at the earth image from the article about Earth on Wikipedia.',
// //               style: Theme.of(context)
// //                   .textTheme
// //                   .headlineSmall
// //                   ?.copyWith(color: Colors.white),
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// //
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
// //   }
// //
// //   void onAnchorWasFound(ARKitAnchor anchor) {
// //     if (anchor is ARKitImageAnchor) {
// //       setState(() => anchorWasFound = true);
// //
// //       final earthPosition = anchor.transform.getColumn(3);
// //
// //       // Create a plane with a default size
// //       final plane = ARKitPlane(
// //         width: 1.0,
// //         height: 1.0,
// //         materials: [
// //           ARKitMaterial(
// //             diffuse: ARKitMaterialProperty.image('images/van.jpeg'),
// //           ),
// //         ],
// //       );
// //
// //       final node = ARKitNode(
// //         geometry: plane,
// //         position:
// //         vector.Vector3(earthPosition.x, earthPosition.y, earthPosition.z),
// //         eulerAngles: vector.Vector3.zero(),
// //       );
// //       arkitController.add(node);
// //
// //       timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
// //         final old = node.eulerAngles;
// //         final eulerAngles = vector.Vector3(old.x + 0.01, old.y, old.z);
// //         node.eulerAngles = eulerAngles;
// //       });
// //
// //       // Launch the URL when the image is detected
// //       if (anchor.referenceImageName == 'earth') {
// //         launchURL('https://www.youtube.com/watch?v=ZknwqieFqwk');
// //       }
// //     }
// //   }
// //
// //   void launchURL(String url) async {
// //     if (await canLaunch(url)) {
// //       await launch(url);
// //     } else {
// //       throw 'Could not launch $url';
// //     }
// //   }
// // }
//
//
// // import 'dart:async';
// //
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// // import 'package:url_launcher/url_launcher.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       home: ImageDetectionPage(),
// //     );
// //   }
// // }
// //
// // class ImageDetectionPage extends StatefulWidget {
// //   @override
// //   _ImageDetectionPageState createState() => _ImageDetectionPageState();
// // }
// //
// // class _ImageDetectionPageState extends State<ImageDetectionPage> {
// //   late ARKitController arkitController;
// //   Timer? timer;
// //   bool anchorWasFound = false;
// //
// //   @override
// //   void dispose() {
// //     timer?.cancel();
// //     arkitController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) =>
// //       Scaffold(
// //         appBar: AppBar(title: const Text('Image Detection Sample')),
// //         body: Container(
// //           child: Stack(
// //             fit: StackFit.expand,
// //             children: [
// //               ARKitSceneView(
// //                 detectionImagesGroupName: 'AR Resources',
// //                 onARKitViewCreated: onARKitViewCreated,
// //               ),
// //               anchorWasFound
// //                   ? Container()
// //                   : Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text(
// //                   'Point the camera at the van.jpeg image to display the link.',
// //                   style: Theme
// //                       .of(context)
// //                       .textTheme
// //                       .headline6
// //                       ?.copyWith(color: Colors.white),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //
// //
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     this.arkitController.onAddNodeForAnchor = onAddNodeForAnchor;
// //   }
// //
// //   void onAddNodeForAnchor(ARKitAnchor anchor) {
// //     if (anchor is ARKitImageAnchor) {
// //       // 대상 이미지를 인식한 경우 실행할 동작을 구현합니다.
// //       // 예를 들어, 대상 이미지 위에 가상 객체를 배치할 수 있습니다.
// //       final material = ARKitMaterial(
// //         diffuse: ARKitMaterialProperty.color(const Color(0xFFFF0000)),
// //       );
// //       final cube = ARKitBox(
// //         materials: [material],
// //         width: 0.1,
// //         height: 0.1,
// //         length: 0.1,
// //       );
// //       final node = ARKitNode(
// //         geometry: cube,
// //         position: anchor.transform.getTranslation(),
// //         eulerAngles: vector.Vector3.zero(),
// //       );
// //       arkitController.add(node);
// //     }
// //   }
// // }
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
// //   }
// //
// //   void onAnchorWasFound(ARKitAnchor anchor) {
// //     if (anchor is ARKitImageAnchor) {
// //       setState(() => anchorWasFound = true);
// //
// //       final anchorPosition = anchor.transform.getColumn(3);
// //
// //       // Create a plane with a default size
// //       final plane = ARKitPlane(
// //         width: 1.0,
// //         height: 1.0,
// //         materials: [
// //           ARKitMaterial(
// //             diffuse: ARKitMaterialProperty.image('images/van.jpeg'),
// //           ),
// //         ],
// //       );
// //
// //       final node = ARKitNode(
// //         geometry: plane,
// //         position: vector.Vector3(
// //           anchorPosition.x,
// //           anchorPosition.y,
// //           anchorPosition.z,
// //         ),
// //         eulerAngles: vector.Vector3.zero(),
// //       );
// //       arkitController.add(node);
// //
// //       timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
// //         final old = node.eulerAngles;
// //         final eulerAngles = vector.Vector3(old.x + 0.01, old.y, old.z);
// //         node.eulerAngles = eulerAngles;
// //       });
// //
// //       // Launch the URL when the "van.jpeg" image is detected
// //       if (anchor.referenceImageName == 'van.jpeg') {
// //         launchURL('https://www.youtube.com/watch?v=ZknwqieFqwk');
// //       }
// //     }
// //   }
// //
// //   void launchURL(String url) async {
// //     if (await canLaunch(url)) {
// //       await launch(url);
// //     } else {
// //       throw 'Could not launch $url';
// //     }
// //   }
// // }
// //
//
//

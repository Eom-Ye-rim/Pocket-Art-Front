
import 'package:flutter/material.dart';
import 'package:flutter_ar_example/splash/FirstSplash.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<_MyApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/updatemotion.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown and set the state when the video is initialized.
        setState(() {
          print('Video initialized successfully');
          _controller.play(); // 자동으로 영상 재생 시작
        });
      });
    // Add a listener to detect when the video playback is completed
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FirstSplash()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(), // Show a loading indicator while the video is initializing.
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}






// import 'dart:io';
// import 'package:flutter/material.dart';
//
// import 'package:arkit_plugin/arkit_plugin.dart';
// import 'package:flutter_ar_example/ai/aiText.dart';
// import 'package:flutter_ar_example/first.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:vector_math/vector_math_64.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ManipulationPage(),
//     );
//   }
// }
//
// class ManipulationPage extends StatefulWidget {
//   @override
//   _ManipulationPageState createState() => _ManipulationPageState();
// }
//
// class _ManipulationPageState extends State<ManipulationPage> {
//   ARKitController? arkitController;
//   ARKitNode? imageNode;
//   ARKitNode? textNode;
//   bool isDragging = false;
//   Vector3? lastPosition;
//   List<ARKitNode> addedNodes = [];
//   List<File> pickedImages = [];
//   double scale = 1.0;
//   double previousScale = 1.0;
//   bool isSphere = false;
//   List<String> selectedImages =[];
//   Map<String, String> imageCaptions = {
//     'images/gogh1.jpeg': '밤의 카페 테라스',
//     'images/monet1.jpeg': '생타드레스의 해변가',
//     'images/monet2.jpeg': '수련',
//     'images/monet3.jpeg': '자화상',
//     'images/monet4.jpeg': '파라솔을 든 여인',
//     'images/gogh4.jpeg': '해바라기',
//     // Add captions for the images in predefinedImages2 as well
//     'images/ko1.jpeg': 'Korean Caption 1',
//     'images/ko2.jpeg': 'Korean Caption 2',
//     'images/ko3.jpeg': 'Korean Caption 3',
//     'images/ko4.jpeg': 'Korean Caption 4',
//     'images/ko5.jpeg': 'Korean Caption 5',
//     'images/ko6.jpeg': 'Korean Caption 6',
//   };
//   List<String> predefinedImages = [
//     'images/gogh1.jpeg',
//     'images/monet1.jpeg',
//     'images/monet2.jpeg',
//     'images/monet3.jpeg',
//     'images/monet4.jpeg',
//     'images/gogh4.jpeg',
//   ];
//
//   List<String> predefinedImages2 = [
//     'images/ko1.jpeg',
//     'images/ko2.jpeg',
//     'images/ko3.jpeg',
//     'images/ko4.jpeg',
//     'images/ko5.jpeg',
//     'images/ko6.jpeg',
//   ];
//
//   bool showButtons = false;
//
//   void _showButtons() {
//     setState(() {
//       showButtons = true;
//     });
//   }
//
//   void _hideButtons() {
//     setState(() {
//       showButtons = false;
//     });
//   }
//
//   void _toggleButtons() {
//     setState(() {
//       showButtons = !showButtons;
//     });
//   }
//
//   @override
//   void dispose() {
//     arkitController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       backgroundColor:  Color(0x0),
//       appBar: AppBar(
//         leadingWidth: 113,
//         toolbarHeight: 66,
//         leading: gotoMainBtn(),
//         backgroundColor: Color(0x27000000), // 투명으로 해도 appBar 자체 그림자 생김
//         elevation: 0.0, // appBar 그림자 0.0 해주면 완전 투명됨
//       ),
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Container(
//             child: GestureDetector(
//               onTap: () {
//                 _hideButtons();
//               },
//               onPanStart: _onPanStart,
//               onPanUpdate: _onPanUpdate,
//               child: ARKitSceneView(
//                 onARKitViewCreated: _onARKitViewCreated,
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               _toggleButtons();
//               _showPredefinedImages();
//             },
//             child: Icon(Icons.photo),
//           ),
//           SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: () {
//               _toggleShape();
//               // Handle the shape toggle button click
//             },
//             child: Icon(Icons.transform),
//           ),
//         ],
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
//     final defaultImage = AssetImage('images/star.jpeg');
//
//     final defaultMaterial = ARKitMaterial(
//       diffuse: ARKitMaterialImage(defaultImage.assetName),
//       doubleSided: true,
//     );
//
//     final defaultGeometry = ARKitPlane(
//       width: 0.5,
//       height: 0.5,
//       materials: [defaultMaterial],
//     );
//
//     final defaultNode = ARKitNode(
//       geometry: defaultGeometry,
//       position: Vector3(0, 0, -0.7),
//     );
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
//         if (node != imageNode && node.geometry is ARKitPlane) {
//           final nodePosition = node.position;
//           final newNodePosition = vector.Vector3(
//             nodePosition.x - details.delta.dx / 1000,
//             nodePosition.y + details.delta.dy / 1000,
//             nodePosition.z,
//           );
//
//           node.position = newNodePosition;
//         }
//       }
//     }
//   }
//
//   void _showPredefinedImages() {
//     setState(() {
//       _updateSelectedImages(predefinedImages);
//     });
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         final int imagesPerPage = 9;
//         final int pageCount = (selectedImages.length / imagesPerPage).ceil();
//
//         return Container(
//           height: 300, // Increase the height of the container
//           decoration: ShapeDecoration(
//             color: Color(0xFF202020),
//             shape: RoundedRectangleBorder(
//
//             ),
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FloatingActionButton(
//                     onPressed: () {
//
//                         _updateSelectedImages(predefinedImages);
//
//                     },
//                     backgroundColor: Color(0x3C000000),
//                     child: Text(
//                       '동양풍',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ),
//                   SizedBox(width: 40),
//                   FloatingActionButton(
//                     onPressed: () {
//
//                         _updateSelectedImages(predefinedImages2);
//
//                     },
//                     backgroundColor: Color(0x3C000000),
//                     child: Text(
//                       '서양풍',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ),
//                   SizedBox(width: 40),
//                   FloatingActionButton(
//                     onPressed: () {
//                       _showUserPhotoAlbum();
//                       // Handle 앨범 button click
//                     },
//                     backgroundColor: Color(0x3C000000),
//                     child: Text(
//                       '앨범',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: ClipRRect(
//                   child: PageView.builder(
//                     itemCount: pageCount,
//                     itemBuilder: (context, pageIndex) {
//                       final startIndex = pageIndex * imagesPerPage;
//                       final endIndex = (startIndex + imagesPerPage) < selectedImages.length
//                           ? (startIndex + imagesPerPage)
//                           : selectedImages.length;
//                       final pageImages = selectedImages.sublist(startIndex, endIndex);
//
//                       return Container(
//                         color: Color(0x0),//백그라운드
//                         padding: EdgeInsets.symmetric(vertical: 14),
//                         child: GridView.count(
//                           crossAxisCount: 3,
//                           padding: EdgeInsets.all(8),
//                           crossAxisSpacing: 12,
//                           mainAxisSpacing: 42,
//                           children: List.generate(selectedImages.length, (index) {
//                             final imagePath = selectedImages[index];
//                             final caption = _getCaptionForImagePath(imagePath);
//                             return GestureDetector(
//                               onTap: () {
//                                 //캡션은 지워야 함
//                                 _addImageNode(imagePath,caption);
//                                 Navigator.pop(context);
//                               },
//
//                               child: GridTile(
//                                 child: Column(
//                                   children: [
//                                     AspectRatio(
//                                       aspectRatio: 1.0,
//                                       child: Image.asset(
//                                         imagePath,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     // SizedBox(height: 12),
//
//                             Flexible(
//                             child: Text(
//                             caption,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                             fontSize: 12,
//                             color: Color(0xffffffff), // Set the text color to white
//                             ),
//                             ),
//                             ),
//                                   ],
//                                 ),
//                                 ),
//
//
//                             );
//                           }),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//   Future<void> _showUserPhotoAlbum() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       //꼭 추가!!
//       // _addImageNode(pickedImage.path);
//     }
//   }
//
//   void _addImageNode(String imagePath, String caption) {
//     // Remove previous image node and text node if they exist
//     if (imageNode != null) {
//       arkitController?.remove(imageNode!.name);
//       addedNodes.remove(imageNode);
//     }
//
//     final imageNodePosition = imageNode?.position ?? vector.Vector3.zero();
//     final material = ARKitMaterial(
//       diffuse: ARKitMaterialImage(imagePath),
//       doubleSided: true,
//     );
//
//     final geometry = isSphere
//         ? ARKitSphere(radius: 0.15, materials: [material])
//         : ARKitPlane(width: 0.5, height: 0.5, materials: [material]);
//
//     final node = ARKitNode(
//       geometry: geometry,
//       position: imageNodePosition + vector.Vector3(0.5, 0, 0),
//     );
//
//     arkitController?.add(node);
//     imageNode = node;
//     addedNodes.add(node);
//
//     // Add text node with the caption
//     final textGeometry = ARKitText(
//       text: caption,
//       extrusionDepth: 0,
//       materials: [ARKitMaterial(
//         diffuse: ARKitMaterialColor(Color(0x79525252)),
//       )],
//     );
//
//     final textNodePosition = imageNode!.position +vector.Vector3(-0.15, 0, -8.5) ; // Adjust the position of the text node relative to the image node
//     final textNode = ARKitNode(
//       geometry: textGeometry,
//       position: textNodePosition,
//       eulerAngles: vector.Vector3.zero(),
//         scale: vector.Vector3(0.5, 0.5, 0.5), //글자 크기 설정
//     );
//
//     arkitController?.add(textNode);
//     addedNodes.add(textNode);
//   }
//
//   void _updateSelectedImages(List<String> newImages) {
//     selectedImages.clear(); // Clear the existing images
//     selectedImages.addAll(newImages);
//   }
//
//   void _toggleShape() {
//     setState(() {
//       isSphere = !isSphere;
//       if (imageNode != null) {
//         final imagePath = (imageNode?.geometry?.materials.value?.first?.diffuse as ARKitMaterialImage?)?.image;
//         final material = ARKitMaterial(
//           diffuse: ARKitMaterialImage(imagePath ?? ''),
//           doubleSided: true,
//         );
//
//         final geometry = isSphere
//             ? ARKitSphere(radius: 0.25, materials: [material])
//             : ARKitPlane(width: 0.5, height: 0.5, materials: [material]);
//
//         final newNode = ARKitNode(
//           geometry: geometry,
//           position: imageNode!.position,
//         );
//
//         for (final node in addedNodes) {
//           arkitController?.remove(node.name);
//         }
//         addedNodes.clear();
//
//         arkitController?.remove(imageNode!.name);
//         arkitController?.add(newNode);
//         imageNode = newNode;
//         addedNodes.add(newNode);
//       }
//     });
//   }
//
//   String _getCaptionForImagePath(String imagePath) {
//     // Use the imageCaptions map to look up captions based on the image path
//     final caption = imageCaptions[imagePath] ?? 'Default Caption'; // Provide a default caption if not found
//     return caption;
//   }
// }



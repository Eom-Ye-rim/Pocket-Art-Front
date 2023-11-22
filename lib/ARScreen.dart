import 'dart:io';
import 'package:flutter/material.dart';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import 'mainpage/MainPage.dart';

void main() {
  runApp(const ARScreen());
}

class ARScreen extends StatelessWidget {
  const ARScreen({Key? key}) : super(key: key);

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
  final screenshotController = ScreenshotController();
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
  List<String> selectedImages =[];
  Map<String, String> imageCaptions = {
    'images/gogh1.jpeg': '밤의 카페 테라스 ',
    'images/monet1.jpeg': '생타드레스의 해변가',
    'images/monet2.jpeg': '수련',
    'images/monet3.jpeg': '자화상',
    'images/monet4.jpeg': '파라솔을 든 여인',
    'images/flower.jpeg': '해바라기',
    // Add captions for the images in predefinedImages2 as well
    'images/ko1.jpeg': '동양화 1',
    'images/ko2.jpeg': '동양화 2',
    'images/ko3.jpeg': '동양화 3',
    'images/ko4.jpeg': '동양화 4',
    'images/ko5.jpeg': '동양화 5',
    'images/ko6.jpeg': '동양화 6',
  };
  List<String> predefinedImages = [
    'images/gogh1.jpeg',
    'images/monet1.jpeg',
    'images/monet2.jpeg',
    'images/monet3.jpeg',
    'images/monet4.jpeg',
    'images/flower.jpeg',
    'images/ko1.jpeg',
    'images/ko2.jpeg',
    'images/ko3.jpeg',
    'images/ko4.jpeg',
    'images/ko5.jpeg',
    'images/ko6.jpeg',
  ];

  List<String> predefinedImages2 = [
    // 'images/ko1.jpeg',
    // 'images/ko2.jpeg',
    // 'images/ko3.jpeg',
    // 'images/ko4.jpeg',
    // 'images/ko5.jpeg',
    // 'images/ko6.jpeg',
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

      // backgroundColor:  Color(0x0),
      // appBar: AppBar(
      //   leadingWidth: 113,
      //   toolbarHeight: 66,
      //   leading: gotoMainBtn(),
      //   backgroundColor: Color(0x27000000), // 투명으로 해도 appBar 자체 그림자 생김
      //   elevation: 0.0, // appBar 그림자 0.0 해주면 완전 투명됨
      // ),
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
          Positioned(
            top:  50, // 수직 중앙에 위치
            left: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  //PhotoBoard
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: CircleAvatar(

                backgroundColor: Color(0x0), // 배경색을 투명으로 설정합니다.
                child: Image.asset(
                  'images/arrowback.png', // 이미지 파일 경로를 설정합니다.
                  // 이미지의 색상을 변경합니다.
                ),
              ),
            ),
          ),
          Positioned(
            top:  100, // 수직 중앙에 위치
            left: 345,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  //PhotoBoard
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Color(0x0), // 배경색을 투명으로 설정합니다.
                child: Image.asset(
                  'images/back.png', // 이미지 파일 경로를 설정합니다.
                  // 이미지의 색상을 변경합니다.
                ),
              ),
            ),
          ),
          Positioned(
            top:  145, // 수직 중앙에 위치
            left: 345,
            child: GestureDetector(
              onTap: () {
                _toggleShape();
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Color(0x0), // 배경색을 투명으로 설정합니다.
                child: Image.asset(
                  'images/circle.png', // 이미지 파일 경로를 설정합니다.
                  // 이미지의 색상을 변경합니다.
                ),
              ),
            ),
          ),
          Positioned(
            top:  790, // 수직 중앙에 위치
            left: 65,
            child: GestureDetector(
              onTap: () {
                _toggleButtons();
                _showPredefinedImages();

              },
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Color(0x0), // 배경색을 투명으로 설정합니다.
                child: Image.asset(
                  'images/art.png', // 이미지 파일 경로를 설정합니다.
                  // 이미지의 색상을 변경합니다.
                ),
              ),
            ),
          ),

          Positioned(
            top: 790, // 수직 중앙에 위치
            left: 170,
            child: GestureDetector(
              onTap: () async {
                final imageUint8List = await screenshotController.capture();

                if (imageUint8List != null) {
                  // Uint8List 형식의 이미지 데이터를 파일로 저장
                  final imageFile = File('경로를 지정하세요'); // 저장할 파일 경로를 지정해야 합니다.
                  await imageFile.writeAsBytes(imageUint8List);

                  // 이미지 갤러리에 저장
                  final result = await ImageGallerySaver.saveFile(imageFile.path);

                  // 저장 결과 확인
                  if (result != null && result['isSuccess']) {
                    print('스크린샷이 갤러리에 저장되었습니다.');
                  } else {
                    print('스크린샷 저장에 실패했습니다.');
                  }
                } else {
                  print('스크린샷 촬영에 실패했습니다.');
                }
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Color(0x0), // 배경색을 투명으로 설정합니다.
                child: Image.asset(
                  'images/cameras.png', // 이미지 파일 경로를 설정합니다.
                  // 이미지의 색상을 변경합니다.
                ),
              ),
            ),
          ),
          Positioned(
            top: 790, // 수직 중앙에 위치
            left: 290,
            child: GestureDetector(
              onTap: () {
                _showUserPhotoAlbum();
              },
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Color(0x0), // 배경색을 투명으로 설정합니다.
                child: Image.asset(
                  'images/album.png', // 이미지 파일 경로를 설정합니다.
                  // 이미지의 색상을 변경합니다.
                ),
              ),
            ),
          ),



          // floatingActionButton: Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         _toggleButtons();
          //         _showPredefinedImages();
          //       },
          //       child: CircleAvatar(
          //         backgroundColor: Color(0x0), // 배경색을 투명으로 설정합니다.
          //         child: Image.asset(
          //           'images/photo.png', // 이미지 파일 경로를 설정합니다.
          //           // 이미지의 색상을 변경합니다.
          //         ),
          //       ),
          //     ),
          //     SizedBox(height: 16),
          //     InkWell(
          //       onTap: () {
          //         _toggleShape();
          //         // Handle the shape toggle button click
          //       },
          //       child: CircleAvatar(
          //         backgroundColor: Color(0x0), // 배경색을 투명으로 설정합니다.
          //         child: Image.asset(
          //           'images/album.png', // 이미지 파일 경로를 설정합니다.
          //           // 이미지의 색상을 변경합니다.
          //         ),
          //       ),
          //     ),

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
    setState(() {
      _updateSelectedImages(predefinedImages);
    });
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final int imagesPerPage = 9;
        final int pageCount = (selectedImages.length / imagesPerPage).ceil();

        return Container(
          height: 320, // Increase the height of the container
          decoration: ShapeDecoration(
            color: Color(0xFF202020),
            shape: RoundedRectangleBorder(

            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _updateSelectedImages(predefinedImages);
                      });
                    },
                    backgroundColor: Color(0x3C000000),
                    child: Text(
                      '작품',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  // SizedBox(width: 40),
                  // FloatingActionButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _updateSelectedImages(predefinedImages2);
                  //     });
                  //   },
                  //   backgroundColor: Color(0x3C000000),
                  //   child: Text(
                  //     '서양풍',
                  //     style: TextStyle(fontSize: 12),
                  //   ),
                  // ),
                  SizedBox(width: 40),
                  FloatingActionButton(
                    onPressed: () {
                      _showUserPhotoAlbum();
                      // Handle 앨범 button click
                    },
                    backgroundColor: Color(0x3C000000),
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
                      final endIndex = (startIndex + imagesPerPage) < selectedImages.length
                          ? (startIndex + imagesPerPage)
                          : selectedImages.length;
                      final pageImages = selectedImages.sublist(startIndex, endIndex);

                      return Container(
                        color: Color(0x0),//백그라운드
                        padding: EdgeInsets.symmetric(vertical: 23),
                        child: GridView.count(
                          crossAxisCount: 3,
                          padding: EdgeInsets.all(8),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 50,
                          children: List.generate(selectedImages.length, (index) {
                            final imagePath = selectedImages[index];
                            final caption = _getCaptionForImagePath(imagePath);
                            return GestureDetector(
                              onTap: () {
                                //캡션은 지워야 함
                                _addImageNode(imagePath,caption);
                                Navigator.pop(context);
                              },
                              child: SingleChildScrollView(
                                child: GridTile(
                                  child:Container(
                                    child: Column(

                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1.13,
                                          child: Image.asset(
                                            imagePath,
                                            fit: BoxFit.cover,
                                            // 이미지의 높이를 원하는 값으로 조절
                                          ),
                                        ),
                                        // SizedBox(height: 15),
                                        Container(
                                          child: Text(
                                            caption,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xffffffff), // Set the text color to white
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

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
      //꼭 추가!!
      _PhotoaddImageNode(pickedImage.path);
    }
  }
  void _PhotoaddImageNode(String imagePath) {
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

  }

  void _addImageNode(String imagePath, String caption) {
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

    // Add text node with the caption
    final textGeometry = ARKitText(
      text: caption,
      extrusionDepth: 0,
      materials: [ARKitMaterial(
        diffuse: ARKitMaterialColor(Color(0x79525252)),
      )],
    );

    final textNodePosition = imageNode!.position +vector.Vector3(-0.15, 0, -8.5) ; // Adjust the position of the text node relative to the image node
    final textNode = ARKitNode(
      geometry: textGeometry,
      position: textNodePosition,
      eulerAngles: vector.Vector3.zero(),
      scale: vector.Vector3(0.5, 0.5, 0.5), //글자 크기 설정
    );
    //
    // arkitController?.add(textNode);
    // addedNodes.add(textNode);
  }

  void _updateSelectedImages(List<String> newImages) {
    setState(() {
      selectedImages.clear(); // Clear the existing images
      selectedImages.addAll(newImages);
    });
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
    // Use the imageCaptions map to look up captions based on the image path
    final caption = imageCaptions[imagePath] ?? 'Default Caption'; // Provide a default caption if not found
    return caption;
  }
}
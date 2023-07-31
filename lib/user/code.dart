import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  bool isDragging = false;
  vector.Vector3? lastPosition;
  List<ARKitNode> addedNodes = [];
  List<File> pickedImages = [];
  double scale = 1.0;
  double previousScale = 1.0;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manipulation Sample'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          child: ARKitSceneView(
            onARKitViewCreated: _onARKitViewCreated,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImagesFromGallery,
        child: Icon(Icons.photo),
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
      position: vector.Vector3(0, 0, -0.5),
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

  void _pickImagesFromGallery() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        pickedImages =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      });

      for (final imageFile in pickedImages) {
        final imageNodePosition = imageNode?.position ?? vector.Vector3.zero();
        final material = ARKitMaterial(
          diffuse: ARKitMaterialImage(imageFile.path),
          doubleSided: true,
        );

        final geometry = ARKitPlane(
          width: 0.5,
          height: 0.5,
          materials: [material],
        );

        final node = ARKitNode(
          geometry: geometry,
          position: imageNodePosition + vector.Vector3(0.2, 0, 0),
        );

        arkitController?.add(node);
        addedNodes.add(node);
      }
    }
  }

  void _onScaleStart(ScaleStartDetails details) {
    previousScale = scale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      scale = previousScale * details.scale;
    });

    if (imageNode != null) {
      imageNode!.scale = vector.Vector3(scale, scale, scale);

      // Update scale for newly added images
      for (final node in addedNodes) {
        if (node != imageNode && node.geometry is ARKitPlane) {
          node.scale = vector.Vector3(scale, scale, scale);
        }
      }
    }
  }


}








// class ManipulationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: 414,
//         height: 896,
//         color: Colors.white,
//         padding: const EdgeInsets.only(bottom: 119, ),
//     child: Column(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children:[
//     Container(
//     width: 414,
//     height: 49,
//     padding: const EdgeInsets.only(left: 33, right: 15, bottom: 20, ),
//     child: Row(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.end,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children:[
//     Container(
//     width: 28.43,
//     height: 11.09,
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(8),
//     color: Color(0xff121319),
//     ),
//     ),
//     SizedBox(width: 25.89),
//     Container(
//     width: 66.66,
//     height:5,
//     child: Stack(
//     children:[Container(
//     width: 24.33,
//     height: 5,
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(8),
//     ),
//     // child: FlutterLogo(size: 11.333333015441895),
//     ),],
//     ),
//     ),
//     ],
//     ),
//     ),
//       SizedBox(height: 10),
//
//       Container(
//         width: 110,
//         height: 24,
//         child: Stack(
//           children: [
//             // Positioned(
//             //   left: 10, // IconButton의 왼쪽 위치를 0으로 설정합니다
//             //   child: IconButton(
//             //     icon: Icon(Icons.arrow_back),
//             //     onPressed: () {
//             //       Navigator.push(
//             //         context,
//             //         MaterialPageRoute(builder: (context) => const FirstRoute()),
//             //       );
//             //     },
//             //   ),
//             // ),
//             SizedBox(width: 30, height: 20),
//             Text(
//               "회원가입",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//                 fontFamily: "SUIT",
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     SizedBox(height: 22.50),
//     Container(
//     width: 414,
//     height: 4,
//     color: Color(0xffe8e8e8),
//     padding: const EdgeInsets.only(right: 330, ),
//     child: Row(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children:[
//     Container(
//     width: 84,
//     height: 30,
//     color: Color(0xff3c62dd),
//     ),
//     ],
//     ),
//     ),
//     SizedBox(height: 100),
//     Text(
//     "이메일 인증을 진행해주세요.",
//     style: TextStyle(
//     color: Color(0xff3e3e3e),
//     fontSize: 25,
//     fontFamily: "SUIT",
//     fontWeight: FontWeight.w700,
//     ),
//     ),
//     SizedBox(height: 22.50),
//     Text(
//     "인증번호를 받을 수 있는 유효한 메일주소를 적어주세요.",
//     style: TextStyle(
//     color: Color(0xff9d9d9d),
//     fontSize: 14,
//     fontFamily: "SUIT",
//     fontWeight: FontWeight.w500,
//     ),
//     ),
//     SizedBox(height: 22.50),
//     Container(
//     width: 220,
//     height: 220,
//     child: Stack(
//     children:[Positioned(
//     left: 11,
//     top: 8.80,
//     child: Container(
//     width: 189.20,
//     height: 211.20,
//     child: Column(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.end,
//     children:[
//     Container(
//     width: 17.60,
//     height: 17.60,
//
//     ),
//     // SizedBox(height: 81.40),
//     // Container(
//     // width: 11,
//     // height: 11,
//     // decoration: BoxDecoration(
//     // shape: BoxShape.circle,
//     // color: Color(0xff546fff),
//     // ),
//     // ),
//     // SizedBox(height: 81.40),
//     // Container(
//     // width: 19.80,
//     // height: 19.80,
//     // decoration: BoxDecoration(
//     // shape: BoxShape.circle,
//     // color: Color(0xff546fff),
//     // ),
//     // ),
//     ],
//     ),
//     ),
//     ),
//     Container(
//     width: 220,
//     height: 220,
//     child: Stack(
//
//     children:[Container(
//     width: 220,
//     height: 220,
//
//     ),
//       Image(
//         image: AssetImage('images/key.png'),
//         width: 221.2,
//         height: 220,
//         fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조절
//       ),
//     Positioned.fill(
//     child: Align(
//     alignment: Alignment.center,
//     child: Container(
//     width: 120.2,
//     height: 119.54,
//     padding: const EdgeInsets.symmetric(horizontal: 4, ),
//     child: Row(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children:[
//     Container(
//     width: 112.20,
//     height: 119.54,
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(8),
//     ),
//
//     ),
//     ],
//     ),
//     ),
//     ),
//     ),],
//     ),
//     ),],
//     ),
//     ),
//     SizedBox(height: 22.50),
//     Container(
//     width: 360,
//     height: 66,
//     decoration: BoxDecoration(
//     border: Border.all(color: Color(0xffb3b3b3), width: 1, ),
//     color: Colors.white,
//     ),
//     padding: const EdgeInsets.only(left: 14, right: 210, top: 20, bottom: 21, ),
//     child: Row(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children:[
//     Text(
//     "이메일 주소 입력",
//     style: TextStyle(
//     color: Color(0xff6a6a6a),
//     fontSize: 20,
//     ),
//     ),
//     ],
//     ),
//     ),
//     SizedBox(height: 5.3),
//     Container(
//     width: 360, height: 28,
//
//     // child: FlutterLogo(size: 17),
//       child:Stack(
//         children: [
//           Positioned(
//             left: 4,
//             bottom:14,
//             child: Image(
//             image: AssetImage('images/alert.png'),
//           ),
//           ),
//           Positioned(
//             left: 22, // 이미지 오른쪽에 텍스트를 배치하기 위해 left 속성 조정
//             child:
//             Text(
//             "인증메일은 1시간 이내에 완료해주세요.",
//             style: TextStyle(
//             color: Color(0xff454444),
//             fontSize: 12,
//             ),
//             ),
//           ),
//         ],
//       ),
//     ),
//
//     // Text(
//     // "인증메일은 1시간 이내에 완료해주세요.",
//     // style: TextStyle(
//     // color: Color(0xff454444),
//     // fontSize: 12,
//     // ),
//     // ),
//     SizedBox(height: 10),
//     Text(
//     "다음",
//     style: TextStyle(
//     color: Colors.white,
//     fontSize: 20,
//     fontFamily: "SUIT",
//     fontWeight: FontWeight.w700,
//     ),
//     ),
//     SizedBox(height: 22.50),
//     Container(
//     width: 356,
//     height: 56,
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(32.50),
//     boxShadow: [
//     BoxShadow(
//     color: Color(0x3f000000),
//     blurRadius: 9,
//     offset: Offset(0, 0),
//     ),
//     ],
//     color: Color(0xff363636),
//     ),
//     padding: const EdgeInsets.only(left: 160, right: 161, top: 14, bottom: 17, ),
//     child: Row(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children:[
//     Text(
//     "다음",
//     style: TextStyle(
//     color: Colors.white,
//     fontSize: 20,
//     fontFamily: "SUIT",
//     fontWeight: FontWeight.w700,
//     ),
//     ),
//     ],
//     ),
//     ),
//     ],
//     ),
//     ),
//     );
//   }
// }
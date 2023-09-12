
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/board/PhotoBoard.dart';
import 'package:flutter_ar_example/user/signupcode.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  KakaoSdk.init(nativeAppKey:'077a09d06719ae6dd518a8049399d4a0');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FirstRoute(),
    );
  }
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  String email='';
  String password='';

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    width: 536,
                    height: 1050,
                    child: Stack(
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 44,
              top: 332,
              child: Container(
                width: 320,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 57,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffb3b3b3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 309,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 309,
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              email = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: "이메일 주소 입력",
                                            hintStyle: TextStyle(
                                              color: Color(0xffb3b3b3),
                                              fontSize: 14,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            color: Color(0xff121319),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 44,
              top: 405,
              child: Container(
                width: 320,
                height: 57,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffb3b3b3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 309,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "비밀번호 입력",
                                      hintStyle: TextStyle(
                                        color: Color(0xffb3b3b3),
                                        fontSize: 14,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Color(0xffb3b3b3),
                                      fontSize: 14,
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 455,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          Text(
                            "로그인 상태 유지",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 47,
              top: 520,

              child: Container(
                width: 320,
                height: 50,
                decoration: BoxDecoration(

                  color: Colors.black,
                ),
                // padding: const EdgeInsets.only(
                //   left: 32,
                //   right: 39,
                //   top: 15,
                //   bottom: 20,
                // ),
                child: TextButton(
                  //


                  onPressed: () async {
                    final dio = Dio(); // Dio 객체 생성

                    final url = 'http://13.209.160.87:8080/login';
                    final data = {
                      'email': email,
                      'password': password,
                    };

                    try {
                      final response = await dio.post(
                        url,
                        options: Options(
                          headers: {'Content-Type': 'application/json'},
                        ),
                        data: data,
                      );

                      if (response.statusCode == 200) {
                        var responseData = response.data;
                        var accessToken = responseData['data']['accessToken'];
                        print(accessToken);

                        // shared_preferences를 사용하여 accessToken 안전하게 저장
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('accessToken', accessToken);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PhotoBoard()),
                        );

                        // Request successful
                        print('Data sent successfully.');
                      } else {
                        // Request failed
                        print('Failed to send data. Status code: ${response.statusCode}');
                      }
                    } catch (e) {
                      // Handle any exceptions that might occur during the API call
                      print('Error: $e');
                    }
                  },



                  //     if (await isKakaoTalkInstalled()) {
                  //       try {
                  //         await UserApi.instance.loginWithKakaoTalk();
                  //         print('카카오톡으로 로그인 성공');
                  //       } catch (error) {
                  //         print('카카오톡으로 로그인 실패 $error');
                  //
                  //         // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                  //         // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                  //         if (error is PlatformException && error.code == 'CANCELED') {
                  //           return;
                  //         }
                  //         // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                  //         try {
                  //           await UserApi.instance.loginWithKakaoAccount();
                  //           print('카카오계정으로 로그인 성공');
                  //         } catch (error) {
                  //           print('카카오계정으로 로그인 실패 $error');
                  //         }
                  //       }
                  //     } else {
                  //       try {
                  //         await UserApi.instance.loginWithKakaoAccount();
                  //         print('카카오계정으로 로그인 성공');
                  //       } catch (error) {
                  //         print('카카오계정으로 로그인 실패 $error');
                  //       }
                  //     }
                  //
                  // },
                  // onPressed: () async {
                  //   final url =
                  //       'https://kauth.kakao.com/oauth/authorize?client_id=179011b75542e1a21fa2207d50a4df57&redirect_uri=http://localhost:8080/auth/kakao/callback&response_type=code';
                  //   if (await canLaunch(url)) {
                  //     await launch(url);
                  //   } else {
                  //     throw 'Could not launch $url';
                  //   }
                  // },

                  child: Text(
                    "로그인",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 88,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "이메일 찾기",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 156,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "|",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 171,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "비밀번호 찾기",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 88,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(

                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "이메일 찾기",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 251,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "|",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),



            Positioned(
              left: 270,
              top: 575,
              child: GestureDetector(
                onTap: () {
                  // Handle the sign-up button tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdRoute()),
                  );
                },
                child: Container(
                  width: 320,
                  height: 57,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "회원가입",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              left: 94,
              top: 709,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "SNS 계정으로 간편하게 로그인하세요.",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Positioned(
              left: 110,
              top: 740,
              child: Container(
                width: 400,
                height: 57,
                child: Column(

                  children: [
                    Container(
                      width: 400,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.zero,
                            ),
                            child: Image.asset(
                              'images/kakao_login_medium_narrow.png',  // 이미지 경로 및 파일명으로 수정해야 합니다.
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Positioned(
              left: 56,
              top: 202,
              child: Container(
                width: 284,
                height: 67,
                child: Image.asset('images/logos.png', width: 67),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 414,
                  height: 49,
                  padding: const EdgeInsets.only(
                    left: 33,
                    right: 15,
                    bottom: 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 28.43,
                        height: 11.09,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff121319),
                        ),
                      ),
                      SizedBox(width: 25.89),
                      Container(
                        width: 66.66,
                        height: 11.34,
                        child: Stack(
                          children: [
                            Container(
                              width: 24.33,
                              height: 11.33,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FlutterLogo(
                                size: 11.333333015441895,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 37,
              top: 510,
              child: Container(
                width: 333,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//
//
//
// //
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:vector_math/vector_math_64.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
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
// //   vector.Vector3? lastPosition;
// //   List<ARKitNode> addedNodes = [];
// //   List<File> pickedImages = [];
// //
// //   @override
// //   void dispose() {
// //     arkitController?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Manipulation Sample'),
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //         ),
// //       ),
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
// //         onPressed: _pickImagesFromGallery,
// //         child: Icon(Icons.photo),
// //       ),
// //     );
// //   }
// //
// //   void _onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //     addNode();
// //     setBackgroundImage('images/frame.jpeg');
// //   }
// //
// //   void addNode() {
// //     final defaultImage = AssetImage('images/star.jpeg');
// //
// //     final defaultMaterial = ARKitMaterial(
// //       diffuse: ARKitMaterialImage(defaultImage.assetName),
// //       doubleSided: true,
// //     );
// //
// //     final defaultGeometry = ARKitSphere(
// //       radius: 0.25,
// //       materials: [defaultMaterial],
// //     );
// //
// //     final defaultNode = ARKitNode(
// //       geometry: defaultGeometry,
// //       position: vector.Vector3(0, 0, -0.5),
// //     );
// //
// //     arkitController?.add(defaultNode);
// //     imageNode = defaultNode;
// //     addedNodes.add(defaultNode);
// //   }
// //
// //   void setBackgroundImage(String imagePath) {
// //     final material = ARKitMaterial(
// //       diffuse: ARKitMaterialProperty.image(imagePath),
// //       doubleSided: true,
// //     );
// //
// //     final box = ARKitBox(
// //       materials: [material],
// //       width: 10,  // Adjust the width of the box
// //       height: 10, // Adjust the height of the box
// //       length: 10, // Adjust the length of the box
// //     );
// //
// //     final node = ARKitNode(
// //       geometry: box,
// //       position: Vector3.zero(),
// //       eulerAngles: Vector3.zero(),
// //     );
// //     this.arkitController?.add(node);
// //   }
// //
// // //     final backgroundMaterial = ARKitMaterial(
// // //       diffuse: ARKitMaterialProperty.image('images/Group.png'),
// // //     );
// // //
// // //     final sphere = ARKitSphere(
// // //       materials: [material],
// // //       radius: 1,
// // //     );
// // //
// // //     final node = ARKitNode(
// // //       geometry: sphere,
// // //       position: Vector3.zero(),
// // //       eulerAngles: Vector3.zero(),
// // //     );
// // //     arkitController?.add(node);
// //
// //
// //
// //
// //   void _onPanStart(DragStartDetails details) {
// //     if (imageNode != null) {
// //       isDragging = true;
// //       lastPosition = imageNode!.position;
// //     }
// //   }
// //
// //   void _onPanUpdate(DragUpdateDetails details) {
// //     if (isDragging && imageNode != null) {
// //       final currentPosition = imageNode!.position;
// //       final newPosition = vector.Vector3(
// //         currentPosition.x + details.delta.dx / 1000,
// //         currentPosition.y - details.delta.dy / 1000,
// //         currentPosition.z,
// //       );
// //
// //       imageNode!.position = newPosition;
// //
// //       // Update position for newly added images
// //       for (final node in addedNodes) {
// //         if (node != imageNode && node.geometry is ARKitSphere) {
// //           final nodePosition = node.position;
// //           final newNodePosition = vector.Vector3(
// //             nodePosition.x - details.delta.dx / 1000,
// //             // Reverse the direction of movement
// //             nodePosition.y + details.delta.dy / 1000,
// //             // Reverse the direction of movement
// //             nodePosition.z,
// //           );
// //
// //           node.position = newNodePosition;
// //         }
// //       }
// //     }
// //   }
// //
// //   void _onPanEnd(DragEndDetails details) {
// //     isDragging = false;
// //     lastPosition = null;
// //   }
// //
// //   Future<void> _pickImagesFromGallery() async {
// //     final picker = ImagePicker();
// //     final pickedFiles = await picker.pickMultiImage();
// //
// //     if (pickedFiles != null) {
// //       setState(() {
// //         pickedImages =
// //             pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
// //       });
// //
// //       for (final imageFile in pickedImages) {
// //         final imageNodePosition = imageNode?.position ?? vector.Vector3.zero();
// //         final material = ARKitMaterial(
// //           diffuse: ARKitMaterialImage(imageFile.path),
// //           doubleSided: true,
// //         );
// //
// //         final geometry = ARKitSphere(
// //           radius: 0.4,
// //           materials: [material],
// //         );
// //
// //         final node = ARKitNode(
// //           geometry: geometry,
// //           position: imageNodePosition + vector.Vector3(0.2, 0, 0),
// //         );
// //
// //         arkitController?.add(node);
// //         addedNodes.add(node);
// //       }
// //     }
// //   }
// // }
//
// //
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart';
// //
// // void main() {
// // runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// // const MyApp({Key? key}) : super(key: key);
// //
// // @override
// // Widget build(BuildContext context) {
// // return MaterialApp(
// // home:  PanoramaPage(),
// // );
// // }
// // }
// //
// //
// // class PanoramaPage extends StatefulWidget {
// //   @override
// //   _PanoramaPageState createState() => _PanoramaPageState();
// // }
// //
// // class _PanoramaPageState extends State<PanoramaPage> {
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
// //     appBar: AppBar(title: const Text('Panorama Sample')),
// //     body: Container(
// //       child: ARKitSceneView(
// //         onARKitViewCreated: onARKitViewCreated,
// //       ),
// //     ),
// //   );
// //
// //   void onARKitViewCreated(ARKitController arkitController) {
// //     this.arkitController = arkitController;
// //
// //     final material = ARKitMaterial(
// //       diffuse: ARKitMaterialProperty.image('images/4466.jpg'),
// //       doubleSided: true,
// //     );
// //     final sphere = ARKitSphere(
// //       materials: [material],
// //       radius: 1,
// //     );
// //
// //     final node = ARKitNode(
// //       geometry: sphere,
// //       position: Vector3.zero(),
// //       eulerAngles: Vector3.zero(),
// //     );
// //     this.arkitController.add(node);
// //   }
// // }
//
//
// //사진 선택 가능
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:vector_math/vector_math_64.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
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
// //   vector.Vector3? lastPosition;
// //   List<ARKitNode> addedNodes = [];
// //   List<String> specifiedImages = [];
// //
// //   @override
// //   void dispose() {
// //     arkitController?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Manipulation Sample'),
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //         ),
// //       ),
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
// //         onPressed: _addImagesFromList,
// //         child: Icon(Icons.photo),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //       bottomNavigationBar: specifiedImages.isEmpty
// //           ? null
// //           : Container(
// //         height: 100,
// //         child: ListView.builder(
// //           scrollDirection: Axis.horizontal,
// //           itemCount: specifiedImages.length,
// //           itemBuilder: (context, index) {
// //             return Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Image.asset(
// //                 specifiedImages[index],
// //                 width: 80,
// //                 height: 80,
// //                 fit: BoxFit.cover,
// //               ),
// //             );
// //           },
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
// //     final defaultMaterial = ARKitMaterial(
// //       diffuse: ARKitMaterialProperty.color(Color(0xFFFF0000)), // Set the color to red
// //       doubleSided: true,
// //     );
// //
// //     final defaultGeometry = ARKitSphere(
// //       radius: 0.25,
// //       materials: [defaultMaterial],
// //     );
// //
// //     final defaultNode = ARKitNode(
// //       geometry: defaultGeometry,
// //       position: vector.Vector3(0, 0, -0.5),
// //     );
// //
// //     arkitController?.add(defaultNode);
// //     imageNode = defaultNode;
// //     addedNodes.add(defaultNode);
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
// //     if (isDragging && imageNode != null) {
// //       final currentPosition = imageNode!.position;
// //       final newPosition = vector.Vector3(
// //         currentPosition.x + details.delta.dx / 1000,
// //         currentPosition.y - details.delta.dy / 1000,
// //         currentPosition.z,
// //       );
// //
// //       imageNode!.position = newPosition;
// //
// //       for (final node in addedNodes) {
// //         if (node != imageNode && node.geometry is ARKitSphere) {
// //           final nodePosition = node.position;
// //           final newNodePosition = vector.Vector3(
// //             nodePosition.x - details.delta.dx / 1000,
// //             nodePosition.y + details.delta.dy / 1000,
// //             nodePosition.z,
// //           );
// //
// //           node.position = newNodePosition;
// //         }
// //       }
// //     }
// //   }
// //
// //   void _onPanEnd(DragEndDetails details) {
// //     isDragging = false;
// //     lastPosition = null;
// //   }
// //
// //   void _addImagesFromList() {
// //     // Add the specified images to the specifiedImages list
// //     specifiedImages.addAll([
// //       'images/wall.jpg',
// //       'images/frame.jpeg',
// //       'images/key.png',
// //       'images/wall.jpg',
// //       'images/frame.jpeg',
// //       'images/key.png',
// //       'images/wall.jpg',
// //       'images/frame.jpeg',
// //       'images/key.png',
// //     ]);
// //
// //     for (final imagePath in specifiedImages) {
// //       final imageNodePosition = imageNode?.position ?? vector.Vector3.zero();
// //       final material = ARKitMaterial(
// //         diffuse: ARKitMaterialProperty.image(imagePath),
// //         doubleSided: true,
// //       );
// //
// //       final geometry = ARKitSphere(
// //         radius: 0.4,
// //         materials: [material],
// //       );
// //
// //       final node = ARKitNode(
// //         geometry: geometry,
// //         position: imageNodePosition + vector.Vector3(0.2, 0, 0),
// //       );
// //
// //       arkitController?.add(node);
// //       addedNodes.add(node);
// //     }
// //
// //     setState(() {});
// //   }
// // }
// //
//
// // 실행 되는 코드
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:vector_math/vector_math_64.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: ManipulationPage(),
// //     );
// //   }
// // }
// //
// //
// //
// // class ManipulationPage extends StatefulWidget {
// //   @override
// //   _ManipulationPageState createState() => _ManipulationPageState();
// // }
// //
// // class _ManipulationPageState extends State<ManipulationPage> {
// //   ARKitController? arkitController;
// //   ARKitNode? imageNode;
// //   ARKitNode? textNode = null;
// //   bool isDragging = false;
// //   vector.Vector3? lastPosition;
// //   List<ARKitNode> addedNodes = [];
// //   List<File> pickedImages = [];
// //   double scale = 1.0;
// //   double previousScale = 1.0;
// //   bool isSphere = false; // Added variable to track shape type
// //
// //   List<String> predefinedImages = [
// //     'images/gogh1.jpeg',
// //     'images/gogh2.jpeg',
// //     'images/gogh3.jpeg',
// //     'images/gogh4.jpeg',
// //     'images/gogh5.jpeg',
// //     'images/star.jpeg',
// //
// //     // Add more image paths here
// //   ];
// //   List<String> predefinedImages2 = [
// //     'images/ko1.jpeg',
// //     'images/ko2.jpeg',
// //     'images/ko3.jpeg',
// //     'images/ko4.jpeg',
// //     'images/ko5.jpeg',
// //     'images/ko6.jpeg',
// //     // Add more image paths here
// //   ];
// //   @override
// //   void dispose() {
// //     arkitController?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Color.fromRGBO(0, 0, 0, 0), // Transparent black color.transparent,
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //         ),
// //       ),
// //       body: Container(
// //         child: GestureDetector(
// //           onPanStart: _onPanStart,
// //           onPanUpdate: _onPanUpdate,
// //           child: ARKitSceneView(
// //             onARKitViewCreated: _onARKitViewCreated,
// //           ),
// //         ),
// //       ),
// //       floatingActionButton: Column(
// //         mainAxisAlignment: MainAxisAlignment.end,
// //         children: [
// //           FloatingActionButton(
// //             onPressed: _showPredefinedImages,
// //             child: Icon(Icons.photo),
// //           ),
// //           SizedBox(height: 16),
// //           FloatingActionButton(
// //             onPressed: _toggleShape, // Added conversion button
// //             child: Icon(Icons.transform),
// //           ),
// //         ],
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
// //     final defaultImage = AssetImage('images/star.jpeg');
// //
// //     final defaultMaterial = ARKitMaterial(
// //       diffuse: ARKitMaterialImage(defaultImage.assetName),
// //       doubleSided: true,
// //     );
// //
// //     final defaultGeometry = ARKitPlane(
// //       width: 0.8,
// //       height: 0.8,
// //       materials: [defaultMaterial],
// //     );
// //
// //     final defaultNode = ARKitNode(
// //       geometry: defaultGeometry,
// //       position: vector.Vector3(0, 0, -0.7),
// //     );
// //     arkitController?.add(defaultNode);
// //     imageNode = defaultNode;
// //     addedNodes.add(defaultNode);
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
// //     if (isDragging && imageNode != null) {
// //       final currentPosition = imageNode!.position;
// //       final newPosition = vector.Vector3(
// //         currentPosition.x + details.delta.dx / 1000,
// //         currentPosition.y - details.delta.dy / 1000,
// //         currentPosition.z,
// //       );
// //
// //       imageNode!.position = newPosition;
// //
// //       // Update position for newly added images
// //       for (final node in addedNodes) {
// //         if (node != imageNode && node.geometry is ARKitPlane) {
// //           final nodePosition = node.position;
// //           final newNodePosition = vector.Vector3(
// //             nodePosition.x - details.delta.dx / 1000,
// //             nodePosition.y + details.delta.dy / 1000,
// //             nodePosition.z,
// //           );
// //
// //           node.position = newNodePosition;
// //         }
// //       }
// //     }
// //   }
// //
// //     void _showPredefinedImages() {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (BuildContext context) {
// //         final int imagesPerPage = 9;
// //         final int pageCount = (predefinedImages.length / imagesPerPage).ceil();
// //
// //         return StatefulBuilder(
// //           builder: (BuildContext context, StateSetter setState) {
// //             return Container(
// //               height: 250,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.only(
// //                   topLeft: Radius.circular(16),
// //                   topRight: Radius.circular(16),
// //                 ),
// //               ),
// //               child: Stack(
// //                 children: [
// //                   Positioned.fill(
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         color: Color(0xffa1a1a1).withOpacity(1), // Set the desired background color and opacity
// //                         borderRadius: BorderRadius.only(
// //                           topLeft: Radius.circular(16),
// //                           topRight: Radius.circular(16),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   Column(
// //                     children: [
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                         children: [
// //                           ElevatedButton(
// //                             onPressed: () {
// //                               setState(() {
// //                                 predefinedImages = predefinedImages2;
// //                               });
// //                             },
// //                             style: ButtonStyle(
// //                               backgroundColor: MaterialStateProperty.all<Color>(Color(
// //                                   0xff5d5d5d)), // Set the desired background color
// //                             ),
// //                             child: Text('동양화'),
// //                           ),
// //                           ElevatedButton(
// //                             onPressed: () {
// //                               setState(() {
// //                                 predefinedImages = predefinedImages;
// //                               });
// //                             },
// //                             style: ButtonStyle(
// //                               backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5d5d5d)), // Set the desired background color
// //                             ),
// //                             child: Text('서양화'),
// //                           ),
// //                           ElevatedButton(
// //                             onPressed: () {
// //                               _showUserPhotoAlbum();
// //                             },
// //                             style: ButtonStyle(
// //                               backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5d5d5d)), // Set the desired background color
// //                             ),
// //                             child: Text('갤러리'),
// //                           ),
// //                         ],
// //                       ),
// //                       Expanded(
// //                         child: ClipRRect(
// //                           borderRadius: BorderRadius.only(
// //                             topLeft: Radius.circular(16),
// //                             topRight: Radius.circular(16),
// //                           ),
// //                           child: PageView.builder(
// //                             itemCount: pageCount,
// //                             itemBuilder: (context, pageIndex) {
// //                               final startIndex = pageIndex * imagesPerPage;
// //                               final endIndex = (startIndex + imagesPerPage) < predefinedImages.length
// //                                   ? (startIndex + imagesPerPage)
// //                                   : predefinedImages.length;
// //                               final pageImages = predefinedImages.sublist(startIndex, endIndex);
// //
// //                               return GridView.count(
// //                                 crossAxisCount: 3,
// //                                 padding: EdgeInsets.all(8),
// //                                 crossAxisSpacing: 8,
// //                                 children: List.generate(pageImages.length, (index) {
// //                                   final imagePath = pageImages[index];
// //                                   return GestureDetector(
// //                                     onTap: () {
// //                                       _addImageNode(imagePath);
// //                                       Navigator.pop(context);
// //                                     },
// //                                     child: GridTile(
// //                                       child: Image.asset(imagePath),
// //                                     ),
// //                                   );
// //                                 }),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   Future<void> _showUserPhotoAlbum() async {
// //     final picker = ImagePicker();
// //     final pickedImage = await picker.getImage(source: ImageSource.gallery);
// //
// //     if (pickedImage != null) {
// //       _addImageNode(pickedImage.path);
// //     }
// //   }
// //
// //
// //
// //   void _addImageNode(String imagePath) {
// //     // Remove previous image node and text node if they exist
// //     if (imageNode != null) {
// //       arkitController?.remove(imageNode!.name);
// //       addedNodes.remove(imageNode);
// //     }
// //
// //
// //     final imageNodePosition = imageNode?.position ?? vector.Vector3.zero();
// //     final material = ARKitMaterial(
// //       diffuse: ARKitMaterialImage(imagePath),
// //       doubleSided: true,
// //     );
// //
// //     final geometry = isSphere
// //         ? ARKitSphere(radius: 0.15, materials: [material])
// //         : ARKitPlane(width: 0.5, height: 0.5, materials: [material]);
// //
// //     final node = ARKitNode(
// //       geometry: geometry,
// //       position: imageNodePosition + vector.Vector3(0.5, 0, 0),
// //     );
// //
// //     arkitController?.add(node);
// //     imageNode = node;
// //     addedNodes.add(node);
// //
// //     // Add text node
// //     final textGeometry = ARKitText(
// //       text: 'Image Selected', // Customize the text content as desired
// //       extrusionDepth: 1,
// //       materials: [ARKitMaterial(
// //         diffuse: ARKitMaterialColor(Color(0xffb3b3b3)),
// //       )],
// //     );
// //
// //     final textNodePosition = imageNode!.position + vector.Vector3(0, -0.15, 0); // Adjust the position of the text node relative to the image node
// //     final textNode = ARKitNode(
// //       geometry: textGeometry,
// //       position: textNodePosition,
// //       eulerAngles: vector.Vector3.zero(),
// //     );
// //
// //     arkitController?.add(textNode);
// //     addedNodes.add(textNode);
// //   }
// //
// //
// //
// //   void _toggleShape() {
// //     setState(() {
// //       isSphere = !isSphere;
// //       if (imageNode != null) {
// //         final imagePath = (imageNode?.geometry?.materials.value?.first?.diffuse as ARKitMaterialImage?)?.image;
// //         final material = ARKitMaterial(
// //           diffuse: ARKitMaterialImage(imagePath ?? ''),
// //           doubleSided: true,
// //         );
// //
// //         final geometry = isSphere
// //             ? ARKitSphere(radius: 0.25, materials: [material])
// //             : ARKitPlane(width: 0.5, height: 0.5, materials: [material]);
// //
// //         final newNode = ARKitNode(
// //           geometry: geometry,
// //           position: imageNode!.position,
// //         );
// //
// //         for (final node in addedNodes) {
// //           arkitController?.remove(node.name);
// //         }
// //         addedNodes.clear();
// //
// //         arkitController?.remove(imageNode!.name);
// //         arkitController?.add(newNode);
// //         imageNode = newNode;
// //         addedNodes.add(newNode);
// //       }
// //     });
// //   }
// //
// // }
//
//
// //AR
//
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:arkit_plugin/arkit_plugin.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:vector_math/vector_math_64.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: "Pocket Art",
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
// //   ARKitNode? textNode;
// //   bool isDragging = false;
// //   Vector3? lastPosition;
// //   List<ARKitNode> addedNodes = [];
// //   List<File> pickedImages = [];
// //   double scale = 1.0;
// //   double previousScale = 1.0;
// //   bool isSphere = false; // Added variable to track shape type
// //
// //   List<String> predefinedImages = [
// //     'images/gogh1.jpeg',
// //     'images/gogh2.jpeg',
// //     'images/gogh3.jpeg',
// //     'images/gogh4.jpeg',
// //     'images/gogh5.jpeg',
// //     'images/star.jpeg',
// //     // Add more image paths here
// //   ];
// //
// //   List<String> predefinedImages2 = [
// //     'images/ko1.jpeg',
// //     'images/ko2.jpeg',
// //     'images/ko3.jpeg',
// //     'images/ko4.jpeg',
// //     'images/ko5.jpeg',
// //     'images/ko6.jpeg',
// //     // Add more image paths here
// //   ];
// //
// //   @override
// //   void dispose() {
// //     arkitController?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Color.fromRGBO(0, 0, 0, 0), // Transparent black color
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //         ),
// //       ),
// //       body: Container(
// //         child: GestureDetector(
// //           onPanStart: _onPanStart,
// //           onPanUpdate: _onPanUpdate,
// //           child: ARKitSceneView(
// //             onARKitViewCreated: _onARKitViewCreated,
// //           ),
// //         ),
// //       ),
// //       floatingActionButton: Column(
// //         mainAxisAlignment: MainAxisAlignment.end,
// //         children: [
// //           FloatingActionButton(
// //             onPressed: _showPredefinedImages,
// //             child: Icon(Icons.photo),
// //           ),
// //           SizedBox(height: 16),
// //           FloatingActionButton(
// //             onPressed: _toggleShape, // Added conversion button
// //             child: Icon(Icons.transform),
// //           ),
// //         ],
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
// //     final defaultImage = AssetImage('images/star.jpeg');
// //
// //     final defaultMaterial = ARKitMaterial(
// //       diffuse: ARKitMaterialImage(defaultImage.assetName),
// //       doubleSided: true,
// //     );
// //
// //     final defaultGeometry = ARKitPlane(
// //       width: 0.5,
// //       height: 0.5,
// //       materials: [defaultMaterial],
// //     );
// //
// //     final defaultNode = ARKitNode(
// //       geometry: defaultGeometry,
// //       position: Vector3(0, 0, -0.7),
// //     );
// //     arkitController?.add(defaultNode);
// //     imageNode = defaultNode;
// //     addedNodes.add(defaultNode);
// //   }
// //     void _onPanStart(DragStartDetails details) {
// //     if (imageNode != null) {
// //       isDragging = true;
// //       lastPosition = imageNode!.position;
// //     }
// //   }
// //
// //   void _onPanUpdate(DragUpdateDetails details) {
// //     if (isDragging && imageNode != null) {
// //       final currentPosition = imageNode!.position;
// //       final newPosition = vector.Vector3(
// //         currentPosition.x + details.delta.dx / 1000,
// //         currentPosition.y - details.delta.dy / 1000,
// //         currentPosition.z,
// //       );
// //
// //       imageNode!.position = newPosition;
// //
// //       // Update position for newly added images
// //       for (final node in addedNodes) {
// //         if (node != imageNode && node.geometry is ARKitPlane) {
// //           final nodePosition = node.position;
// //           final newNodePosition = vector.Vector3(
// //             nodePosition.x - details.delta.dx / 1000,
// //             nodePosition.y + details.delta.dy / 1000,
// //             nodePosition.z,
// //           );
// //
// //           node.position = newNodePosition;
// //         }
// //       }
// //     }
// //   }
// //
// //   // void _onPanStart(DragStartDetails details) {
// //   //   if (imageNode != null) {
// //   //     isDragging = true;
// //   //     lastPosition = imageNode!.position;
// //   //   }
// //   // }
// //   //
// //   // void _onPanUpdate(DragUpdateDetails details) {
// //   //   if (isDragging && imageNode != null) {
// //   //     final currentPosition = imageNode!.position;
// //   //     final newPosition = Vector3(
// //   //       currentPosition.x + details.delta.dx / 1000,
// //   //       currentPosition.y - details.delta.dy / 1000,
// //   //       currentPosition.z,
// //   //     );
// //   //
// //   //     imageNode!.position = newPosition;
// //   //
// //   //     // Update position for newly added images
// //   //     for (final node in addedNodes) {
// //   //       if (node != imageNode && node.geometry is ARKitPlane) {
// //   //         final nodePosition = node.position;
// //   //         final newNodePosition = Vector3(
// //   //           nodePosition.x - details.delta.dx / 1000,
// //   //           nodePosition.y + details.delta.dy / 1000,
// //   //           nodePosition.z,
// //   //         );
// //   //
// //   //         node.position = newNodePosition;
// //   //       }
// //   //     }
// //   //   }
// //   // }
// //
// //   void _showPredefinedImages() {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (BuildContext context) {
// //         final int imagesPerPage = 9;
// //         final int pageCount = (predefinedImages.length / imagesPerPage).ceil();
// //
// //         return StatefulBuilder(
// //           builder: (BuildContext context, StateSetter setState) {
// //             return Container(
// //               height: 250,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.only(
// //                   topLeft: Radius.circular(16),
// //                   topRight: Radius.circular(16),
// //                 ),
// //               ),
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     padding: EdgeInsets.all(16),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         ClipOval(
// //                           child: Container(
// //                             color: Color(0xff5d5d5d), // 원하는 배경 색상 설정
// //                             child: IconButton(
// //                               onPressed: () {
// //                                 setState(() {
// //                                   predefinedImages = predefinedImages2;
// //                                 });
// //                               },
// //                               icon: Icon(Icons.brush),
// //                               color: Color(0xff7e1111), // 아이콘 색상 설정
// //                             ),
// //                           ),
// //                         ),
// //                         ClipOval(
// //                           child: Container(
// //                             color: Color(0xff5d5d5d), // 원하는 배경 색상 설정
// //                             child: IconButton(
// //                               onPressed: () {
// //                                 setState(() {
// //                                   predefinedImages = predefinedImages;
// //                                 });
// //                               },
// //                               icon: Icon(Icons.palette),
// //                               color: Color(0xff801d1d), // 아이콘 색상 설정
// //                             ),
// //                           ),
// //                         ),
// //                         ClipOval(
// //                           child: Container(
// //                             color: Color(0xff5d5d5d), // 원하는 배경 색상 설정
// //                             child: IconButton(
// //                               onPressed: () {
// //                                 _showUserPhotoAlbum();
// //                               },
// //                               icon: Icon(Icons.photo),
// //                               color: Color(0xff673333), // 아이콘 색상 설정
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Expanded(
// //                     child: ClipRRect(
// //                       borderRadius: BorderRadius.only(
// //                         topLeft: Radius.circular(16),
// //                         topRight: Radius.circular(16),
// //                       ),
// //                       child: PageView.builder(
// //                         itemCount: pageCount,
// //                         itemBuilder: (context, pageIndex) {
// //                           final startIndex = pageIndex * imagesPerPage;
// //                           final endIndex = (startIndex + imagesPerPage) < predefinedImages.length
// //                               ? (startIndex + imagesPerPage)
// //                               : predefinedImages.length;
// //                           final pageImages = predefinedImages.sublist(startIndex, endIndex);
// //
// //                           return GridView.count(
// //                             crossAxisCount: 3,
// //                             padding: EdgeInsets.all(8),
// //                             crossAxisSpacing: 8,
// //                             children: List.generate(pageImages.length, (index) {
// //                               final imagePath = pageImages[index];
// //                               return GestureDetector(
// //                                 onTap: () {
// //                                   _addImageNode(imagePath);
// //                                   Navigator.pop(context);
// //                                 },
// //                                 child: GridTile(
// //                                   child: Image.asset(imagePath),
// //                                 ),
// //                               );
// //                             }),
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //
// //   Future<void> _showUserPhotoAlbum() async {
// //     final picker = ImagePicker();
// //     final pickedImage = await picker.getImage(source: ImageSource.gallery);
// //
// //     if (pickedImage != null) {
// //       _addImageNode(pickedImage.path);
// //     }
// //   }
// //   void _addImageNode(String imagePath) {
// //     // Remove previous image node and text node if they exist
// //     if (imageNode != null) {
// //       arkitController?.remove(imageNode!.name);
// //       addedNodes.remove(imageNode);
// //     }
// //
// //
// //     final imageNodePosition = imageNode?.position ?? vector.Vector3.zero();
// //     final material = ARKitMaterial(
// //       diffuse: ARKitMaterialImage(imagePath),
// //       doubleSided: true,
// //     );
// //
// //     final geometry = isSphere
// //         ? ARKitSphere(radius: 0.15, materials: [material])
// //         : ARKitPlane(width: 0.5, height: 0.5, materials: [material]);
// //
// //     final node = ARKitNode(
// //       geometry: geometry,
// //       position: imageNodePosition + vector.Vector3(0.5, 0, 0),
// //     );
// //
// //     arkitController?.add(node);
// //     imageNode = node;
// //     addedNodes.add(node);
// //
// //     // Add text node
// //     final textGeometry = ARKitText(
// //       text: '', // Customize the text content as desired
// //       extrusionDepth: 1,
// //       materials: [ARKitMaterial(
// //         diffuse: ARKitMaterialColor(Color(0xffb3b3b3)),
// //       )],
// //     );
// //
// //     final textNodePosition = imageNode!.position + vector.Vector3(0, -0.15, 0); // Adjust the position of the text node relative to the image node
// //     final textNode = ARKitNode(
// //       geometry: textGeometry,
// //       position: textNodePosition,
// //       eulerAngles: vector.Vector3.zero(),
// //     );
// //
// //     arkitController?.add(textNode);
// //     addedNodes.add(textNode);
// //   }
// //
// //
// //   void _toggleShape() {
// //     setState(() {
// //       isSphere = !isSphere;
// //       if (imageNode != null) {
// //         final imagePath = (imageNode?.geometry?.materials.value?.first?.diffuse as ARKitMaterialImage?)?.image;
// //         final material = ARKitMaterial(
// //           diffuse: ARKitMaterialImage(imagePath ?? ''),
// //           doubleSided: true,
// //         );
// //
// //         final geometry = isSphere
// //             ? ARKitSphere(radius: 0.25, materials: [material])
// //             : ARKitPlane(width: 0.5, height: 0.5, materials: [material]);
// //
// //         final newNode = ARKitNode(
// //           geometry: geometry,
// //           position: imageNode!.position,
// //         );
// //
// //         for (final node in addedNodes) {
// //           arkitController?.remove(node.name);
// //         }
// //         addedNodes.clear();
// //
// //         arkitController?.remove(imageNode!.name);
// //         arkitController?.add(newNode);
// //         imageNode = newNode;
// //         addedNodes.add(newNode);
// //       }
// //     });
// //   }
// //
// // }
// //
// //
// //

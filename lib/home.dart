
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:async';
import 'dart:ui' as ui;


void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
          Frame427320811(),
        ),
      );
  }
}

class Frame427320811 extends StatefulWidget {
  @override
  _MyCanvasState createState() => _MyCanvasState();
}

enum BrushShape {
  Circle, // 점
  Line,   // 선
  Square, //
}

class _MyCanvasState extends State<Frame427320811> {
  List<Offset?> points = <Offset?>[];
  Color selectedColor = Colors.black; // Default color
  ui.Image? edgeImage;
  Uint8List? edgeImageBytes;

  // 브러쉬 모양 결정
  BrushShape selectedBrushShape = BrushShape.Circle; // Initial brush shape
  Map<BrushShape, List<Offset>> brushPoints = {
    BrushShape.Circle: [],
    BrushShape.Line: [],
    BrushShape.Square: [],
  };

  Map<Color, Map<BrushShape, List<Offset>>> colorPoints = {
    Colors.black: {
      BrushShape.Circle: [],
      BrushShape.Line: [],
      BrushShape.Square: [],
    },
  };

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      final selectedPoints = brushPoints[selectedBrushShape]; // Get points for selected brush
      final localPosition = renderBox.globalToLocal(details.globalPosition);

      // Ensure that the selectedPoints list is not null
      if (selectedPoints != null) {
        // Add the current drawing point to the selected brush shape's points
        selectedPoints.add(localPosition);
        // Update the points for the selected color and brush shape
        colorPoints[selectedColor]![selectedBrushShape] = selectedPoints;
      }
    });
  }


  void _changeColor(Color newColor) {
    setState(() {
      selectedColor = newColor;
    });
  }

  void _changeBrushShape(BrushShape newBrushShape) {
    setState(() {
      selectedBrushShape = newBrushShape;
    });
  }


  @override
  void initState() {
    super.initState();
    loadImage();
  }

  // Load the "edge.jpeg" image
  Future<void> loadImage() async {
    final imageProvider = AssetImage('images/edge.jpeg');
    final image = await loadImageFromProvider(imageProvider);

    // Convert the image to bytes
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    edgeImageBytes = byteData!.buffer.asUint8List();

    setState(() {
      edgeImage = image;
    });
  }




  Future<ui.Image> loadImageFromProvider(ImageProvider provider) async {
    final completer = Completer<ui.Image>();
    final imageStream = provider.resolve(const ImageConfiguration());

    imageStream.addListener(
      ImageStreamListener(
            (imageInfo, _) {
          completer.complete(imageInfo.image);
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          completer.completeError(exception, stackTrace);
        },
      ),
    );

    return completer.future;
  }

  void openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 844,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 9,
                top: 759,
                child: Container(
                  width: 434,
                  height: 81,
                  decoration: BoxDecoration(color: Color(0xFFEAEAEA)),

                ),
              ),
              Positioned(
                left: 95,
                top: 633,
                child: Container(
                  width: 43,
                  height: 43,
                  decoration: ShapeDecoration(
                    color: Color(0xFFEFEFEF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 390,
                  height: 46,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 308.67,
                        top: 17.33,
                        child: Container(
                          width: 66.66,
                          height: 11.34,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 42.33,
                                top: 0,
                                child: Container(
                                  width: 24.33,
                                  height: 11.33,
                                  child: Stack(children: [
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 42,
                top: 62,
                child: Text(
                  '색칠하기',
                  style: TextStyle(
                    color: Color(0xFF505050),
                    fontSize: 20,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 8,
                top: 96,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(-1.57),
                  child: Container(
                    width: 41,
                    height: 40,
                    padding: const EdgeInsets.only(
                      top: 11.87,
                      left: 7.05,
                      right: 7.05,
                      bottom: 14.37,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      ],
                    ),
                  ),
                ),
              ),Positioned(
                  left: 0,
                  top: 122,
                  child: GestureDetector(
                    onPanUpdate: _onPanUpdate,
                    child: Container(
                      width: 390,
                      height: 390,
                      child: Stack(
                        children: [
                          Image.memory(
                            edgeImageBytes!,
                            width: 500,
                            height: 500,
                            fit: BoxFit.fill,
                          ),
                        CustomPaint(
                          size: Size(500, 500),
                          painter: DrawingPainter(
                            colorPoints: colorPoints,
                            selectedColor: selectedColor,
                            selectedBrushShape: selectedBrushShape,
                          ),
                        ),
                    ],
                      ),
                    ),
                  ),
                ),

              Positioned(
                left: 8,
                top: 755,
                child: TextButton(
                  onPressed: () {
                    // Open the color picker when the button is pressed
                    openColorPicker();
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: ShapeDecoration(
                      color: selectedColor,
                      // color: Color(0xFFE55532),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),),
              Positioned(
                left: 90,
                top: 804,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 90,
                top: 765,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 129,
                top: 804,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFF738A9C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 129,
                top: 765,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFF737D96),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 167,
                top: 804,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFF838184),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 167,
                top: 765,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFF6B696C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 206,
                top: 804,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFC4C2C5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 206,
                top: 765,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFACAAAD),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 245,
                top: 804,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFDFDFDF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 245,
                top: 765,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD7D2D6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 284,
                top: 804,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF88185),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 284,
                top: 765,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFCE5D59),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 322,
                top: 804,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF0967B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 322,
                top: 765,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFF8173),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 361,
                top: 804,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFDE0F39),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 361,
                top: 765,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFFA17B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 599,
                child: SizedBox(
                  width: 91,
                  height: 14,
                  child: Text(
                    '지우개 모드',
                    style: TextStyle(
                      color: Color(0xFF3C3C3C),
                      fontSize: 13,
                      fontFamily: 'Apple SD Gothic Neo',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 648,
                child: SizedBox(
                  width: 91,
                  height: 14,
                  child: Text(
                    '펜 선택',
                    style: TextStyle(
                      color: Color(0xFF3C3C3C),
                      fontSize: 13,
                      fontFamily: 'Apple SD Gothic Neo',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),

              //펜 1, 점
              Positioned(
                left: 100,
                top: 638,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBrushShape = BrushShape.Circle;
                    });
                  },
                child: SizedBox(
                  width: 34,
                  height: 34,
                  child:  Image.asset(
                    'images/pen1.png',
                    width: 34,
                    height: 34,
                  ),
                  ),
                ),
              ),

              //펜 2, 선
              Positioned(
                left: 150,
                top: 638,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBrushShape = BrushShape.Line;
                    });
                  },
                child: SizedBox(
                  width: 34,
                  height: 34,
                  child:  Image.asset(
                    'images/pen2.png',
                    width: 34,
                    height: 34,
                  ),
                ),
              ),
              ),

              //펜 3 ,면
              Positioned(
                left: 200,
                top: 638,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBrushShape = BrushShape.Square;
                    });
                  },
                child: SizedBox(
                  width: 34,
                  height: 34,
                  child:  Image.asset(
                    'images/pen3.png',
                    width: 34,
                    height: 34,
                  ),
                ),
              ),
              ),
              //펜 4 ,채우기
              Positioned(
                left: 250,
                top: 638,
                child: SizedBox(
                  width: 34,
                  height: 34,
                  child:  Image.asset(
                    'images/pen4.png',
                    width: 34,
                    height: 34,
                  ),
                ),
              ),



              Positioned(
                left: 14,
                top: 692,
                child: SizedBox(
                  width: 91,
                  height: 14,
                  child: Text(
                    '펜 두께(1px)',
                    style: TextStyle(
                      color: Color(0xFF3C3C3C),
                      fontSize: 13,
                      fontFamily: 'Apple SD Gothic Neo',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 727,
                child: SizedBox(
                  width: 91,
                  height: 14,
                  child: Text(
                    '투명도(100)',
                    style: TextStyle(
                      color: Color(0xFF3C3C3C),
                      fontSize: 13,
                      fontFamily: 'Apple SD Gothic Neo',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 106,
                top: 599,
                child: Container(
                  width: 30,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 104,
                top: 597,
                child: Container(
                  width: 21,
                  height: 21,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 2,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 521,
                child: Container(
                  width: 366,
                  height: 56,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 366,
                        height: 56,
                        decoration: BoxDecoration(color: Color(0xFFE7E7E7)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 586,
                child: Container(
                  width: 375,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.20,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF868686),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 629,
                child: Container(
                  width: 375,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.20,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF868686),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 681,
                child: Container(
                  width: 375,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.20,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF868686),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 717,
                child: Container(
                  width: 375,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.20,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF868686),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 9,
                top: 750,
                child: Container(
                  width: 375,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.20,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF868686),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 160,
                top: 639,
                child: Container(
                  width: 34,
                  height: 34,
                  padding: const EdgeInsets.all(4.25),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 276,
                top: 639,
                child: Container(
                  width: 34,
                  height: 34,
                  padding: const EdgeInsets.all(2.83),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 336,
                top: 640,
                child: Container(
                  width: 41,
                  padding: const EdgeInsets.only(
                      left: 5.12, right: 5.12, bottom: 11.96),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 96,
                top: 700,
                child: Container(
                  width: 10,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 701,
                child: Container(
                  width: 211,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFD6D6D6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 84,
                top: 665,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(-1.57),
                  child: Container(
                    width: 21,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFBCBCBC),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 84,
                top: 710,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(-1.57),
                  child: Container(
                    width: 21,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFBCBCBC),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 84,
                top: 744,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(-1.57),
                  child: Container(
                    width: 21,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFBCBCBC),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 125,
                top: 694,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: ShapeDecoration(
                    color: Color(0xFF5363FA),
                    shape: OvalBorder(),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 2,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 125,
                top: 693,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: ShapeDecoration(
                    color: Color(0xFF5363FA),
                    shape: OvalBorder(),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 2,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 359,
                top: 691,
                child: Container(
                  width: 19,
                  height: 19,
                  padding: const EdgeInsets.all(3.96),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 96,
                top: 733,
                child: Container(
                  width: 10,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 733,
                child: Container(
                  width: 211,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFD6D6D6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 733,
                child: Container(
                  width: 49,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFF3D4ABE),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 174,
                top: 725,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: ShapeDecoration(
                    color: Color(0xFF5363FA),
                    shape: OvalBorder(),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 2,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 359,
                top: 724,
                child: Container(
                  width: 19,
                  height: 19,
                  padding: const EdgeInsets.all(3.96),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 336,
                top: 60,
                child: Container(
                  width: 37,
                  height: 37,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.62, vertical: 9.25),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 325,
                top: 599,
                child: Container(
                  width: 15.35,
                  height: 13.05,
                  child: Stack(children: [
                  ]),
                ),
              ),
              Positioned(
                left: 376.35,
                top: 599,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(3.14),
                  child: Container(
                    width: 15.35,
                    height: 13.05,
                    child: Stack(children: [
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),

      ],

    );
  }
}
class DrawingPainter extends CustomPainter {
  final Map<Color, Map<BrushShape, List<Offset>>> colorPoints;
  final Color selectedColor; // 사용자가 선택한 색상
  final BrushShape selectedBrushShape; // 사용자가 선택한 브러쉬 모양

  DrawingPainter({
    required this.colorPoints,
    required this.selectedColor,
    required this.selectedBrushShape,
  });


  @override
  @override
  void paint(Canvas canvas, Size size) {
    colorPoints.forEach((color, shapePoints) {
      shapePoints.forEach((shape, points) {
        if (color == selectedColor && shape == selectedBrushShape) {
          final paint = Paint()
            ..color = color
            ..strokeCap = StrokeCap.round
            ..strokeWidth = shape == BrushShape.Square ? 10.0 : 5.0; // Adjust width for different shapes

          for (int i = 0; i < points.length - 1; i++) {
            if (points[i] != null && points[i + 1] != null) {
              if (shape == BrushShape.Line) {
                canvas.drawLine(points[i], points[i + 1], paint);
              } else if (shape == BrushShape.Circle) {
                final radius = _calculateDistance(points[i], points[i + 1]) / 2.0;
                canvas.drawCircle(points[i], radius, paint);
              } else if (shape == BrushShape.Square) {
                final size = _calculateDistance(points[i], points[i + 1]);
                final rect = Rect.fromPoints(
                  points[i],
                  Offset(points[i].dx + size, points[i].dy + size),
                );
                canvas.drawRect(rect, paint);
              }
            }
          }
        }
      });
    });
  }

  double _calculateDistance(Offset p1, Offset p2) {
    final dx = p1.dx - p2.dx;
    final dy = p1.dy - p2.dy;
    return math.sqrt(dx * dx + dy * dy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
//
// void main() => runApp(MyApp());
//
// enum BrushShape { point, line, fill }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '간단한 그림판',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   Color _selectedColor = Colors.black;
//   double _brushSize = 5.0;
//   BrushShape _brushShape = BrushShape.line; // 기본 브러시 모양
//   List<Offset?> _points = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('간단한 그림판'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               width: 300,
//               height: 300,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black),
//               ),
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   setState(() {
//                     RenderBox renderBox = context.findRenderObject() as RenderBox;
//                     _points.add(renderBox.globalToLocal(details.globalPosition));
//                   });
//                 },
//                 onPanEnd: (details) {
//                   _points.add(null);
//                 },
//                 child: CustomPaint(
//                   painter: MyPainter(
//                     points: _points,
//                     color: _selectedColor,
//                     brushSize: _brushSize,
//                     brushShape: _brushShape,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('색상 선택: '),
//                 Container(
//                   width: 30,
//                   height: 30,
//                   color: _selectedColor,
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     _showColorPickerDialog(context);
//                   },
//                   child: Text('색상 변경'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('펜 굵기: '),
//                 Slider(
//                   value: _brushSize,
//                   min: 1.0,
//                   max: 20.0,
//                   onChanged: (value) {
//                     setState(() {
//                       _brushSize = value;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('브러시 모양: '),
//                 DropdownButton<BrushShape>(
//                   value: _brushShape,
//                   onChanged: (value) {
//                     setState(() {
//                       _brushShape = value!;
//                     });
//                   },
//                   items: BrushShape.values.map((shape) {
//                     return DropdownMenuItem<BrushShape>(
//                       value: shape,
//                       child: Text(shape.toString().split('.').last),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _points.clear();
//                 });
//               },
//               child: Text('지우기'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showColorPickerDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('색상 선택'),
//           content: SingleChildScrollView(
//             child: ColorPicker(
//               pickerColor: _selectedColor,
//               onColorChanged: (color) {
//                 setState(() {
//                   _selectedColor = color;
//                 });
//               },
//               pickerAreaHeightPercent: 0.8,
//             ),
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('확인'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class MyPainter extends CustomPainter {
//   final List<Offset?> points;
//   final Color color;
//   final double brushSize;
//   final BrushShape brushShape;
//
//   MyPainter({
//     required this.points,
//     required this.color,
//     required this.brushSize,
//     required this.brushShape,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = color
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = brushSize;
//
//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         if (brushShape == BrushShape.line) {
//           canvas.drawLine(points[i]!, points[i + 1]!, paint);
//         } else if (brushShape == BrushShape.point) {
//           canvas.drawPoints(PointMode.points, [points[i]!], paint);
//         } else if (brushShape == BrushShape.fill) {
//           paint.strokeWidth = brushSize * 2; // 면 그리기는 선 굵기를 두 배로 설정
//           canvas.drawLine(points[i]!, points[i + 1]!, paint);
//         }
//       } else if (points[i] != null && points[i + 1] == null) {
//         if (brushShape == BrushShape.point) {
//           canvas.drawPoints(PointMode.points, [points[i]!], paint);
//         }
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_ar_example/splash/FirstSplash.dart';
// import 'package:video_player/video_player.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: _MyApp(),
//     );
//   }
// }
//
// class _MyApp extends StatefulWidget {
//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<_MyApp> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('images/updatemotion.mp4')
//       ..initialize().then((_) {
//         // Ensure the first frame is shown and set the state when the video is initialized.
//         setState(() {
//           print('Video initialized successfully');
//           _controller.play(); // 자동으로 영상 재생 시작
//         });
//       });
//     // Add a listener to detect when the video playback is completed
//     _controller.addListener(() {
//       if (_controller.value.position >= _controller.value.duration) {
//
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => FirstSplash()),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         )
//             : CircularProgressIndicator(), // Show a loading indicator while the video is initializing.
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
//

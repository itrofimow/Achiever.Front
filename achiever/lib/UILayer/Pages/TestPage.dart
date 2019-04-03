import 'package:flutter/material.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverSecondaryButton.dart';

import 'dart:ui' as ui;
import 'dart:async';
import 'dart:math';

class TestPage extends StatefulWidget {
  final image = NetworkImage('${ApiClient.staticUrl}/test_image.png');
  final mask = NetworkImage('${ApiClient.staticUrl}/mask.png');

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {

  ui.Image preparedForegroundImage;
  ui.Image preparedMaskImage;

  Widget backgroundWidget;

  final foregroundLayoutKey = GlobalKey();

  @override
  void initState() {
    backgroundWidget = Container();

    _resolveImage(widget.image).then((val){
      if (mounted)
        setState(() {
          preparedForegroundImage = val;
        });
    });
    _resolveImage(widget.mask).then((val){
      if (mounted)
        setState(() {
          preparedMaskImage = val;
        });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateBackgroundDecoration());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                _buildBackgroundImage(context),
                Container(
                  key: foregroundLayoutKey,
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.blue, width: 1),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Color.fromRGBO(0, 0, 0, 0)
                      ]
                    )
                  ),
                  padding: EdgeInsets.only(top: 96, left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  child: _buildCenterColumn(context)
                ),
              ],
            )
          ),
          //Container(height: 200, color: Colors.red,)
        ]
      )
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Container(
      child: /*Image(image: widget.image,
        colorBlendMode: BlendMode.saturation,
        color: Color.fromARGB(255, 0, 0, 0),),*/
        backgroundWidget,
    );
  }

  Widget _buildCenterColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildForegroundImage(context),
        _buildTitle(context),
        _buildDescription(context),
        _buildButton(context)
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Text('Непосполнимая потеря', style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 28,
        letterSpacing: -1,
        color: Colors.white,
        shadows: [
          Shadow(
            color: Color.fromRGBO(0, 0, 0, 0.5), 
            offset: Offset(0, 2),
            blurRadius: 4)
        ]
      ), textAlign: TextAlign.center,),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Text('Полностью пройдите сюжет игры \nBatman Arkham City\n', style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0.24,
        color: Colors.white,
        height: 20 / 14,
        shadows: [
          Shadow(
            color: Color.fromRGBO(0, 0, 0, 0.5), 
            offset: Offset(0, 1),
            blurRadius: 1)
        ]
      ), textAlign: TextAlign.center,),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 28, bottom: 48),
      child: GestureDetector(
        child: Container(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white
            ),
            height: 56,
            child: Center(
              widthFactor: 1,
              child: Container(
                padding: EdgeInsets.only(left: 36, right: 36),
                child: Text('Отметить как выполненное', style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 0.26,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 51, 51, 51)
                )),
              ),
            ),
          ),
        ),
        onTap: () => {},
      )
    );
  }

  Widget _buildForegroundImage(BuildContext context) {
    final child = (preparedForegroundImage != null && preparedMaskImage != null)
      ? _buildMaskedForegroundImage(context)
      : _buildSkeletonForegroundImage(context);

    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.blue, width: 2)
      ),
      child: child
    );
  }

  Widget _buildMaskedForegroundImage(BuildContext context) {
    return CustomPaint(
      foregroundPainter: BlendPainter(preparedForegroundImage, preparedMaskImage),
    );
  }

  Widget _buildSkeletonForegroundImage(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      color: Colors.blue,
    );
  }

  void _calculateBackgroundDecoration() {
    final RenderBox renderBox = foregroundLayoutKey.currentContext.findRenderObject();

    final size = max(renderBox.size.width, renderBox.size.height) + 500;

    final background = Opacity(
      opacity: 0.7,
      child: Container(
        width: renderBox.size.width,
        height: renderBox.size.height,
        child: ClipRect(
          child: OverflowBox(
            maxHeight: size,
            maxWidth: size,
            child: Image(image: widget.image,
              colorBlendMode: BlendMode.saturation,
              color: Color.fromARGB(255, 0, 0, 0),
              width: size,
              height: size,
            ),
          ),
        )
      )
    );

    if (mounted)
      setState(() {
        backgroundWidget = background;
      });
  }

  Future<ui.Image> _resolveImage(ImageProvider image) {
    final completer = new Completer<ui.Image>();
    image.resolve(ImageConfiguration())
      .addListener((ImageInfo info, bool _) => completer.complete(info.image));
    
    return completer.future;
  }
}




















































































/*import 'package:flutter/material.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'dart:async';

import 'dart:ui' as ui; 

import 'package:achiever/UILayer/UIKit/Achievement/AchieverAchievementV2.dart';

class TestPage extends StatefulWidget {

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 16, right: 16),
        child: AchieverAchievementV2(),
      )
    );
  }*/
/*
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 100),
            height: 100,
            decoration: BoxDecoration(
              color: Colors.pink,
              boxShadow: [BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.62),
                  offset: Offset(0.0, 44.0),
                  blurRadius: 24.0
                )]
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 1.0),
              boxShadow: [BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.62),
                  offset: Offset(0.0, 4.0),
                  blurRadius: 24.0
                )]
            ),
          )
        ],
      ),
    );
  }
}*/

  /*final flutterMask = Image.network('${ApiClient.staticUrl}/test_mask.png');
  final flutterImage = Image.network('${ApiClient.staticUrl}/uploads/image_cropper_1552135907512.jpg');

  ui.Image image, mask;

  bool paint = false;

  Future<ui.Image> _getImage(Image image) async {
    final completer = new Completer<ui.Image>();
    image.image.resolve(ImageConfiguration())
      .addListener((ImageInfo info, bool _) => completer.complete(info.image));
    
    return await completer.future;
  }
  
  @override
  void initState() {
    _getImage(flutterImage).then((val){
      image = val;
    }).then((x) {
      _getImage(flutterMask).then((val){
        mask = val;
        setState(() {
          paint = true;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          
        }),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100, left: 16, right: 16),
        decoration: BoxDecoration(
          color: Colors.green
        ),
        child: paint ? Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.62),
                  offset: Offset(0.0, 4.0),
                  blurRadius: 4.0
                )
              ]
          ),
          width: MediaQuery.of(context).size.width - 32,
          height: MediaQuery.of(context).size.width - 32,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: CustomPaint(
              foregroundPainter: BlendPainter(image, mask),
            )
          )
        ) : Center(
          child: CircularProgressIndicator(),
        )
      )
    );
  }*/
/*}
*/
class BlendPainter extends CustomPainter {
  ui.Image image, mask;

  BlendPainter(this.image, this.mask);

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null || mask == null) return;

    Rect dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect imageSrcRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    Rect maskSrcRect = Rect.fromLTWH(0, 0, mask.width.toDouble(), mask.height.toDouble());

    Paint paint = Paint();
    /*Size inputSize = Size(mask.width.toDouble(), mask.height.toDouble());
    FittedSizes fs = applyBoxFit(BoxFit.contain, inputSize, size);

    Rect src = Offset.zero & fs.source;
    Rect dst = Alignment.center.inscribe(fs.destination, r);*/

    canvas.saveLayer(dstRect, Paint());

    canvas.drawImageRect(image, imageSrcRect, dstRect, paint);

    paint.blendMode = BlendMode.dstIn;
    canvas.drawImageRect(mask, maskSrcRect, dstRect, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
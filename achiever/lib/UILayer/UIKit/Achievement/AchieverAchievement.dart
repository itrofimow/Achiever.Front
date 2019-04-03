import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:achiever/DALayer/ApiClient.dart';

class AchieverAchievement extends StatefulWidget {
  final Achievement model;
  final double width;
  
  final ImageProvider<dynamic> backgroundImage;
  final ImageProvider<dynamic> foregroundImage;
  
  AchieverAchievement(this.model, this.width,
    this.backgroundImage, this.foregroundImage, {Key key}) : super(key: key);

  @override
  _AchievementState createState() {
    return _AchievementState();
  }
}

class _AchievementState extends State<AchieverAchievement>
{
  final resultKey = GlobalKey();

  ui.Image image, mask;
  final flutterMask = Image.network('${ApiClient.staticUrl}/mask.png');
  final foregroundImage2 = Image.network('${ApiClient.staticUrl}/uploads/image_cropper_1552135907512.jpg');

  bool paint = false;

  Future<ui.Image> _getImage(Image image) async {
    final completer = new Completer<ui.Image>();
    image.image.resolve(ImageConfiguration())
      .addListener((ImageInfo info, bool _) => completer.complete(info.image));
    
    return await completer.future;
  }

  Achievement model;
  double width;
  
  ImageProvider<dynamic> backgroundImage;
  ImageProvider<dynamic> foregroundImage;

  Container _backgroundImageContainer;

  void _calculateBackgroundDecoration() {
    if (resultKey.currentContext == null) return;

    final RenderBox renderBox = resultKey.currentContext.findRenderObject();
    var localHeight = renderBox.size.height;
    var localWidth = renderBox.size.width;

    Widget _backgroundChild;

    final _imageHeight = _calcHeight();// / width * localWidth;

    if (localHeight <= _imageHeight) {
      _backgroundChild = ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          fadeInDuration: Duration(milliseconds: 400),
          placeholder:  MemoryImage(kTransparentImage),
          image: backgroundImage,
          height: _imageHeight, width: width,
        )
      );
    }
    else {
      final _upscale = localHeight / _imageHeight;
      _backgroundChild = ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: OverflowBox(
          maxHeight: _imageHeight * _upscale,
          maxWidth: width * _upscale,
          child: FadeInImage(
            fadeInDuration: Duration(milliseconds: 400),
            placeholder:  MemoryImage(kTransparentImage),
            image: backgroundImage,
            height: _imageHeight * _upscale,  width: width * _upscale,
          ),
        ),
      );
    }

    setState(() {
      _backgroundImageContainer = Container(
        width: localWidth,
        height: localHeight,
        child: _backgroundChild,
      );
    });
  }

  double _calcHeight() {
    final scale = 1.0 * model.backgroundImage.height / model.backgroundImage.width;

    return width * scale;
  }

  double _calcWidth(double height) {
    final scale = height / model.frontImage.height;

    return model.frontImage.width * scale;
  }

  void tmp() async {
    _calculateBackgroundDecoration();
  }

  @override
  void initState() {
    if (!widget.model.hasDefaultBackground)
      WidgetsBinding.instance.addPostFrameCallback((_) => _calculateBackgroundDecoration());
    _getImage(foregroundImage2).then((val){
      image = val;
    }).then((x) {
      _getImage(flutterMask).then((val){
        mask = val;
        if (mounted)
          setState(() {
            paint = true;
          });
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model = widget.model;
    width = widget.width;
    backgroundImage = widget.backgroundImage;
    foregroundImage = widget.foregroundImage;

    final titleAndDescriptionBox = Container(
      margin: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(child: Text(model.title, style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                height: 1.43
              )))
            ]),
          new Container(
            margin: EdgeInsets.only(top: 4.0),
            child :Text(model.description, style: new TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
              height: 1.33
            ),)
          )
        ],
      )
    );

    final frontHeight = 80.0;
    final frontWidth =_calcWidth(frontHeight);

    final overlayContainer = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 0, 0, 0.8),
            Color.fromRGBO(0, 0, 0, 0)
          ]
        )
      ),
      constraints: BoxConstraints(
        minHeight: _calcHeight()
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: titleAndDescriptionBox),
          Container(
            margin: EdgeInsets.only(left: 16.0, right: 16.0,),
            height: 80.0,
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.red, width: 1.0),
              //image: DecorationImage(image: foregroundImage),
              //shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.62),
                  offset: Offset(0.0, 4.0),
                  blurRadius: 4.0
                )
              ]
            ),
            child: Container(
              height: frontHeight,
              width: frontWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(image: foregroundImage, 
                  height: frontHeight, width: frontWidth)
              )
              /*child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  child: !paint ? CircularProgressIndicator() : CustomPaint(
                    foregroundPainter: BlendPainter(image, mask),
                  )
                )
              )*/
            )
          )
        ]
      )
    );

    List<Widget> _stackChilds = new List<Widget>();
    /*if (model.hasDefaultBackground) {
      _backgroundImageContainer = Container(
        //height: 200,
        color: Color(int.parse(model.defaultBackgroundColor, radix: 16) + 0xFF000000),
      );
    }*/
    if (_backgroundImageContainer != null) _stackChilds.add(_backgroundImageContainer);
    _stackChilds.add(overlayContainer);

    return Container(
      //height: _height,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: model.hasDefaultBackground ? Color(int.parse(model.defaultBackgroundColor, radix: 16) + 0xFF000000) : null,
        /*boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.22),
            offset: Offset(0.0, 12.0),
            blurRadius: 14.0
          )
        ]*/
      ),
      child: Stack(
        key: resultKey,
        children: _stackChilds
      )
    );
  }
}

class BlendPainter extends CustomPainter {
  ui.Image image, mask;

  BlendPainter(this.image, this.mask);

  @override
  void paint(Canvas canvas, Size size) {
    Rect r = Offset.zero & size;
    Paint paint = Paint();

    if (image != null && mask != null) {
      Size inputSize = Size(mask.width.toDouble(), mask.height.toDouble());
      FittedSizes fs = applyBoxFit(BoxFit.contain, inputSize, size);

      Rect src = Offset.zero & fs.source;
      Rect dst = Alignment.center.inscribe(fs.destination, r);

      canvas.saveLayer(dst, Paint());
      canvas.drawImageRect(image, src, dst, paint);

      // paint.blendMode = BlendMode.multiply;
      paint.blendMode = BlendMode.dstIn;

      canvas.drawImageRect(mask, src, dst, paint);

      /*paint.blendMode = BlendMode.colorDodge;
      canvas.drawImageRect(image, src, dst, paint);*/

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
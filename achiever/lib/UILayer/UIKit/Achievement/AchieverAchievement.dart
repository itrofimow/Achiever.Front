import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/UILayer/UIKit/BlendPainter.dart';

part 'FullyCustomAchievementState.dart';
part 'LazyAchievementState.dart';

class AchieverAchievement extends StatefulWidget {
  final Achievement model;
  final double width;
  
  final ImageProvider<dynamic> backgroundImage;
  final ImageProvider<dynamic> foregroundImage;
  
  AchieverAchievement(this.model, this.width,
    this.backgroundImage, this.foregroundImage, {Key key}) : super(key: key);

  @override
  State<AchieverAchievement> createState() {
    /*if (model.paintingType == AchievementPaintingType.fullyCustom)
      return FullyCustomAchievementState();

    if (model.paintingType == AchievementPaintingType.lazy)
      return LazyAchievementState();*/
    
    return _AchievementState();
  }
}

class _AchievementState extends State<AchieverAchievement> {
  static const double _borderRadius = 15.0;

  final foregroundLayoutKey = GlobalKey();

  AchievementPaintingType paintingType;

  Widget _background;

  ui.Image preparedMaskImage;
  ui.Image preparedForegroundImage;

  @override
  void initState() {
    paintingType = widget.model.paintingType;

    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateBackgroundDecoration());

    _initResolve();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildBackground(context),
        buildForeground(context)
      ],
    );
  }

  Widget buildBackground(BuildContext context) {
    return _background ?? Container();
  }

  Widget buildForeground(BuildContext context) {
    return Container(
      key: foregroundLayoutKey,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: Colors.red,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black,
            Color.fromRGBO(0, 0, 0, 0)
          ]
        )
      ),
      child: buildTextAndFrontImage(context),
    );
  }

  Widget buildTextAndFrontImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: buildTitleAndDescription(context)),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16, left: 8),
            child: buildFrontImage(context)
          )
        ],
      )
    );
  }

  Widget buildFrontImage(BuildContext context) {
    final height = widget.model.category.maskHeight / 2;

    if (preparedForegroundImage == null || preparedMaskImage == null)
      return Image.network('${ApiClient.staticUrl}/${widget.model.category.maskImagePath}', 
        height: height);

    return Container(
      width: 1.0 * preparedMaskImage.width * height / preparedMaskImage.height,
      height: 1.0 * height,
      child: CustomPaint(
        foregroundPainter: BlendPainter(preparedForegroundImage, preparedMaskImage),
      )
    );
  }

  Widget buildTitleAndDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Text(widget.model.title, style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.24,
            color: Colors.white,
          ),)
        ),
        Container(
          margin: EdgeInsets.only(top: 4, bottom: 16),
          child: Text(widget.model.description, style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            letterSpacing: 0.21,
            color: Color.fromRGBO(255, 255, 255, 0.7),
            //height: 16 / 12
          )),
        )
      ],
    );
  }

  void _calculateBackgroundDecoration() {
    final RenderBox renderBox = foregroundLayoutKey.currentContext.findRenderObject();

    final resultImage = paintingType == AchievementPaintingType.fullyCustom
      ? widget.model.backgroundImage
      : widget.model.bigImage;

    final boxWidth = renderBox.size.width * 1.0;
    final boxHeight = resultImage.height * 
      (renderBox.size.width / resultImage.width);

    final foregroundImage = Image(
      image: NetworkImage('${ApiClient.staticUrl}/${resultImage.imagePath}'),
      width: renderBox.size.width,
      color: paintingType != AchievementPaintingType.fullyCustom 
        ? Color.fromARGB(255, 0, 0, 0)
        : null,
      colorBlendMode: paintingType != AchievementPaintingType.fullyCustom 
        ? BlendMode.saturation
        : null
    );

    final imageContainer =  Container(
      width: renderBox.size.width,
      height: renderBox.size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: OverflowBox(
          minHeight: boxHeight,
          maxHeight: boxHeight,

          minWidth: boxWidth,
          maxWidth: boxWidth,

          child: foregroundImage
        )
      )
    );

    if (paintingType != AchievementPaintingType.fullyCustom) {
      _background = Opacity(
        opacity: 0.7,
        child: imageContainer
      );
    }
    else {
      _background = imageContainer;
    }

    if (mounted)
      setState(() {});
  }

  void _initResolve() {

    final mask = NetworkImage('${ApiClient.staticUrl}/${widget.model.category.maskImagePath}');

    final imageUrl = paintingType == AchievementPaintingType.lazy 
      ? '${ApiClient.staticUrl}/${widget.model.bigImage.imagePath}'
      : '${ApiClient.staticUrl}/${widget.model.frontImage.imagePath}';
    final foregroundImage = NetworkImage(imageUrl);

    _resolveImage(mask).then((val){
      preparedMaskImage = val;
      if (mounted)
        setState(() {});
    });

    _resolveImage(foregroundImage).then((val){
      preparedForegroundImage = val;
      if (mounted)
        setState(() {});
    });
  }

  Future<ui.Image> _resolveImage(ImageProvider image) {
    final completer = new Completer<ui.Image>();
    image.resolve(ImageConfiguration())
      .addListener((ImageInfo info, bool _) => completer.complete(info.image));
    
    return completer.future;
  }
}
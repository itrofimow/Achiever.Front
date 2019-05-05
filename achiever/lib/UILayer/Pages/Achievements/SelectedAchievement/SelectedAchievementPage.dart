import 'package:flutter/material.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/UILayer/UIKit/BlendPainter.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'SelectedAchievementViewModel.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:redux/redux.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/UILayer/UIKit/Images/AchieverProfileImage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/BLLayer/ApiInterfaces/IAchievementApi.dart';
import '../../PersonalFeed/PersonalFeedPage.dart';
import 'package:achiever/BLLayer/Models/Achievement/AcquiredAtDto.dart';
import 'package:achiever/UILayer/Pages/Feed/EntryCreationPage.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';

import 'dart:ui' as ui;
import 'dart:io';
import 'dart:async';
import 'dart:math';

class SelectedAchievementPage extends StatefulWidget {
  //final image = NetworkImage('${ApiClient.staticUrl}/test_image.png');
  //final mask = NetworkImage('${ApiClient.staticUrl}/mask.png');
  final String achievementId;
  final IAchievementApi achievementApi;
  final SelectedAchievementViewModel fakedViewModel;

  SelectedAchievementPage(this.achievementId,
    {Key key, this.achievementApi, this.fakedViewModel}) : super(key: key);

  @override
  SelectedAchievementPageState createState() => SelectedAchievementPageState();
}

class SelectedAchievementPageState extends State<SelectedAchievementPage> {

  ui.Image preparedForegroundImage;
  ui.Image preparedMaskImage;

  ImageProvider<dynamic> image, backImage, mask;
  double bigImageWidth, bigImageHeight;

  Widget backgroundWidget;

  final foregroundLayoutKey = GlobalKey();

  List<UserDto> followingsWhoHave;

  ScrollController _scrollController = ScrollController();

  AcquiredAtDto acquiredAt;

  @override
  void initState() {
    backgroundWidget = Container();

    final api = widget.achievementApi ?? AppContainer.achievementApi;

    api.getFollowingsWhoHave(widget.achievementId).then((val){
      followingsWhoHave = val;
      if (mounted)
        setState(() {
          
        });
    });

    if (widget.fakedViewModel != null)
      _initResolve(AppContainer.store, fakedViewModel: widget.fakedViewModel);

    api.checkIHave(widget.achievementId).then((val){
      setState(() {
        acquiredAt = val;
      });
    });

    if (widget.fakedViewModel != null)
      WidgetsBinding.instance.addPostFrameCallback((_) => 
        _calculateBackgroundDecoration(widget.fakedViewModel.achievement.paintingType));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fakedViewModel == null) {
      return Scaffold(
        body: StoreConnector<AppState, SelectedAchievementViewModel>(
          onInit: (store) {
            _initResolve(store);
            WidgetsBinding.instance.addPostFrameCallback((_) => 
              _calculateBackgroundDecoration(
                SelectedAchievementViewModel.fromStore(store, widget.achievementId).achievement.paintingType)
              );
          },
          converter: (store) => SelectedAchievementViewModel.fromStore(store, widget.achievementId),
          builder: (context, viewModel) => _buildLayout(context, viewModel, true),
        )
      );
    }

    return _buildLayout(context, widget.fakedViewModel, false);
  }

  Widget _buildLayout(BuildContext context, SelectedAchievementViewModel viewModel, bool includeFeed) {
    final listChildren = [
      _buildHeader(context, viewModel),
        _buildStats(context, viewModel),
        _buildDivider(context),
    ];
    if (includeFeed)
      listChildren.add(PersonalFeedPage(true, widget.achievementId, _scrollController));

    return ListView(
      padding: EdgeInsets.zero,
      controller: _scrollController,
      children: listChildren
    );
  }

  Widget _buildStats(BuildContext context, SelectedAchievementViewModel viewModel) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildStatsCounter(context, viewModel),
          _buildStatsProfileImages(context, viewModel)
        ],
      ),
    );
  }

  Widget _buildStatsCounter(BuildContext context, SelectedAchievementViewModel viewModel) {
    final followingsWhoHaveCount = followingsWhoHave == null ? '...' : followingsWhoHave.length.toString();

    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          Image.asset('assets/chart_icon.png', width: 24, height: 24),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Text('Есть у $followingsWhoHaveCount подписок', style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              letterSpacing: 0.21,
              color: Color.fromARGB(255, 51, 51, 51)
            )),
          )
        ],
      ),
    );
  }

  Widget _buildStatsProfileImages(BuildContext context, SelectedAchievementViewModel viewModel) {
    final List<Widget> profileImagesList = List<Widget>();
    if (followingsWhoHave != null) {
      for (int i = 0; i < min(3, followingsWhoHave.length); ++i) {
        profileImagesList.add(
          Container(
            margin: EdgeInsets.only(right: 24.0 * i),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle
            ),
            child: AchieverProfileImage(36, CachedNetworkImageProvider(
              '${ApiClient.staticUrl}/${followingsWhoHave[i].user.profileImagePath}', )
            )
          )
        );
      }
    }

    return Container(
      margin: EdgeInsets.only(right: 16),
      child: followingsWhoHave == null ? Container() :
        GestureDetector(
          child: Container(
            width: 100,
            child: Stack(
              alignment: Alignment.centerRight,
              children: profileImagesList
            )
          ),
          onTap: () => Navigator.of(context).pop(),
        )
    );
  }

  Widget _buildHeader(BuildContext context, SelectedAchievementViewModel viewModel) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          _buildBackgroundImage(context, viewModel),
          Container(
            key: foregroundLayoutKey,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Color.fromRGBO(0, 0, 0, 0)
                ]
              )
            ),
            padding: EdgeInsets.only(left: 16, right: 16),
            width: MediaQuery.of(context).size.width,
            child: _buildCenterColumn(context, viewModel)
          ),
        ],
      )
    );
  }

  Widget _buildBackgroundImage(BuildContext context, SelectedAchievementViewModel viewModel) {
    return Container(
      child: backgroundWidget,
    );
  }

  Widget _buildCenterColumn(BuildContext context, SelectedAchievementViewModel viewModel) {
    return Column(
      children: <Widget>[
        Container(
          height: 208,
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: _buildForegroundImage(context, viewModel),
          )
        ),
        _buildTitle(context, viewModel),
        _buildDescription(context, viewModel),
        _buildButton(context)
      ],
    );
  }

  Widget _buildTitle(BuildContext context, SelectedAchievementViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Text(viewModel.achievement.title, style: TextStyle(
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

  Widget _buildDescription(BuildContext context, SelectedAchievementViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(viewModel.achievement.description, style: TextStyle(
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
      child: acquiredAt == null ? _buildSkeletonButton(context) :
        acquiredAt.value 
          ? _buildAcquiredButton(context)
          : _buildAcquireButton(context)
    );
  }

  Widget _buildSkeletonButton(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white
          ),
        height: 56,
        width: 271,
        child: Center(
          widthFactor: 1,
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ),
      )
    );
  }

  Widget _buildAcquiredButton(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white
          ),
        height: 56,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Выполнено ${acquiredAt.when}', style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.26,
                color: Color.fromRGBO(51, 51, 51, 0.5)
              ),),
              Container(
                width: 36,
                height: 36,
                margin: EdgeInsets.only(left: 12),
                child: Image.asset(
                  'assets/following_icon.png', 
                  width: 36, height: 36),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAcquireButton(BuildContext context) {
    return GestureDetector(
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
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => EntryCreationPage(widget.achievementId),
        settings: RouteSettings(name: 'createEntry')
      )),
    );
  }

  Widget _buildForegroundImage(BuildContext context, SelectedAchievementViewModel viewModel) {
    return (preparedForegroundImage != null && preparedMaskImage != null)
      ? _buildMaskedForegroundImage(context, viewModel)
      : _buildSkeletonForegroundImage(context, viewModel);
  }

  Widget _buildMaskedForegroundImage(BuildContext context, SelectedAchievementViewModel viewModel) {
    return Container(
      width: 1.0 * preparedMaskImage.width * viewModel.category.maskHeight / preparedMaskImage.height,
      height: 1.0 * viewModel.category.maskHeight,
      child: CustomPaint(
        foregroundPainter: BlendPainter(preparedForegroundImage, preparedMaskImage),
      )
    );
  }

  Widget _buildSkeletonForegroundImage(BuildContext context, SelectedAchievementViewModel viewModel) {
    return Container(
      width: 112,
      height: 1.0 * viewModel.category.maskHeight,
      color: Colors.transparent,
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 12,
      color: Color.fromRGBO(242, 242, 242, 1),
    );
  }

  void _calculateBackgroundDecoration(AchievementPaintingType paintingType) {
    final RenderBox renderBox = foregroundLayoutKey.currentContext.findRenderObject();

    final size = max(renderBox.size.width, renderBox.size.height);

    final widthScale = bigImageWidth / renderBox.size.width;
    final heightScale = bigImageHeight / renderBox.size.height;
    final minScale = min(widthScale, heightScale);

    final scale = minScale < 1 ? 1 : minScale;

    final content = Container(
      width: renderBox.size.width,
      height: renderBox.size.height,
      child: ClipRect(
        child: OverflowBox(
          //maxHeight: size,
          maxHeight: bigImageHeight / scale,
          minHeight: bigImageHeight / scale,//size,
          //maxWidth: size,
          minWidth: bigImageWidth / scale,
          maxWidth: bigImageWidth / scale,
          child: Image(image: backImage,
            colorBlendMode: paintingType == AchievementPaintingType.lazy 
              ? BlendMode.saturation
              : null,
            color: paintingType == AchievementPaintingType.lazy
              ? Color.fromARGB(255, 0, 0, 0)
              : null,
            width: size,
            //height: size,
          ),
        ),
      )
    ); 

    final background = paintingType == AchievementPaintingType.lazy 
      ? Opacity(
        opacity: 0.7,
        child: content)
      : content;

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

  void _initResolve(Store<AppState> store, {SelectedAchievementViewModel fakedViewModel}) {
    final viewModel = fakedViewModel ?? SelectedAchievementViewModel.fromStore(store, widget.achievementId);

    /*image = NetworkImage('${ApiClient.staticUrl}/${viewModel.achievement.bigImage.imagePath}');
    mask = fakedViewModel == null 
      ? NetworkImage('${ApiClient.staticUrl}/${viewModel.category.maskImagePath}')
      : FileImage(File(fakedViewModel.achievement.bigImage.imagePath));*/

    mask = NetworkImage('${ApiClient.staticUrl}/${viewModel.category.maskImagePath}');

    final achievement = fakedViewModel == null 
      ? viewModel.achievement
      : fakedViewModel.achievement;

    final imageUrl = achievement.paintingType == AchievementPaintingType.lazy
      ? achievement.bigImage.imagePath
      : achievement.frontImage.imagePath;

    image = fakedViewModel == null 
      ? NetworkImage('${ApiClient.staticUrl}/$imageUrl')
      : FileImage(File(imageUrl));

    backImage = fakedViewModel == null
      ? NetworkImage('${ApiClient.staticUrl}/${achievement.bigImage.imagePath}')
      : FileImage(File(achievement.bigImage.imagePath));

    bigImageWidth = 1.0 * viewModel.achievement.bigImage.width;
    bigImageHeight = 1.0 * viewModel.achievement.bigImage.height;

    _resolveImage(image).then((val){
      preparedForegroundImage = val;
      if (mounted)
        setState(() {});
    });

    _resolveImage(mask).then((val){
      preparedMaskImage = val;
      if (mounted)
        setState(() {});
    });
  }
}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

const textStyle = TextStyle(
  color: Colors.white,
);

final GlobalKey _backgroundImageKey = GlobalKey();

class AppleTvDetailScreen extends StatefulWidget {
  const AppleTvDetailScreen({Key? key}) : super(key: key);

  @override
  State<AppleTvDetailScreen> createState() => _AppleTvDetailScreenState();
}

class _AppleTvDetailScreenState extends State<AppleTvDetailScreen>
    with FadeOnScrollMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  ScrollController get scrollController => _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;

    final opacityAppBar = calculateOpacity(
      fullOpacityOffset: widthDevice,
    );

    final opacityBackgroundImage = calculateOpacity(
      fullOpacityOffset: widthDevice,
      inverse: true,
    );

    double scaleFactorBackgroundImage() {
      if (_offset >= 0) {
        return 1;
      }

      return 1 + (-_offset / 300);
    }

    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Transform.scale(
              scale: 1 * scaleFactorBackgroundImage(),
              child: Opacity(
                opacity: opacityBackgroundImage,
                child: Image.network(
                  key: _backgroundImageKey,
                  'https://www.themoviedb.org/t/p/w440_and_h660_face/jBzDbxsEiCUCiYcpDLpvbQ6kN2U.jpg',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                title: const Text('La cité de la peur'),
                centerTitle: true,
                pinned: true,
                elevation: 0,
                collapsedHeight: kToolbarHeight,
                expandedHeight: kToolbarHeight,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white.withOpacity(opacityAppBar),
                flexibleSpace: FlexibleSpaceBar(
                  background: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: widthDevice - kToolbarHeight - 200,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 2,
                              sigmaY: 2,
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black,
                                    ],
                                    stops: [
                                      0,
                                      0.95
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'La cité de la peur',
                                style: textStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('Comédie - 1994 - 1h et 40 mn',
                                  style: textStyle),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Regardez'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  color: Colors.black,
                  child: const Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

mixin FadeOnScrollMixin<T extends StatefulWidget> on State<T> {
  ScrollController get scrollController;

  double _offset = 0;

  @override
  initState() {
    super.initState();
    if (scrollController.hasClients) {
      _offset = scrollController.offset;
    }
    scrollController.addListener(_setOffset);
  }

  @override
  dispose() {
    scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = scrollController.offset;
    });
  }

  double calculateOpacity({
    double fullOpacityOffset = 0,
    double zeroOpacityOffset = 0,
    bool inverse = false,
  }) {
    late double result;

    if (fullOpacityOffset == zeroOpacityOffset) {
      result = 1;
    } else if (fullOpacityOffset > zeroOpacityOffset) {
      // fading in
      if (_offset <= zeroOpacityOffset) {
        result = 0;
      } else if (_offset >= fullOpacityOffset) {
        result = 1;
      } else {
        result = (_offset - zeroOpacityOffset) /
            (fullOpacityOffset - zeroOpacityOffset);
      }
    } else {
      // fading out
      if (_offset <= fullOpacityOffset) {
        result = 1;
      } else if (_offset >= zeroOpacityOffset) {
        result = 0;
      } else {
        result = (_offset - fullOpacityOffset) /
            (zeroOpacityOffset - fullOpacityOffset);
      }
    }

    return !inverse ? result : 1 - result;
  }
}

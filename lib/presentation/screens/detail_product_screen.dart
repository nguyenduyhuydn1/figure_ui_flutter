import 'package:figure_ui_flutter/config/constants/size_config.dart';
import 'package:figure_ui_flutter/consts.dart';
import 'package:flutter/material.dart';

import 'package:figure_ui_flutter/models/action_figure_model.dart';

class DetailProductScreen extends StatefulWidget {
  final ActionFigureModel model;
  const DetailProductScreen({super.key, required this.model});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  late TapDownDetails tapDownDetails;
  late TransformationController transformationController;
  bool zoomed = false;

  @override
  void initState() {
    super.initState();
    transformationController = TransformationController();
    transformationController.value = Matrix4.identity()..scale(0.9);
  }

  @override
  void dispose() {
    transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.menu),
          ),
        ),
        actions: const [
          _CircleIcon(icon: Icons.search),
          SizedBox(width: 10),
          _CircleIcon(icon: Icons.shopping_cart, notify: true),
          SizedBox(width: 20),
        ],
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.transparent,
      body: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Stack(
          children: [
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.7,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      double scale = 0.9;
                      final value = Matrix4.identity()..scale(scale);
                      transformationController.value = value;
                      setState(() {
                        zoomed = false;
                      });
                    },
                    onDoubleTap: () {
                      double scale = 2;
                      final x = -tapDownDetails.localPosition.dx * (scale - 1);
                      final y = -tapDownDetails.localPosition.dy * (scale - 1);
                      final value = Matrix4.identity()
                        ..translate(x, y)
                        ..scale(scale);
                      transformationController.value = value;
                      setState(() {
                        zoomed = true;
                      });
                    },
                    onDoubleTapDown: (details) {
                      tapDownDetails = details;
                    },
                    child: InteractiveViewer(
                      transformationController: transformationController,
                      alignment: zoomed ? null : Alignment.topCenter,
                      child: Image(
                        image: AssetImage(model.image),
                        width: double.infinity,
                        height: SizeConfig.screenHeight * 0.7,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    child: SizedBox(
                      width: SizeConfig.screenWidth,
                      height: 45,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: 15,
                            child: Opacity(
                              opacity: zoomed ? 0 : 1,
                              child: ClipPath(
                                clipper: CustomClip(),
                                child: Container(
                                  width: SizeConfig.screenWidth,
                                  height: 45,
                                  color: green,
                                ),
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: zoomed ? 0.6 : 1,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: green,
                              ),
                              child: const Icon(Icons.code_sharp, color: white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: SizeConfig.screenWidth,
                // height: SizeConfig.screenHeight * 0.35,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: const Column(
                  children: [
                    SizedBox(height: 50),
                    Text("data"),
                    SizedBox(height: 50),
                    Text("data"),
                    SizedBox(height: 50),
                    Text("data"),
                    SizedBox(height: 50),
                    Text("data"),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(20, 0);
    path.quadraticBezierTo(size.width / 2, size.height * 2, size.width - 20, 0);
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width / 2, size.height * 2 - 7, 20, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

//  SizedBox(
//           height: SizeConfig.screenHeight,
//           child: Stack(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: _Header(),
//               ),
//               Image(image: AssetImage(model.image)),
//               Positioned(
//                 bottom: 0,
//                 child: Container(
//                   height: SizeConfig.screenHeight * 0.4,
//                   width: SizeConfig.screenWidth,
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                     color: Colors.red,
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         '${model.caracter} | ${model.title}',
//                         style: titleText(),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 15),
//                       Row(
//                         children: [
//                           _TextButton(
//                             model: model,
//                             icon: Icons.star,
//                             color: Colors.yellow,
//                           ),
//                           const SizedBox(width: 20),
//                           _TextButton(
//                             model: model,
//                             icon: Icons.shopping_cart,
//                             color: Colors.grey,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
class _TextButton extends StatelessWidget {
  const _TextButton(
      {required this.model, required this.icon, required this.color});

  final IconData icon;
  final Color color;
  final ActionFigureModel model;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        splashFactory: NoSplash.splashFactory,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      onPressed: () {},
      icon: Icon(icon, size: 14, color: color),
      label: Text('${model.rate}'),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 2),
              color: black,
              spreadRadius: 0,
              blurRadius: 15,
            )
          ],
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      const _CircleIcon(icon: Icons.shopping_cart, notify: true)
    ]);
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final bool notify;
  const _CircleIcon({required this.icon, this.notify = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(icon),
        ),
        if (notify)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              width: 15,
              height: 15,
            ),
          )
      ],
    );
  }
}

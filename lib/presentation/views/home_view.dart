import 'package:figure_ui_flutter/consts.dart';
import 'package:figure_ui_flutter/models/action_figure_model.dart';
import 'package:figure_ui_flutter/models/category_model.dart';
import 'package:figure_ui_flutter/presentation/screens/detail_product_screen.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String category = categories[0].category;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(Icons.menu),
          ),
          actions: const [
            _CircleIcon(icon: Icons.search),
            SizedBox(width: 10),
            _CircleIcon(icon: Icons.shopping_cart, notify: true),
            SizedBox(width: 20),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Excepteur aliquip non commodo commodo in dolore .",
                style: bigText(),
              ),
            ),
            const SizedBox(height: 20),
            _CategoriesSection(
                categories: categories,
                onPressed: (value) {
                  setState(() {
                    category = value;
                  });
                }),
            const SizedBox(height: 20),
            _FiguresSection(
              actionModel: actionModel,
              category: category,
            )
          ],
        ),
      ),
    );
  }
}

class _FiguresSection extends StatefulWidget {
  final List<ActionFigureModel> actionModel;
  final String category;
  const _FiguresSection({required this.actionModel, required this.category});

  @override
  State<_FiguresSection> createState() => _FiguresSectionState();
}

class _FiguresSectionState extends State<_FiguresSection> {
  @override
  Widget build(BuildContext context) {
    final models =
        actionModel.where((e) => e.category.contains(widget.category)).toList();

    return SizedBox(
      // color: Colors.red,
      height: 460,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: models.length,
        itemBuilder: (context, index) {
          final model = models[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProductScreen(model: model),
                  ));
            },
            child: Center(
              child: Padding(
                padding: index == 0
                    ? const EdgeInsets.only(left: 20, right: 20)
                    : const EdgeInsets.only(right: 20),
                child: Container(
                  width: 300,
                  height: 440,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 3),
                          spreadRadius: 1,
                          blurRadius: 9,
                          color: Colors.black38,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image(
                                image: AssetImage(model.image),
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              '${model.caracter} | ${model.title}',
                              style: titleText(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                _TextButton(
                                  model: model,
                                  icon: Icons.star,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(width: 20),
                                _TextButton(
                                  model: model,
                                  icon: Icons.shopping_cart,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'US ${model.price}',
                              style: titleText(color: green),
                            )
                          ],
                        ),
                        const Positioned(
                          bottom: 50,
                          right: 0,
                          child: Icon(Icons.favorite),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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

class _CategoriesSection extends StatelessWidget {
  final Function(String) onPressed;
  final List<Category> categories;
  const _CategoriesSection({required this.onPressed, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: index == 0
                ? const EdgeInsets.only(left: 20, right: 20)
                : const EdgeInsets.only(right: 20),
            child: ElevatedButton.icon(
              onPressed: () => onPressed(category.category),
              icon: Image(
                image: AssetImage(category.image),
                width: 40,
                height: 40,
              ),
              label: Text(category.category),
            ),
          );
          // return _ButtonCategory(
          //     onPressed: onPressed, category: category, index: index);
        },
      ),
    );
  }
}

class _ButtonCategory extends StatelessWidget {
  const _ButtonCategory({
    required this.onPressed,
    required this.category,
    required this.index,
  });

  final Function(String p1) onPressed;
  final Category category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: index == 0
          ? const EdgeInsets.only(left: 20, right: 20)
          : const EdgeInsets.only(right: 20),
      child: Material(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: () => onPressed(category.category),
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.only(right: 20, left: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              // color: Colors.red,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image(
                    image: AssetImage(category.image),
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  category.category,
                  style: titleText(),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
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

import 'package:furniture_store_app/screens/categories_feeds.dart';
import 'package:furniture_store_app/screens/feeds.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Beds',
      'categoryImagesPath':
          'https://cdn.pixabay.com/photo/2018/01/24/15/08/live-3104077__340.jpg',
    },
    {
      'categoryName': 'Chairs',
      'categoryImagesPath':
          'https://cdn.pixabay.com/photo/2015/12/05/23/16/office-1078869_960_720.jpg',
    },
    {
      'categoryName': 'Wardrobe',
      'categoryImagesPath':
          'https://i.pinimg.com/564x/86/9c/ea/869ceae5b65333c45d8d9677a1e3620e.jpg'
    },
    {
      'categoryName': 'Study Tables',
      'categoryImagesPath':
          'https://i.pinimg.com/564x/0f/f3/98/0ff3983518a1c4932e00e6e77473e2f9.jpg'
    },
    {
      'categoryName': 'Dinning Tables',
      'categoryImagesPath':
          'https://i.pinimg.com/564x/fe/de/d0/feded027e226753f55cb972b85ba14d7.jpg',
    },
    {
      'categoryName': 'Decor',
      'categoryImagesPath':
          'https://i.pinimg.com/564x/fa/62/d0/fa62d04980ecfa040142ed0a260b5fef.jpg',
    },
    {
      'categoryName': 'Sofas',
      'categoryImagesPath':
          'https://i.pinimg.com/564x/2c/ae/bb/2caebb437240b844c933173c0cf8646d.jpg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CategoriesFeedsScreen.routeName,
                arguments: '${categories[widget.index]['categoryName']}');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(categories[widget.index]
                              ['categoryImagesPath']
                          ?.toString() ??
                      ''),
                  fit: BoxFit.cover),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[widget.index]['categoryName']?.toString() ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).textSelectionColor,
              ), // TextStyle
            ), // Text
          ), // Container
        ) // Positioned
      ],
    );
  }
}

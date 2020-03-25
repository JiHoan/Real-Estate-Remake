import 'package:flutter/material.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  MySliverAppBar({@required this.expandedHeight});

  final double expandedHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.asset("assets/no-image.png", fit: BoxFit.contain),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  Colors.black26,
                ],
              ),
            ),
            child: Text(
              'Nhà cho thuê',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: 5,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xffF8A200)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Material(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xff41BC00),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: (){},
              child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all(10),
                child: Image.asset('assets/camera.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
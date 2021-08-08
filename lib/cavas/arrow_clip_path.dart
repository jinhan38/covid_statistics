import 'package:flutter/cupertino.dart';

enum ArrowDirection { UP, MIDDEL, DOWN }

class ArrowClipPath extends CustomClipper<Path> {
  ArrowDirection direction;

  ArrowClipPath({required this.direction});

  @override
  Path getClip(Size size) {
    var path = Path();
    switch (direction) {
      case ArrowDirection.UP:
        path.moveTo(0, size.height); // 0,20부터 그림을 그리겠다
        path.lineTo(size.width * 0.5, 0);
        path.lineTo(size.width, size.height); //시작점과 끝점은 알아서 이어진다
        path.close();
        break;
      case ArrowDirection.MIDDEL:
        path.moveTo(0, size.height *0.4);
        path.lineTo(size.width, size.height *0.4);
        path.lineTo(size.width, size.height *0.6);
        path.lineTo(0, size.height *0.6);
    path.close();
        break;
      case ArrowDirection.DOWN:
        path.moveTo(0, 0); 
        path.lineTo(size.width, 0);
        path.lineTo(size.width * 0.5, size.height);
        path.close();
        break;
    }
    return path;
  }

  //화면이 리셋되는 경우 진입
  //false 세팅하면 다시 그리지 않고,
  //true로 하면 무조건 다시 그린다
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

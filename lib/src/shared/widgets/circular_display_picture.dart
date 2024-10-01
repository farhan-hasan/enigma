import 'package:flutter/material.dart';

class CircularDisplayPicture extends StatelessWidget {
  CircularDisplayPicture(
      {super.key,
      //required this.imageURL
      required this.radius});
  //TODO: make image url dynamic
  final String imageURL =
      "https://s3-alpha-sig.figma.com/img/b1fb/7717/906c952085307b6af6e1051a901bdb02?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=edtDSMIHBYzR5Wos5wA0lQVreSXkLV9Z4snQyZArYDI4cMVT-m~m67qlV447q3PXrBSC6OIb7F8HG9qgAdF7oU3eWSQqVgV8cpRyJe3m6iMFacyfd4dnz~tYghPejkfrX~ToE6ieUZ1Uuok2r6Z1dPr5ytPPg0bQYMuTiZO0UXdYqT~a8~nLiK48lNtV8KnVtoQScVMuWO2XmVtJ1t4T-CUxJwOf6QBuXsWHi9ZZ3VaLB0894uLMJw23yaDcaLld2UtIH0NcSJCd2kbRHub6eHvgzu~SEQApa3zAM8~0Y6YUIws0rAGj55yvCllkC7kqPee1b7S8Hpz90L9E4D8Bdw__";
  double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: ClipOval(
        child:
            Image.network(width: 55, height: 55, fit: BoxFit.cover, imageURL),
      ),
    );
  }
}

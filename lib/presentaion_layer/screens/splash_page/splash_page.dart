import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty/constants/strings.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2),
            ()=>Navigator.pushReplacementNamed(context,showCharacters
        )
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SvgPicture.asset('assets/Rick.svg'),
    );
  }
}

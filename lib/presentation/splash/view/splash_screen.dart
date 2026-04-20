import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/outline_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/resource/constants/image_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
      ),
      body: Center(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image(image: AssetImage(ImageManager.splash)),
            SizedBox(height: 10,),
            PrimaryButton(title: "test", onTap: (){}),
            SizedBox(height: 10,),
            CustomOutlinedButton(title: "test", onTap: (){})
          ],
        ),
      ),),
    );
  }
}

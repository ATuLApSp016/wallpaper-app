import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/utils/app_images.dart';
import 'package:wallpaper_app/utils/app_styles.dart';

class DownloadPage extends StatelessWidget {
  PhotosModel mPhotos;
  int mIndex;

  DownloadPage({required this.mPhotos, required this.mIndex});


  List dataList = [
    {'icon': AppImages.IC_INFO, 'text': 'info'},
    {'icon': AppImages.IC_DOWNLOAD, 'text': 'save'},
    {'icon': AppImages.IC_APPLY, 'text': 'Apply'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: mIndex,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(mPhotos.src!.large.toString()),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 41.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(dataList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 31.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Image.asset(
                              dataList[index]['icon'],
                              color: AppColors.whiteColor,
                              width: 30,
                            ),
                          ),
                        ),
                        Text(
                          dataList[index]['text'],
                          style: mTextStyle16(mColor: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

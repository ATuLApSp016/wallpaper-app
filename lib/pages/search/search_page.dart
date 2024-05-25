import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/pages/download.dart';
import 'package:wallpaper_app/pages/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/utils/app_colors.dart';
import 'package:wallpaper_app/utils/app_styles.dart';
import 'package:wallpaper_app/widgets/wallpaper_bg_widget.dart';

class SearchDetailPage extends StatefulWidget {
  String? query;
  String? color;
  SearchDetailPage({super.key, required this.query, this.color});

  @override
  State<SearchDetailPage> createState() => _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context)
        .getSearchWallpaper(query: widget.query!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (_, state) {
          if (state is SearchLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchErrorState) {
            return Center(
                child: Text(state.errorMsg,
                    style: mTextStyle16(mFontWeight: FontWeight.bold)));
          } else if (state is SearchLoadedState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 11),
                    getText(
                        title: widget.query!,
                        style: mTextStyle35(
                            mFontWeight: FontWeight.bold,
                            mColor: AppColors.blackColor)),
                    getText(
                      title: '${state.totalWallpapers}\twallpaper available',
                      style: mTextStyle16(
                          mColor: Colors.grey, mFontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 11),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: state.listPhotos.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 9 / 14),
                          itemBuilder: (_, index) {
                            var eachPhotos = state.listPhotos[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: index == state.listPhotos.length - 1
                                      ? 8
                                      : 0),
                              child: WallPaperBgWidget(
                                urlImage: eachPhotos.src!.portrait!,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DownloadPage(
                                              mPhotos: eachPhotos,
                                              mIndex: index)));
                                },
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget getText({required String title, TextStyle? style}) {
    return Text(
      title,
      style: style,
    );
  }
}

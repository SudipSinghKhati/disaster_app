import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../../../../config/router/app_route.dart';
import '../../../../../core/common/Provider/is_dark_theme.dart';
import '../../../../../core/common/snackbar/snackbar.dart';
import '../../../../auth/presentation/state/auth_state.dart';
import '../../../../news/domain/entity/news_entity.dart';
import '../../../../news/presentation/view_model/news_get_my_news_view_news.dart';
import '../../../data/model/shake_sensor.dart';
import '../../view_model/home_viewmodel.dart';

class AccountView extends ConsumerStatefulWidget {
  const AccountView({super.key});

  @override
  ConsumerState<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends ConsumerState<AccountView> {
  late bool isDark = false;
  late ShakeSensor shakeSensor;

  @override
  void initState() {
    super.initState();
    isDark = ref.read(isDarkThemeProvider);
    shakeSensor = ShakeSensor(onShake: _onShake);
  }

  void _onShake() {
    setState(() {
      isDark = !isDark;
    });
    ref.read(isDarkThemeProvider.notifier).updateTheme(isDark);
  }

  void _handleLogout(BuildContext context) {
    ref.read(homeViewModelProvider.notifier).logout(context);
  }

  @override
  Widget build(BuildContext context) {
    // all news
    final newsState = ref.watch(newsGetMyNewsViewModelProvider);

    final List<NewsEntity> newsList = newsState.news;

    final double width = MediaQuery.of(context).size.width;
    // final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, ${AuthState.userEntity?.fullName ?? "User"}'),
        actions: [
          IconButton(
            onPressed: () {
              _handleLogout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          Switch(
            value: isDark,
            onChanged: (value) {
              setState(() {
                isDark = value;
              });
              ref.read(isDarkThemeProvider.notifier).updateTheme(value);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              NewsEntity news = newsList[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 12,
                shadowColor: const Color.fromARGB(255, 211, 199, 199),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FullScreenWidget(
                            disposeLevel: DisposeLevel.Medium,
                            child: SizedBox(
                              width: width * 0.25,
                              height: width * 0.35,
                              child: Image.network(
                                'http://10.0.2.2:4000/uploads/${news.image}',
                                // 'http://192.168.101.4:4000/uploads/${news.image}',
                                // ApiEndpoints.imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      news.title,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.22,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.updateNews,
                                          arguments: news,
                                        );
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Delete News'),
                                              content: const Text(
                                                  'Are you sure you want to delete this News ?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    ref
                                                        .watch(
                                                            newsGetMyNewsViewModelProvider
                                                                .notifier)
                                                        .deleteNews(context,
                                                            news.newsId!);

                                                    ref
                                                        .watch(
                                                            newsGetMyNewsViewModelProvider
                                                                .notifier)
                                                        .getMyNews();
                                                    Navigator.pop(context);
                                                    showSnackBar(
                                                      context: context,
                                                      message:
                                                          "News deleted successfully",
                                                      color: Colors.green,
                                                    );
                                                  },
                                                  child: const Text('Delete'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.6,
                                  child: ListTile(
                                    leading: const Icon(Icons.location_on),
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Transform(
                                      transform: Matrix4.translationValues(
                                        -10,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Text(
                                        news.location,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.6,
                                  child: ListTile(
                                    leading: const Icon(Icons.description),
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Transform(
                                      transform: Matrix4.translationValues(
                                        -10,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Text(
                                        news.description,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

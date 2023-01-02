import 'package:dd_study_22_ui/data/services/auth_service.dart';
import 'package:dd_study_22_ui/ui/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:dd_study_22_ui/data/services/data_service.dart';
import 'package:dd_study_22_ui/data/services/sync_service.dart';
import 'package:dd_study_22_ui/domain/models/post_model.dart';
import 'package:dd_study_22_ui/internal/config/app_config.dart';
import 'package:dd_study_22_ui/ui/navigation/tab_navigator.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  final _dataService = DataService();
  final _lvc = ScrollController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  _ViewModel({required this.context}) {
    asyncInit();
    _lvc.addListener(() {
      var max = _lvc.position.maxScrollExtent;
      var current = _lvc.offset;
      var percent = (current / max * 100);

      if (percent > 80) {
        if (!isLoading) {
          isLoading = true;
          Future.delayed(const Duration(seconds: 1)).then((value) {
            posts = <PostModel>[...posts!, ...posts!];
            isLoading = false;
          });
        }
      }
    });
  }

  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    _posts = val;
    notifyListeners();
  }

  Map<int, int> pager = <int, int>{};

  void onPageChanged(int listIndex, int pageIndex) {
    pager[listIndex] = pageIndex;
    notifyListeners();
  }

  void asyncInit() async {
    await SyncService().syncPosts();
    posts = await _dataService.getPosts();
  }

  void toPostDetail(String postId) {
    Navigator.of(context)
        .pushNamed(TabNavigatorRoutes.postDetails, arguments: postId);
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();
    var itemCount = viewModel.posts?.length ?? 0;
    final _authService = AuthService();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          title: SvgPicture.asset(
            'assets/img/insta_logo.svg',
            color: Colors.white,
            height: 40,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_upward_outlined),
            ),
            IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Подтверждение'),
                  content: const Text(
                      'Вы действительно хотите выйти из аккаунта? Для входа в аккаунт потребуется повторная авторизация.'),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _authService
                                .logout()
                                .then((value) => AppNavigator.toLoader());
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          child: const Text('Выход'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('Отмена'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        // body: const PostCard(),
        body: ListView.separated(
            controller: viewModel._lvc,
            itemBuilder: (_, listIndex) {
              Widget res;

              var posts = viewModel.posts;

              if (posts != null) {
                var post = posts[listIndex];
                res = GestureDetector(
                  onTap: () => viewModel.toPostDetail(post.id),
                  child: PostCard(
                    post: post,
                    listIndex: listIndex,
                  ),
                );
              } else {
                res = const SizedBox.shrink();
              }
              return res;
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: itemCount));
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ViewModel(context: context),
      child: const Home(),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int count;
  final int? current;
  final double width;
  const PageIndicator(
      {Key? key, required this.count, required this.current, this.width = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];

    for (var i = 0; i < count; i++) {
      // print(current);
      widgets.add(
        Icon(
          Icons.circle,
          color: i == (current ?? 0)
              ? Colors.black.withAlpha(100)
              : Colors.grey[300],
          size: 8,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...widgets],
    );
  }
}

class PostCard extends StatelessWidget {
  final PostModel post;
  final int listIndex;

  const PostCard({
    Key? key,
    required this.post,
    this.listIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();
    var df = DateFormat("dd.MM.yyyy   HH:mm:ss  ");

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: viewModel.posts == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ).copyWith(right: 0),
                  child: Row(
                    children: [
                      post.author.avatarLink != null
                          ? CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  '$baseUrl${post.author.avatarLink!}'),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: SvgPicture.asset(
                                'assets/img/user.svg',
                                color: Colors.white,
                                height: 15,
                              ),
                            ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.author.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    child: ListView(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shrinkWrap: true,
                                      children: [
                                        'Delete',
                                      ]
                                          .map((e) => InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                                  child: Text(e),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ));
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    ],
                  ),

                  // Image Section
                ),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: PageView.builder(
                          onPageChanged: (value) =>
                              viewModel.onPageChanged(listIndex, value),
                          itemCount: post.contents.length,
                          itemBuilder: (_, pageIndex) => Container(
                                color: Colors.white,
                                child: Image(
                                    image: NetworkImage(
                                        "$baseUrl${post.contents[pageIndex].contentLink}")),
                              )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PageIndicator(
                        count: post.contents.length,
                        current: viewModel.pager[listIndex]),
                  ],
                ),

                // LIKES AND COMMENTS -------------------------------------------
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      label: Text(
                        post.likesCount.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.comment_outlined,
                        color: Colors.black,
                      ),
                      label: Text(
                        post.commentsCount.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          df.format(post.created),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),

                // Description and number of comments
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: post.author.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${post.description}',
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}

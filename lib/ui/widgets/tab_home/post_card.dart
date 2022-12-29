
 // return SafeArea(
    //     child: Container(
    //         child: viewModel.posts == null
    //             ? const Center(child: CircularProgressIndicator())
    //             : Column(
    //                 children: [
    //                   Expanded(
    //                       child: ListView.separated(
    //                           controller: viewModel._lvc,
    //                           itemBuilder: (_, listIndex) {
    //                             Widget res;
    //                             var posts = viewModel.posts;
    //                             if (posts != null) {
    //                               var post = posts[listIndex];
    //                               res = GestureDetector(
    //                                 onTap: () =>
    //                                     viewModel.toPostDetail(post.id),
    //                                 child: Container(
    //                                   padding: const EdgeInsets.all(10),
    //                                   height: size.width,
    //                                   color: Colors.grey,
    //                                   child: Column(
    //                                     children: [
    //                                       Expanded(
    //                                         child: PageView.builder(
    //                                           onPageChanged: (value) =>
    //                                               viewModel.onPageChanged(
    //                                                   listIndex, value),
    //                                           itemCount: post.contents.length,
    //                                           itemBuilder: (_, pageIndex) =>
    //                                               Container(
    //                                             color: Colors.yellow,
    //                                             child: Image(
    //                                                 image: NetworkImage(
    //                                               "$baseUrl${post.contents[pageIndex].contentLink}",
    //                                             )),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       PageIndicator(
    //                                         count: post.contents.length,
    //                                         current: viewModel.pager[listIndex],
    //                                       ),
    //                                       Text(post.description ?? "")
    //                                     ],
    //                                   ),
    //                                 ),
    //                               );
    //                             } else {
    //                               res = const SizedBox.shrink();
    //                             }
    //                             return res;
    //                           },
    //                           separatorBuilder: (context, index) =>
    //                               const Divider(),
    //                           itemCount: itemCount)),
    //                   if (viewModel.isLoading) const LinearProgressIndicator()
    //                 ],
    //               )));
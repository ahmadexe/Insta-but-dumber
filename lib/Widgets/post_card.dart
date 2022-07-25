import 'package:flutter/material.dart';
import 'package:flutter_social/Models/model_user.dart';
import 'package:flutter_social/Providers/user_provider.dart';
import 'package:flutter_social/Screens/comments_screen.dart';
import 'package:flutter_social/Services/firestore_methods.dart';
import 'package:flutter_social/Widgets/like_animation.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    ModelUser? user = Provider.of<UserProvider>(context).user;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          //! Header
          Container(
            padding: const EdgeInsets.fromLTRB(14, 0, 0, 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        widget.snap['profImg'],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(widget.snap['username'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            //! Image portion
          ),

          GestureDetector(
            onDoubleTap: () async {
              setState(() {
                isLikeAnimating = true;
              });
              await FirestoreMethods().likePost(
                  widget.snap['postId'], user!.uid, widget.snap['likes']);
            },
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: Image.network(
                  widget.snap['postUrl'],
                  fit: BoxFit.fill,
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(milliseconds: 400),
                  onEnd: (() {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  }),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.grey,
                    size: 120,
                  ),
                ),
              )
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  LikeAnimation(
                    isAnimating: widget.snap['likes'].contains(user?.uid),
                    isLiked: true,
                    child: (widget.snap['likes'].contains(user?.uid))?
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red,),
                      onPressed: () async {
                        await FirestoreMethods().likePost(widget.snap['postId'],
                            user!.uid, widget.snap['likes']);
                      },
                    )
                    :
                     IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () async {
                        await FirestoreMethods().likePost(widget.snap['postId'],
                            user!.uid, widget.snap['likes']);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline),
                    onPressed: () {Get.to(CommentsScreen(postId: widget.snap['postId']));},
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {},
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
          //! Comments and Likes portion
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text("${widget.snap['likes'].length} likes",
                        style: Theme.of(context).textTheme.bodyText2)),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: widget.snap['username'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: ' ${widget.snap['caption']}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {Get.to(CommentsScreen(postId: widget.snap['postId']));},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "View all comments...",
                      style: TextStyle(color: secondaryColor, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

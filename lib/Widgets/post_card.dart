import 'package:flutter/material.dart';
import 'package:flutter_social/utils/colors.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
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
                        snap['profImg'],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(snap['username'],
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline),
                    onPressed: () {},
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
          const Divider(),
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
                    child: Text(snap['likes'].length.toString(),
                        style: Theme.of(context).textTheme.bodyText2)),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: snap['username'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: ' ${snap['caption']}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "View all 150 comments...",
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

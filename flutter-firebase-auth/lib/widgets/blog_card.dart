// import 'package:flutter/material.dart';
// import '../models/blog_post.dart';
// import '../screens/blog_details_screen.dart';

// class BlogCard extends StatefulWidget {
//   final BlogPost post;
//   const BlogCard({Key? key, required this.post}) : super(key: key);

//   @override
//   _BlogCardState createState() => _BlogCardState();
// }

// class _BlogCardState extends State<BlogCard> {
//   bool isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => isHovered = true),
//       onExit: (_) => setState(() => isHovered = false),
//       child: GestureDetector(
//         onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => BlogScreen(post: widget.post),
//           ),
//         ),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           decoration: BoxDecoration(
//             color: Colors.grey[900],
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: isHovered ? Colors.purple : Colors.transparent,
//               width: 2,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: isHovered ? Colors.purple.withOpacity(0.3) : Colors.black54,
//                 blurRadius: isHovered ? 8 : 4,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Blog Image
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.network(
//                   widget.post.imageUrl,
//                   height: 150,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     height: 150,
//                     width: double.infinity,
//                     color: Colors.grey[800],
//                     child: const Icon(Icons.broken_image, color: Colors.white),
//                   ),
//                 ),
//               ),

//               // Blog Text Content
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.post.title,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: isHovered ? Colors.purple : Colors.white,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       widget.post.summary,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[300],
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       widget.post.content,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: isHovered ? Colors.purple[200] : Colors.grey[400],
//                       ),
//                       maxLines: 5,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../screens/blog_details_screen.dart';

class BlogCard extends StatefulWidget {
  final BlogPost post;
  const BlogCard({Key? key, required this.post}) : super(key: key);

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovered ? Colors.purple : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered ? Colors.purple.withOpacity(0.3) : Colors.black54,
              blurRadius: isHovered ? 8 : 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                widget.post.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[800],
                  child: const Icon(Icons.broken_image, color: Colors.white),
                ),
              ),
            ),

            // Blog Text Content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isHovered ? Colors.purple : Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.post.summary,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.post.content,
                    style: TextStyle(
                      fontSize: 14,
                      color: isHovered ? Colors.purple[200] : Colors.grey[400],
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),

                  // Read More Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlogScreen(post: widget.post),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.purple,
                      ),
                      child: const Text("Read More"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

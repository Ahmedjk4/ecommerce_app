import 'package:cached_network_image/cached_network_image.dart';
import 'package:electronics_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> snapshot;
  const ProductCard({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 280,
      decoration: BoxDecoration(
        color: Constants.kSecondaryColor,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot['company'],
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                Text(
                  snapshot['name'],
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 16),
              child: Hero(
                tag: snapshot['image'],
                child: CachedNetworkImage(
                  imageUrl: snapshot['image'],
                  height: 270,
                  width: 240,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 24,
                      width: 24,
                    )
                  ],
                ),
                SizedBox(
                  width: snapshot['discount'] != 0 ? 20 : 60,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    color: Constants.kTritaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 40,
                  width: snapshot['discount'] != 0 ? 200 : 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '\$ ${snapshot['price'].toString()}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: snapshot['discount'] != 0,
                        child: Expanded(
                          child: Text(
                            '\$ ${snapshot['discount'].toString()}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      )
                    ],
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

import 'package:electronics_shop/features/home/presentation/view_models/category_index_cubit/category_index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HorizontalCategoriesSlider extends StatefulWidget {
  const HorizontalCategoriesSlider({super.key, required this.categories});
  final List<String> categories;
  @override
  State<HorizontalCategoriesSlider> createState() =>
      _HorizontalCategoriesSliderState();
}

class _HorizontalCategoriesSliderState
    extends State<HorizontalCategoriesSlider> {
  @override
  Widget build(BuildContext context) {
    int selectedCategory =
        switch (BlocProvider.of<CategoryIndexCubit>(context).state) {
      'all' => 0,
      'phones' => 1,
      'pcs' => 2,
      'laptops' => 3,
      'pc-components' => 4,
      'consoles' => 5,
      'accessories' => 6,
      _ => 0
    };

    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                switch (index) {
                  case 0:
                    BlocProvider.of<CategoryIndexCubit>(context)
                        .setCategoryTo('all');
                    break;
                  case 1:
                    BlocProvider.of<CategoryIndexCubit>(context)
                        .setCategoryTo('phones');
                    break;
                  case 2:
                    BlocProvider.of<CategoryIndexCubit>(context)
                        .setCategoryTo('pcs');
                    break;
                  case 3:
                    BlocProvider.of<CategoryIndexCubit>(context)
                        .setCategoryTo('laptops');
                    break;
                  case 4:
                    BlocProvider.of<CategoryIndexCubit>(context)
                        .setCategoryTo('pc-components');
                    break;
                  case 5:
                    BlocProvider.of<CategoryIndexCubit>(context)
                        .setCategoryTo('consoles');
                    break;
                  case 6:
                    BlocProvider.of<CategoryIndexCubit>(context)
                        .setCategoryTo('accessories');
                    break;
                  default:
                    BlocProvider.of<CategoryIndexCubit>(context)
                        .setCategoryTo('all');
                    break;
                }
                selectedCategory = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.categories[index],
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: selectedCategory == index ? Colors.white : Colors.grey,
                ),
              ),
            ),
          );
        },
        itemCount: widget.categories.length,
      ),
    );
  }
}

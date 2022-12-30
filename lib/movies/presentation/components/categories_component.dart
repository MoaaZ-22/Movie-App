import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesStringComponent extends StatelessWidget {
  const CategoriesStringComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        height: 60,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: 1,
          itemBuilder: (context, index) {
            final movie = [];
            return Container(
              width: 100,
              height: 60,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white30, width: 1)
              ),
              child: Text('', style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                  color: Colors.white),),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 8,),
        ),
      ),
    );
  }
}

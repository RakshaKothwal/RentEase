import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class Addlocation extends StatefulWidget {
  const Addlocation({super.key});

  @override
  State<Addlocation> createState() => _AddlocationState();
}

class _AddlocationState extends State<Addlocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(data: "", showBackArrow: true, context: context),
      backgroundColor: Colors.white,
      body: Padding(
        padding: horizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            RichText(
                text: TextSpan(
                    text: "Add your ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400),
                    children: [
                  TextSpan(
                      text: "Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          fontFamily: "Poppins"))
                ])),
            SizedBox(
              height: 10,
            ),
            Text(
              "You can edit this later ",
              style: TextStyle(
                  color: Color(0xff989898),
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/map6.png"))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: horizontalPadding,
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(0xff989898),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Jakarta"),
                  SizedBox(
                    width: 20,
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

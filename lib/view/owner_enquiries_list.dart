import 'package:flutter/material.dart';
import 'package:rentease/common/common_form.dart';
import 'package:rentease/common/global_widget.dart';

class OwnerEnquiriesList extends StatelessWidget {
  const OwnerEnquiriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar:
            appbar(data: "Enquiries", showBackArrow: true, context: context),
        body: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: primaryBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/room1.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '3 BHK Apartment',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins",
                                        color: Color(0xff000000)
                                            .withAlpha((255 * 0.75).toInt()),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Adajan, Surat',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.grey[200],
                                          child: Icon(
                                            Icons.person,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Raksha Kothwal',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff000000).withAlpha(
                                                (255 * 0.75).toInt()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Visit Scheduled',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600],
                                        letterSpacing: 0),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '15 Mar, 10:00 AM',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff000000)
                                          .withAlpha((255 * 0.75).toInt()),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange
                                      .withAlpha((255 * 0.1).toInt()),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Pending',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                  child: outlinedSubmit(
                                data: "Reject",
                                onPressed: () {},
                              )),
                              const SizedBox(width: 12),
                              Expanded(
                                  child:
                                      submit(data: "Accept", onPressed: () {})),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 12,
                );
              },
              itemCount: 5),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:rentease/common/common_form.dart';

import '../common/common_profile.dart';
import '../common/global_widget.dart';

class Mycontract extends StatefulWidget {
  const Mycontract({super.key});

  @override
  State<Mycontract> createState() => _MycontractState();
}

class _MycontractState extends State<Mycontract> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          appbar(data: "My Contract", showBackArrow: true, context: context),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Color(0xffD32F2F),
                unselectedLabelColor: Color(0xffB2B2B2),
                unselectedLabelStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
                labelStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
                dividerColor: Color(0xffF5F5F5),
                dividerHeight: 4,
                indicatorColor: Color(0xffD32F2F).withAlpha(220),
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    text: "BioData",
                  ),
                  Tab(text: "Contract Details")
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: horizontalPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              header("Personal Data"),
                              SizedBox(
                                height: 16,
                              ),
                              primaryInfo(
                                  label: "Name", value: "Raksha Kothwal"),



                              primaryInfo(label: "Gender", value: "Female"),



                              primaryInfo(label: "Status", value: "Status"),



                              primaryInfo(label: "Work", value: "Work"),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 10,
                          color: Color(0xffF5F5F5),
                          thickness: 2,
                        ),
                        Padding(
                          padding: horizontalPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              header("Contact Details"),
                              SizedBox(
                                height: 16,
                              ),
                              primaryInfo(
                                  label: "Phone Number", value: "9977667889"),



                              primaryInfo(
                                  label: "Email",
                                  value: "example123@example.com"),
                              SizedBox(
                                height: 80,
                              ),

                              submit(
                                  height: 50,
                                  width: double.infinity,
                                  data: "Change Biodata",
                                  onPressed: () {}),






                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: horizontalPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          header("Rental Contract Details"),
                          SizedBox(
                            height: 16,
                          ),
                          primaryInfo(
                              label: "Start Date", value: "22 September 2023"),



                          primaryInfo(
                              label: "Completion Date",
                              value: "31 December 2023"),



                          primaryInfo(label: "Total Billed", value: "359"),



                          primaryInfo(
                              label: "Rental Duration", value: "3 Months"),



                          primaryInfo(
                              label: "Last Billing", value: "5 November 2023"),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Color(0xffB2B2B2), width: 1)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                header("Billing October 2023"),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          color: Color(0xffD32F2F),
                                          width: 0.8,
                                        ),
                                        color: Color(0xffD32F2F)
                                            .withAlpha((255 * 0.1).toInt()),
                                      ),
                                      child: Text(
                                        "Not yet paid",
                                        style: TextStyle(
                                            color: Color(0xffD32F2F),
                                            fontSize: 10,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      "5 more days",
                                      style: TextStyle(
                                        color: Color(0xff919191),
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0,
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                primaryInfo(
                                    label: "The amount of the bill",
                                    value: "128"),



                                primaryInfo(
                                    label: "Due date", value: "31 October"),



                                primaryInfo(
                                    label: "Rent Calculation", value: "Month"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),






                          outlinedSubmit(
                              height: 50,
                              width: double.infinity,
                              data: "End Contract",
                              onPressed: () {}),


                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
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

import 'package:flutter/material.dart';
import 'package:my_fsg/screens/Home/customers.dart';
import 'package:my_fsg/screens/Home/myProfile.dart';
import 'package:my_fsg/screens/Home/realestate.dart';
import '../theme/colors.dart';

class RootApp extends StatefulWidget {
  var email;
  RootApp({Key? key, this.email}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Center(
        child: Text(
          "Add Property",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      const HomePage(),
      const CustomersPage(),
      MyProfile(
        email: widget.email,
      ),
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List bottomItems = [
      'assets/images/add_icon.png',
      'assets/images/real_estate.png',
      'assets/images/customer_icon.png',
      'assets/images/settings.png',
    ];
    List textItems = [
      'Add Property',
      'Real Estate',
      'Customers',
      'Settings',
    ];
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.14,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border(
        //     top: BorderSide(width: 2, color: primary.withOpacity(0.6)))
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(textItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.22,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        bottomItems[index],
                        width: MediaQuery.of(context).size.width * 0.13,
                        color: pageIndex == index
                            ? primary
                            : primary.withOpacity(0.6),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        textItems[index],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: pageIndex == index
                                ? primary
                                : primary.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}

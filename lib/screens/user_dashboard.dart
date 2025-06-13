import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pitchmatter_assignment/model/user_model.dart';
import 'package:pitchmatter_assignment/provider/user_provider.dart';
import 'package:pitchmatter_assignment/screens/user_details.dart';
import 'package:pitchmatter_assignment/utils/colors.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        centerTitle: true,
        title: Text(
          'User',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: white,
              overflow: TextOverflow.ellipsis),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: primary,
                  ),
                  labelText: 'Search users',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  focusColor: primary),
              onChanged: (value) => context.read<UserProvider>().search(value),
            ),
          ),
          Expanded(
            child: Consumer<UserProvider>(
              builder: (context, provider, _) =>
                  NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) {
                  provider.loadMore();
                }
                return false;
              }, child: Builder(builder: (context) {
                if (provider.users.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.02,
                    ),
                    itemCount: provider.users.length,
                    itemBuilder: (context, index) {
                      final UserModel user = provider.users[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primary.withOpacity(
                              0.5,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            user.name,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                          ),
                          subtitle: Text(
                            user.company!.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: grey,
                                ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: textColor,
                          ),
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                              child: UserDetailScreen(
                                userId: user.id,isDeepLink: false,
                              ),
                              type: PageTransitionType.rightToLeft,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              })),
            ),
          )
        ],
      ),
    );
  }
}

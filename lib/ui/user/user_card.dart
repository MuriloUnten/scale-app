
import 'package:flutter/material.dart';
import 'package:scale_app/domain/sex.dart';
import 'package:scale_app/domain/user.dart';
import 'package:scale_app/utils/format.dart';

class UserCard extends StatelessWidget {
    const UserCard({
        super.key,
        required this.user,
    });

    final User user;

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(20),
            child: Card(
                elevation: 10,
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 25,
                        children: [
                            Text(
                                user.fullName,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                ),
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                "Height",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                ),
                                            ),
                                            Text(
                                                "${user.height} cm",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontWeight: FontWeight.w600,
                                                ),
                                            ),
                                        ],
                                    ),
                                    SizedBox(width: 40),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                "Sex",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                ),
                                            ),
                                            Text(
                                                user.sex.formattedString,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontWeight: FontWeight.w600,
                                                ),
                                            ),
                                        ],
                                    ),
                                ],
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                "Date of Birth",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                ),
                                            ),
                                            Text(
                                                formatDate(user.dateOfBirth),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontWeight: FontWeight.w600,
                                                ),
                                            ),
                                        ],
                                    ),
                                ],
                            ),
                        ],
                    )
                ),
            ),
        );
    }
}

import "package:flutter/material.dart";
import "package:scale_app/domain/bia.dart";

class BiaCard extends StatelessWidget {
    const BiaCard({
        super.key,
        required this.bia,
    });

    final Bia bia;

    @override
    Widget build(BuildContext context) {
        return Card(
            elevation: 10,
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            child: Container(
                width: 400,
                height: 140,
                padding: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                        Row(
                            spacing: 10,
                            children: [
                                Icon(
                                    Icons.calendar_today,
                                    color: Theme.of(context).colorScheme.onSurface,
                                ),
                                Text(
                                    bia.formattedTimestamp,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontWeight: FontWeight.w500,
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 60,
                            children: [
                                Container(
                                    padding: EdgeInsets.only(left: 35),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                "Weight",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                )
                                            ),
                                            Text(
                                                "${bia.weight} Kg",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontWeight: FontWeight.w600,
                                                )
                                            )
                                        ],
                                    ),
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            "Body fat",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                            )
                                        ),
                                        Text(
                                            "${bia.bodyFatPercentage}%",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontWeight: FontWeight.w600,
                                            )
                                        )
                                    ],
                                ),
                            ],
                        ),
                    ],
                ),
            ),
        );
    }
}

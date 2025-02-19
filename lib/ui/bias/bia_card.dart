import "package:flutter/material.dart";
import "package:scale_app/domain/bia.dart";
import "package:sqflite/utils/utils.dart";

class BiaCard extends StatelessWidget {
    const BiaCard({
        super.key,
        required this.bia,
        this.detailed = false,
    });

    final Bia bia;
    final bool detailed;

    @override
    Widget build(BuildContext context) {
        if (detailed) {
            return _detailedBiaCard(context);
        }

        return _biaCard(context);
    }

    Widget _biaCard(BuildContext context) {
        return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            elevation: 10,
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            child: Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            spacing: 30,
                            children: [
                                _massField(context, "Weight", bia.formattedWeight),
                                _massField(context, "Fat free mass", bia.formattedMuscleMass),
                                _percentageField(context, "Body Fat", bia.bodyFatPercentage),
                            ],
                        ),
                    ],
                ),
            ),
        );
    }

    Widget _detailedBiaCard(BuildContext context) {
        return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            elevation: 10,
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            child: Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                _massField(context, "Weight", bia.formattedWeight),
                                _percentageField(context, "Body Fat", bia.bodyFatPercentage),
                                _massField(context, "Fat free mass", bia.formattedMuscleMass),
                            ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                _massField(context, "Fat mass", bia.formattedFatMass),
                                _massField(context, "Water mass", bia.formattedWaterMass),
                            ],
                        ),
                    ],
                ),
            ),
        );
    }

    Column _massField(BuildContext context, String fieldName, String fieldValue) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    fieldName,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                    )
                ),
                Text(
                    "$fieldValue Kg",
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                    )
                )
            ],
        );
    }

    Column _percentageField(BuildContext context, String fieldName, int fieldValue) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    fieldName,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                    )
                ),
                Text(
                    "$fieldValue%",
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                    )
                )
            ],
        );
    }
}

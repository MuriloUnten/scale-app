import "./bia_card.dart";
import "package:flutter_app_test/domain/bia.dart";

import "package:flutter/material.dart";

class BiasList extends StatelessWidget {
    const BiasList({
        super.key,
        required this.bias,
    });

    final List<Bia> bias;

    @override
    Widget build(BuildContext context) {
        if (bias.isEmpty) {
            return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 35,
                ),
                child: Text(
                    "No measurements yet...",
                    style: Theme.of(context).textTheme.bodyLarge,
                ),
            );
        }

        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                        ListView.builder(
                            itemCount: bias.length,
                            shrinkWrap: true,
                            itemBuilder: (context, id) {
                                return BiaCard(bia: bias[id]);
                            },
                        ),
                    ],
                ),
            ),
        );
    }
}


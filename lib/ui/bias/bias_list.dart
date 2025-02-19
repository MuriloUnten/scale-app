import "./bia_card.dart";
import "package:scale_app/domain/bia.dart";

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
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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


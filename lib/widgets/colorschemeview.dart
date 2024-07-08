import 'package:flutter/material.dart';
import 'package:tiktickat/widgets/colorchip.dart';
import 'package:tiktickat/widgets/colorgroup.dart';

import '../screens/theme.dart';

class ColorSchemeView extends StatelessWidget {
  const ColorSchemeView({super.key, required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ColorGroup(children: <ColorChip>[
          ColorChip(
              label: 'primary',
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary),
          ColorChip(
              label: 'onPrimary',
              color: colorScheme.onPrimary,
              onColor: colorScheme.primary),
          ColorChip(
              label: 'primaryContainer',
              color: colorScheme.primaryContainer,
              onColor: colorScheme.onPrimaryContainer),
          ColorChip(
              label: 'onPrimaryContainer',
              color: colorScheme.onPrimaryContainer,
              onColor: colorScheme.primaryContainer),
        ]),
        divider,
        ColorGroup(children: <ColorChip>[
          ColorChip(
              label: 'secondary',
              color: colorScheme.secondary,
              onColor: colorScheme.onSecondary),
          ColorChip(
              label: 'onSecondary',
              color: colorScheme.onSecondary,
              onColor: colorScheme.secondary),
          ColorChip(
              label: 'secondaryContainer',
              color: colorScheme.secondaryContainer,
              onColor: colorScheme.onSecondaryContainer),
          ColorChip(
              label: 'onSecondaryContainer',
              color: colorScheme.onSecondaryContainer,
              onColor: colorScheme.secondaryContainer),
        ]),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip(
                label: 'tertiary',
                color: colorScheme.tertiary,
                onColor: colorScheme.onTertiary),
            ColorChip(
                label: 'onTertiary',
                color: colorScheme.onTertiary,
                onColor: colorScheme.tertiary),
            ColorChip(
                label: 'tertiaryContainer',
                color: colorScheme.tertiaryContainer,
                onColor: colorScheme.onTertiaryContainer),
            ColorChip(
                label: 'onTertiaryContainer',
                color: colorScheme.onTertiaryContainer,
                onColor: colorScheme.tertiaryContainer),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip(
                label: 'error',
                color: colorScheme.error,
                onColor: colorScheme.onError),
            ColorChip(
                label: 'onError',
                color: colorScheme.onError,
                onColor: colorScheme.error),
            ColorChip(
                label: 'errorContainer',
                color: colorScheme.errorContainer,
                onColor: colorScheme.onErrorContainer),
            ColorChip(
                label: 'onErrorContainer',
                color: colorScheme.onErrorContainer,
                onColor: colorScheme.errorContainer),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip(
                label: 'surface',
                color: colorScheme.surface,
                onColor: colorScheme.onSurface),
            ColorChip(
                label: 'onSurface',
                color: colorScheme.onSurface,
                onColor: colorScheme.surface),
            ColorChip(
                label: 'onSurfaceVariant',
                color: colorScheme.onSurfaceVariant,
                onColor: colorScheme.surfaceContainerHighest),
          ],
        ),
        divider,
        ColorGroup(
          children: <ColorChip>[
            ColorChip(label: 'outline', color: colorScheme.outline),
            ColorChip(label: 'shadow', color: colorScheme.shadow),
            ColorChip(
                label: 'inverseSurface',
                color: colorScheme.inverseSurface,
                onColor: colorScheme.onInverseSurface),
            ColorChip(
                label: 'onInverseSurface',
                color: colorScheme.onInverseSurface,
                onColor: colorScheme.inverseSurface),
            ColorChip(
                label: 'inversePrimary',
                color: colorScheme.inversePrimary,
                onColor: colorScheme.primary),
          ],
        ),
      ],
    );
  }
}

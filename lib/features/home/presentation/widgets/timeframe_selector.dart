import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/shared/utils/extensions.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/text_style.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class TimeframeSelector extends HookWidget {
  TimeframeSelector({
    required this.onSelected,
    super.key,
  });

  final Function(String) onSelected;

  final List<String> timeframes = [
    '1H',
    '2H',
    '4H',
    '1D',
    '1W',
    '1M',
  ];

  @override
  Widget build(BuildContext context) {
    final currentTime = useState('1H');
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SubText(
              text: 'Time',
              textSize: 14,
              foreground: context.isDarkMode() ? white : blackTint2,
            ),
            const Gap(5),
            ...timeframes.map(
              (e) => InkWell(
                onTap: () {
                  onSelected.call(e);
                  currentTime.value = e;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 40,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: currentTime.value == e
                        ? context.isDarkMode()
                            ? const Color(0xffCFD3D8)
                            : const Color(0xff555C63)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: SubText(
                      text: e,
                      textSize: 14,
                      foreground: context.isDarkMode() ? white : blackTint2,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 25,
                    color: divider.withOpacity(.08),
                  ),
                  const Gap(5),
                  SvgPicture.asset(
                    ImageAssets.charts,
                    colorFilter: ColorFilter.mode(
                      context.isDarkMode() ? white : blackTint2,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(6),
            Container(
              width: 1,
              height: 25,
              color: divider.withOpacity(.08),
            ),
            const Gap(6),
            SubText(
              text: 'Fx Indicators',
              textSize: 14,
              foreground: context.isDarkMode() ? blackTint : blackTint2,
            ),
            const Gap(6),
          ],
        ),
      ),
    );
  }
}

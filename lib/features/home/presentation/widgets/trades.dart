import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/shared/utils/extensions.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/text_style.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class Trades extends HookWidget {
  const Trades({super.key});

  @override  
  Widget build(BuildContext context) {
    final selectedValue = useState(0);
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              SizedBox(
                child: CupertinoSlidingSegmentedControl(
                  backgroundColor: context.isDarkMode()
                      ? black.withOpacity(.16)
                      : const Color(0xffF1F1F1),
                  thumbColor:
                      context.isDarkMode() ? const Color(0xff21262C) : white,
                  padding: const EdgeInsets.all(3),
                  groupValue: selectedValue.value,
                  children: {
                    0: Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: SubText(
                          text: 'Open Orders',
                        ),
                      ),
                    ),
                    1: Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: SubText(
                          text: 'Positions',
                        ),
                      ),
                    ),
                    2: Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: SubText(
                          text: 'Order History',
                        ),
                      ),
                    ),
                    3: Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: SubText(
                          text: 'Trade History',
                        ),
                      ),
                    ),
                  },
                  onValueChanged: (value) {
                    selectedValue.value = value!;
                  },
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: selectedValue,
          builder: (context, value, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(30),
                  const HeaderText(
                    text: 'No Open Orders',
                  ),
                  const Gap(5),
                  SizedBox(
                    width: 280,
                    child: SubText(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                      textAlign: TextAlign.center,
                      foreground: context.isDarkMode() ? blackTint : blackTint2,
                      height: 2,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

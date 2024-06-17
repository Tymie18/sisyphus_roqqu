import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/features/home/presentation/controllers/chart_controller.dart';
import 'package:sisyphus/shared/utils/extensions.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/text_style.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class Orderbook extends HookConsumerWidget {
  const Orderbook({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderBooks = ref.watch(orderBookStateProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: context.isDarkMode()
                          ? const Color(0xff353945)
                          : const Color(0xffCFD3D8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SvgPicture.asset(
                      ImageAssets.select1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        // color: Color(0xffCFD3D8),
                        ),
                    child: SvgPicture.asset(
                      ImageAssets.select2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: const BoxDecoration(
                        // color: Color(0xffCFD3D8),
                        ),
                    child: SvgPicture.asset(
                      ImageAssets.select2,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.isDarkMode()
                      ? const Color(0xff353945)
                      : const Color(0xffCFD3D8),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Row(
                  children: [
                    SubText(
                      text: '10',
                      textSize: 12,
                    ),
                    Gap(5),
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubText(
                    text: 'Price',
                    foreground: context.isDarkMode() ? blackTint : blackTint2,
                  ),
                  const Gap(5),
                  SubText(
                    text: 'USDT',
                    textSize: 11,
                    foreground: context.isDarkMode() ? blackTint : blackTint2,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubText(
                    text: 'Amounts',
                    foreground: context.isDarkMode() ? blackTint : blackTint2,
                  ),
                  const Gap(5),
                  SubText(
                    text: 'BTC',
                    textSize: 11,
                    foreground: context.isDarkMode() ? blackTint : blackTint2,
                  ),
                ],
              ),
              SubText(
                text: 'Total',
                foreground: context.isDarkMode() ? blackTint : blackTint2,
              ),
            ],
          ),
        ),
        const Gap(5),
        if (orderBooks != null) ...[
          Column(
            children: List.generate(
              orderBooks.asks!.length > 5 ? 5 : orderBooks.asks!.length,
              (index) => Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      color: const Color(0xffFF6838).withOpacity(.15),
                      height: 28,
                      width: (double.tryParse(orderBooks.asks![index]![0])! *
                              double.tryParse(orderBooks.asks![index]![1])!) /
                          100,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubText(
                          text:
                              '${double.tryParse(orderBooks.asks![index]![0]!.toString())}',
                          foreground: const Color(0xffFF6838),
                        ),
                        SubText(
                          text: double.tryParse(
                            orderBooks.asks![index]![1]!.toString(),
                          )!
                              .toStringAsFixed(3),
                        ),
                        SubText(
                          text: (double.tryParse(orderBooks.asks![index]![0])! +
                                  double.tryParse(orderBooks.asks![index]![1])!)
                              .formatValue2(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubText(
                text: '${double.tryParse(orderBooks.asks![1]![0]!.toString())}',
                textSize: 16,
                foreground: const Color(0xff25C26E),
              ),
              const Gap(13),
              Icon(
                Icons.arrow_upward_rounded,
                size: 18,
                color:
                    context.isDarkMode() ? blackTint : const Color(0xff25C26E),
              ),
              const Gap(13),
              SubText(
                text: '${double.tryParse(orderBooks.bids![1]![0]!.toString())}',
                textSize: 16,
                foreground: context.isDarkMode() ? white : appBlack,
              ),
            ],
          ),
          const Gap(10),
          Expanded(
            child: Column(
              children: List.generate(
                orderBooks.bids!.length > 5 ? 5 : orderBooks.bids!.length,
                (index) => Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        color: const Color(0xff25C26E).withOpacity(.15),
                        height: 24,
                        width: (double.tryParse(orderBooks.bids![index]![0])! *
                                double.tryParse(orderBooks.bids![index]![1])!) /
                            100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SubText(
                              text:
                                  '${double.tryParse(orderBooks.bids![index]![0]!.toString())}',
                              foreground: const Color(0xffFF6838),
                            ),
                          ),
                          Expanded(
                            child: SubText(
                              text: double.tryParse(
                                orderBooks.bids![index]![1]!.toString(),
                              )!
                                  .toStringAsFixed(3),
                            ),
                          ),
                          Expanded(
                            child: SubText(
                              text: (double.tryParse(
                                          orderBooks.bids![index]![0])! +
                                      double.tryParse(
                                          orderBooks.bids![index]![1])!)
                                  .formatValue2(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/core/enums/enums.dart';
import 'package:sisyphus/features/home/presentation/controllers/chart_controller.dart';
import 'package:sisyphus/features/home/presentation/controllers/symbol_controller.dart';
import 'package:sisyphus/features/home/presentation/widgets/bottom_sheet.dart';
import 'package:sisyphus/features/home/presentation/widgets/charts.dart';
import 'package:sisyphus/features/home/presentation/widgets/orderbook.dart';
import 'package:sisyphus/features/home/presentation/widgets/trades.dart';
import 'package:sisyphus/shared/utils/extensions.dart';
import 'package:sisyphus/shared/utils/utils.dart';
import 'package:sisyphus/shared/widgets/buttons.dart';
import 'package:sisyphus/shared/widgets/text_style.dart';
import 'package:sisyphus/shared/widgets/widgets.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final drawerItems = [
    'Exchange',
    'Wallets',
    'Roqqu Hub',
    'Log out',
  ];

  @override
  Widget build(BuildContext context) {
    ref.watch(symbolControllerProvider);

    final currentSymbol = ref.watch(currentSymbolStateProvider);

    final candlestick = ref.watch(candleTickerStateProvider);

    final tabController = useTabController(
      initialLength: 3,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: Stack(
        children: [
          Positioned(
            top: 65,
            right: 10,
            child: Container(
              height: 208,
              width: 214,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).shadowColor,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...drawerItems.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      child: SubText(
                        text: e,
                        textSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      key: _key,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).shadowColor,
                width: 1.5,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: SvgPicture.asset(
              ImageAssets.logo,
              colorFilter: ColorFilter.mode(
                context.isDarkMode() ? white : black,
                BlendMode.srcIn,
              ),
            ),
            actions: [
              DefaultImageButton(
                image: ImageAssets.user,
                onPressed: () {},
              ),
              const Gap(15),
              DefaultImageButton(
                size: 24,
                image: ImageAssets.globe,
                isSvg: true,
                onPressed: () {},
              ),
              const Gap(15),
              DefaultImageButton(
                image: ImageAssets.menu,
                isSvg: true,
                onPressed: () {
                  _key.currentState!.openEndDrawer();
                },
              ),
              const Gap(14),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          bottom: 120,
        ),
        children: [
          const Gap(8),
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).shadowColor,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImageAssets.btcusd,
                        width: 44,
                        height: 24,
                      ),
                      const Gap(8),
                      if (currentSymbol != null) ...[
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              SubText(
                                text: currentSymbol.symbol!,
                                textSize: 18,
                              ),
                              const Gap(10),
                              const Padding(
                                padding: EdgeInsets.all(2),
                                child: Icon(Icons.keyboard_arrow_down_rounded),
                              ),
                            ],
                          ),
                        ),
                        const Gap(27),
                        SubText(
                          text:
                              '\$${double.tryParse(currentSymbol.price!).formatValue()}',
                          textSize: 18,
                          foreground: textGreen,
                        ),
                      ] else ...[
                        const SubText(
                          text: '--',
                          textSize: 18,
                        ),
                        const Gap(10),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ),
                        const Gap(27),
                        const SubText(
                          text: r'$0.0',
                          textSize: 18,
                          foreground: textGreen,
                        ),
                      ],
                    ],
                  ),
                ),
                const Gap(18),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 18,
                                    color: blackTint,
                                  ),
                                  Gap(5),
                                  SubText(
                                    text: '24h change',
                                    textSize: 12,
                                    foreground: blackTint,
                                  ),
                                ],
                              ),
                              const Gap(5),
                              if (candlestick != null)
                                SubText(
                                  text:
                                      '${candlestick.candle.volume.formatValue2()} +1%',
                                  textSize: 14,
                                  foreground: textGreen,
                                )
                              else
                                const SubText(
                                  text: '0.00 +0.00%',
                                  textSize: 14,
                                  foreground: textGreen,
                                ),
                            ],
                          ),
                        ),
                        const Gap(17),
                        Container(
                          width: 1,
                          height: 48,
                          color: divider.withOpacity(.08),
                        ),
                        const Gap(17),
                        SizedBox(
                          width: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward_rounded,
                                    size: 18,
                                    color: blackTint,
                                  ),
                                  Gap(5),
                                  SubText(
                                    text: '24h high',
                                    textSize: 12,
                                    foreground: blackTint,
                                  ),
                                ],
                              ),
                              const Gap(5),
                              if (candlestick != null)
                                SubText(
                                  text:
                                      '${candlestick.candle.high.formatValue()} +1%',
                                  textSize: 14,
                                )
                              else
                                const SubText(
                                  text: '0.00 +0.00%',
                                  textSize: 14,
                                ),
                            ],
                          ),
                        ),
                        const Gap(17),
                        Container(
                          width: 1,
                          height: 48,
                          color: divider.withOpacity(.08),
                        ),
                        const Gap(17),
                        SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward_rounded,
                                    size: 18,
                                    color: blackTint,
                                  ),
                                  Gap(5),
                                  SubText(
                                    text: '24h low',
                                    textSize: 12,
                                    foreground: blackTint,
                                  ),
                                ],
                              ),
                              const Gap(5),
                              if (candlestick != null)
                                SubText(
                                  text:
                                      '${candlestick.candle.low.formatValue()} -1%',
                                  textSize: 14,
                                )
                              else
                                const SubText(
                                  text: '0.00 -0.00%',
                                  textSize: 14,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).shadowColor,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 42,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).shadowColor,
                      width: 1.5,
                    ),
                  ),
                  child: TabBar(
                    controller: tabController,
                    padding: const EdgeInsets.all(2),
                    labelStyle: const TextStyle(
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    tabs: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('Charts'),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('Orderbook'),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('Recent trades'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const Charts(),
                      const Orderbook(),
                      
                      Container(
                        height: 30,
                        padding: const EdgeInsets.all(20),
                        child: const HeaderText(
                          text: 'Recent Trades',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(9),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).shadowColor,
                width: 1.5,
              ),
            ),
            child: const Trades(),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).shadowColor,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DefaultButton(
                  title: 'Buy',
                  onPressed: () {
                    openBottomSheet(context, UserAction.buy);
                  },
                  color: const Color(0xff25C26E),
                ),
              ),
              const Gap(16),
              Expanded(
                child: DefaultButton(
                  title: 'Sell',
                  onPressed: () {
                    openBottomSheet(context, UserAction.buy);
                  },
                  color: const Color(0xffFF554A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(
    BuildContext context,
    UserAction userAction,
  ) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      backgroundColor: context.isDarkMode() ? const Color(0xff20252B) : white,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext buildContext) {
        return ActionBottomSheet();
      },
    );
  }
}

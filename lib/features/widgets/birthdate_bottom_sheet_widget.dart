import 'package:fit/features/widgets/outline_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BirthdateBottomSheetWidget extends StatefulWidget {
  const BirthdateBottomSheetWidget({
    Key? key,
    required this.onTapSave,
  }) : super(key: key);

  final void Function(String date) onTapSave;

  @override
  State<BirthdateBottomSheetWidget> createState() =>
      _BirthdateBottomSheetWidgetState();
}

class _BirthdateBottomSheetWidgetState
    extends State<BirthdateBottomSheetWidget> {
  int selectedYear = 1350;
  int selectedMonth = 1;
  int selectedDay = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Container(
                height: 4,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.gray[300],
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'تاریخ تولد',
                  style: Get.textTheme.headline6,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'روز',
                              style: Get.textTheme.subtitle2,
                            ),
                            Text(
                              'ماه',
                              style: Get.textTheme.subtitle2,
                            ),
                            Text(
                              'سال',
                              style: Get.textTheme.subtitle2,
                            ),
                          ]),
                    ),
                    Divider(
                      height: 32,
                      thickness: 1,
                      color: AppColors.gray[200],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 40,
                              child: CupertinoPicker(
                                backgroundColor: Colors.transparent,
                                onSelectedItemChanged: (value) {
                                  selectedDay = value + 1;
                                  setState(() {});
                                },
                                selectionOverlay: Container(
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                          horizontal: BorderSide(
                                              color: AppColors.primary))),
                                ),
                                looping: true,
                                itemExtent: 40.0,
                                children: List.generate(
                                        _getMonthLength(
                                            selectedYear, selectedMonth),
                                        (index) => index + 1)
                                    .map(
                                      (text) => Center(
                                        child: Text(
                                          text.toString(),
                                          style: Get.textTheme.subtitle2,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 40,
                              child: CupertinoPicker(
                                backgroundColor: Colors.transparent,
                                onSelectedItemChanged: (value) {
                                  selectedMonth = value + 1;
                                  setState(() {});
                                },
                                selectionOverlay: Container(
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                          horizontal: BorderSide(
                                              color: AppColors.primary))),
                                ),
                                looping: true,
                                itemExtent: 40.0,
                                children:
                                    List.generate(12, (index) => index + 1)
                                        .map(
                                          (text) => Center(
                                            child: Text(
                                              text.toString(),
                                              style: Get.textTheme.subtitle2,
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 40,
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                    initialItem: 50),
                                backgroundColor: Colors.transparent,
                                onSelectedItemChanged: (value) {
                                  selectedYear = value + 1300;
                                  setState(() {});
                                },
                                selectionOverlay: Container(
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                          horizontal: BorderSide(
                                              color: AppColors.primary))),
                                ),
                                itemExtent: 40,
                                children:
                                    List.generate(101, (index) => index + 1300)
                                        .map(
                                          (text) => Center(
                                            child: Text(
                                              text.toString(),
                                              style: Get.textTheme.subtitle2,
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ]),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Row(children: [
                  Expanded(
                    child: OutlineButtonWidget(
                      onTap: () => Get.back(),
                      buttonTitle: 'بازگشت',
                      color: AppColors.gray[300]!,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: FillButtonWidget(
                    isLoading: false,
                    onTap: () => widget.onTapSave(
                        '$selectedYear/${selectedMonth.toString().padLeft(2, '0')}/${selectedDay.toString().padLeft(2, '0')}'),
                    buttonTitle: 'ذخیره',
                  )),
                ]),
              ),
            ]),
      ),
    );
  }

  int _getMonthLength(int selectedYear, int selectedMonth) {
    if (selectedMonth <= 6) {
      return 31;
    }
    if (selectedMonth > 6 && selectedMonth < 12) {
      return 30;
    }
    if (Jalali(selectedYear).isLeapYear()) {
      return 30;
    } else {
      return 29;
    }
  }
}

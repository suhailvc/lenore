import 'package:flutter/material.dart';
import 'package:lenore/application/provider/filter_provider/filter_provider.dart';
import 'package:lenore/application/provider/home_provider/gift_by_event_provider/gift_by_event_provider.dart';

import 'package:provider/provider.dart';

class GiftByEventFilter extends StatefulWidget {
  const GiftByEventFilter({super.key});

  @override
  State<GiftByEventFilter> createState() => _GiftByEventFilterState();
}

class _GiftByEventFilterState extends State<GiftByEventFilter> {
  @override
  void initState() {
    Provider.of<GiftByEventProvider>(context, listen: false)
        .giftByEventProviderMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size querySize = MediaQuery.of(context).size;

    return Consumer2<GiftByEventProvider, FilterProvider>(
      builder: (context, giftByEventProvider, filterProvider, child) {
        double itemHeight = querySize.height * 0.1;
        double calculatedHeight = itemHeight *
            (giftByEventProvider.cachedResponse?.data?.length ?? 0);

        if (giftByEventProvider.cachedResponse?.data?.isEmpty ?? true) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gift By Event",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'Segoe',
                fontSize: querySize.height * 0.021,
              ),
            ),
            SizedBox(height: querySize.height * 0.01),
            SizedBox(
              height: querySize.height * 0.4,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: giftByEventProvider.cachedResponse!.data!.length,
                itemBuilder: (context, index) {
                  int eventId =
                      giftByEventProvider.cachedResponse!.data![index].id!;

                  return Row(
                    children: [
                      Transform.scale(
                        scale: querySize.height * 0.0014,
                        child: Checkbox(
                          visualDensity: VisualDensity.compact,
                          value:
                              filterProvider.selectedEventIds.contains(eventId),
                          activeColor: Colors.black,
                          onChanged: (value) {
                            if (value == true) {
                              filterProvider.updateEventIds([
                                ...filterProvider.selectedEventIds,
                                eventId
                              ]);
                            } else {
                              filterProvider.updateEventIds(
                                filterProvider.selectedEventIds
                                    .where((id) => id != eventId)
                                    .toList(),
                              );
                            }
                          },
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                              width: querySize.width * 0.003,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: querySize.width * 0.03),
                      Text(
                        giftByEventProvider
                                .cachedResponse!.data![index].eventCategory ??
                            '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Segoe',
                          fontSize: querySize.height * 0.018,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
// class GiftByEventFilter extends StatefulWidget {
//   const GiftByEventFilter({super.key});

//   @override
//   State<GiftByEventFilter> createState() => _GiftByEventFilterState();
// }

// class _GiftByEventFilterState extends State<GiftByEventFilter> {
//   final List<int> _selectedIndices = [];

//   @override
//   void initState() {
//     Provider.of<GiftByEventProvider>(context, listen: false)
//         .giftByEventProviderMethod();
//     super.initState();
//   }

//   void _onCheckboxChanged(bool? value, int index, int eventId) {
//     setState(() {
//       if (value == true) {
//         _selectedIndices.add(eventId);
//       } else {
//         _selectedIndices.remove(eventId);
//       }
//       Provider.of<FilterProvider>(context, listen: false)
//           .updateEventIds(_selectedIndices);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size querySize = MediaQuery.of(context).size;

//     return Consumer<GiftByEventProvider>(builder: (context, subValue, child) {
//       double itemHeight = querySize.height * 0.1;
//       double calculatedHeight =
//           itemHeight * subValue.cachedResponse!.data!.length;
//       if (subValue.cachedResponse!.data!.isEmpty) {
//         return SizedBox();
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Gift By Event",
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Segoe',
//               fontSize: querySize.height * 0.021,
//             ),
//           ),
//           SizedBox(height: querySize.height * 0.01),
//           SizedBox(
//             height: querySize.height * 0.4,
//             //calculatedHeight < querySize.height * 0.3
//             // ? calculatedHeight
//             // : querySize.height * 0.3,
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: subValue.cachedResponse!.data!.length,
//               itemBuilder: (context, index) {
//                 int eventId = subValue.cachedResponse!.data![index].id!;
//                 return Row(
//                   children: [
//                     Transform.scale(
//                       scale: querySize.height * 0.0014,
//                       child: Checkbox(
//                         visualDensity: VisualDensity.compact,
//                         value: _selectedIndices.contains(eventId),
//                         activeColor: Colors.black,
//                         onChanged: (value) =>
//                             _onCheckboxChanged(value, index, eventId),
//                         side: MaterialStateBorderSide.resolveWith(
//                           (states) => BorderSide(
//                             width: querySize.width * 0.003,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: querySize.width * 0.03),
//                     Text(
//                       subValue.cachedResponse!.data![index].eventCategory ?? '',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Segoe',
//                         fontSize: querySize.height * 0.018,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           const Divider(),
//         ],
//       );
//     });
//   }
// }

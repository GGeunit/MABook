import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/expense_controller.dart';
import '../../model/expense_model.dart';
import '../../screen/expense/edit.dart';
import '../../screen/expense/show.dart';
import '../modal/confirm_modal.dart';
import '../modal/more_bottom.dart';

class ExpenseListItem extends StatelessWidget {
  final ExpenseModel item;
  const ExpenseListItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final ExpenseController expenseController = Get.put(ExpenseController());
    return InkWell(
      onTap: () {
        Get.to(() => ExpenseShow(item.id));
      },
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지 영역
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(10.0),
              //   child: Image.network(
              //     item.imageUrl,
              //     // "https://www.spongebobshop.com/cdn/shop/products/SB-Standees-Spong-1_1200x.jpg?v=1603744567",
              //     width: _imageSize,
              //     height: _imageSize,
              //     fit: BoxFit.cover,
              //   ),
              // ),

              // 정보 영역
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   item.title,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(fontSize: 16),
                      // ),
                      Row(
                        children: [
                          // Text(
                          //   '동네이름',
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                          // Text(
                          //   TimeUtil.parse(item.createdAt),
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                        ],
                      ),
                      Text(
                        item.category.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${formatNumber(item.price ?? 0)} 원',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              // 기타 영역
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return MoreBottom(
                        cancelTap: () {
                          Get.back();
                        },
                        hideTap: () {},
                        update: () {
                          Get.back();
                          Get.to(() => ExpenseEdit(item));
                        },
                        delete: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ConfirmModal(
                                title: '삭제 하기',
                                message: '이 글을 삭제하시겠습니까?',
                                confirmText: '삭제하기',
                                confirmAction: () async {
                                  bool result = await expenseController
                                      .expenseDelete(item.id);
                                  if (result) {
                                    Get.back();
                                    Get.back();
                                  }
                                },
                                cancel: () {
                                  Get.back();
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert, color: Colors.grey, size: 16),
              ),
            ],
          ),
          // 채팅, 관심물건 창 배치
          Positioned(
            right: 20,
            bottom: 0,
            child: Row(
              children: [
                Text(
                  formatDate(item.date),
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

String formatNumber(double number) {
  String roundedNumber = number.round().toString();
  return roundedNumber.replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );
}

String formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

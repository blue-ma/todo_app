import 'package:after_layout/after_layout.dart';
import 'package:app_base/common/common.dart';
import 'package:app_base/common/dart/extension/datetime_extension.dart';
import 'package:app_base/common/util/app_keyboard_util.dart';
import 'package:app_base/common/widget/scaffold/bottom_dialog_scaffold.dart';
import 'package:app_base/common/widget/w_round_button.dart';
import 'package:app_base/common/widget/w_rounded_container.dart';
import 'package:app_base/screen/main/write/vo_write_to_result.dart';
import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';

// <WriteTodoResult> : DialogWidget의 return value
class WriteTodoDialog extends DialogWidget<WriteTodoResult> {
  WriteTodoDialog({super.key});

  @override
  DialogState<WriteTodoDialog> createState() => _WriteTodoDialogState();
}

// '+' 버튼 누른 후 textfield에 포커스가 갔을때 keyboard가 생성되는게 아니고
// '+' 버튼이 눌렸을때 현재 dlg가 생성되고 포커스가 textfield로 자동으로 이동 하고 keyboard가
// 자동 생성되도록
class _WriteTodoDialogState extends DialogState<WriteTodoDialog> with AfterLayoutMixin{
  DateTime _selectedDate = DateTime.now();
  final textController = TextEditingController();
  final node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BottomDialogScaffold(
      body: RoundedContainer(
        color: context.backgroundColor,
        child: Column(
          children: [
            Row(
              children: [
                '할일을 작성해 주세요.'.text.size(18).bold.make(),
                spacer,
                _selectedDate.formattedDate.text.size(18).make(),
                IconButton(
                    onPressed: _selectDate, icon: const Icon(Icons.calendar_month)),
              ],
            ),
            height20,
            Row(children: [
              Expanded(child: TextField(
                focusNode: node,
                controller: textController,

              )),
              RoundButton(text: '추가', onTap: (){
                widget.hide(WriteTodoResult(_selectedDate, textController.text));
              }),
            ],),
          ],
        ),
      ),
    );
  }

  void _selectDate() async{
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 265 * 10)),

    );

    if (date != null) {
      _selectedDate = date;
    }
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    AppKeyboardUtil.show(context, node);
  }
}

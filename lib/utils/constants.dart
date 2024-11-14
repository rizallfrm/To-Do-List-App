//lottie assets
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todolist_app/main.dart';
import 'package:todolist_app/utils/app_str.dart';

String lottieURL = 'assets/lottie.json';
String lottieURLsplash = 'assets/splash.json';
String lottieURLact = 'assets/act.json';

//button app  bar delete warning!
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'Anda harus mengisi semua kolom!',
      corner: 20.0,
      duration: 2000,
      padding: EdgeInsets.all(20));
}

//nothing entered when user try to edit or update the current task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'Anda harus mengedit tugas lalu memperbaruinya!',
      corner: 20.0,
      duration: 5000,
      padding: EdgeInsets.all(20));
}

//no task warning dialog for delete
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(context,
      title: AppStr.oopsMsg,
      message:
          "Tidak Ada Tugas Untuk Dihapus!\n Coba tambahkan beberapa lalu coba hapus!",
      buttonText: "Okay", onTapDismiss: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.warning);
}

//delete all task from DB dialog
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(context,
      title: AppStr.areYouSure,
      message:
          "Apakah Anda benar-benar ingin menghapus semua tugas? Anda tidak akan dapat membatalkan tindakan ini!",
      confirmButtonText: "Ya",
      cancelButtonText: "Tidak", onTapConfirm: () {
    //we will clear all box data using this command later us
    BaseWidget.of(context).dataStore.box.clear();
    Navigator.pop(context);
  }, onTapCancel: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.error, barrierDismissible: false);
}

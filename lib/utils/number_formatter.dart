String formatCurrency(num amount) {
  String numStr = amount.toStringAsFixed(0); // Chuyển đổi số thành chuỗi, không có phần thập phân
  String result = '';
  int count = 0;

  for (int i = numStr.length - 1; i >= 0; i--) {
    if (count != 0 && count % 3 == 0) {
      result = ',$result';
    }
    result = numStr[i] + result;
    count++;
  }

  return result;
}

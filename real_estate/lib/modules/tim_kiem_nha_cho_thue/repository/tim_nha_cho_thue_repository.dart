import 'package:real_estate/modules/nha_cho_thue/model/nha_cho_thue_model.dart';
import 'package:real_estate/modules/tim_kiem_nha_cho_thue/repository/tim_nha_cho_thue_api_provider.dart';

class TimNhaChoThueRepository {
  TimNhaChoThueApiProvider _apiProvider = TimNhaChoThueApiProvider();

  Future<NhaChoThueListModel> timNhaChoThue({
    String quan,
    String phuong,
    String duong,
    double dienTich,
    int min,
    int max,
    String thanhPho,
    String soLau,
    String lung,
    String ham,
    String sanThuong,
    String soPhong,
    String soWCR,
    String soWCC,
    String thangMay,
    String thoatHiem,
    String huongNha,
  }) async {
    return await _apiProvider.timNhaChoThue(
      quan: quan,
      phuong: phuong,
      duong: duong,
      dienTich: dienTich,
      min: min,
      max: max,
      thanhPho: thanhPho,
      soLau: soLau,
      lung: lung,
      ham: ham,
      sanThuong: sanThuong,
      soPhong: soPhong,
      soWCR: soWCR,
      soWCC: soWCC,
      thangMay: thangMay,
      thoatHiem: thoatHiem,
      huongNha: huongNha,
    );
  }
}

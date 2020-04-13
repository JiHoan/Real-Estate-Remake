import 'package:flutter/cupertino.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/call_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/nha_cho_thue_detail_model.dart';
import 'package:real_estate/modules/nha_cho_thue_dashboard/cap_nhat_thong_tin_co_ban/model/thong_tin_lien_he_model.dart';

import 'nha_cho_thue_detail_api_provider.dart';

class NhaChoThueDetailRepository {
  NhaChoThueDetailApiProvider _apiProvider = NhaChoThueDetailApiProvider();

  Future<NhaChoThueDetailModel> getNhaChoThueDetail({@required int id}) async {
    return await _apiProvider.getNhaChoThueDetail(id: id);
  }

  Future<bool> updateHienTrang({@required int id, @required String hienTrang, @required String sdt, @required String ten}) async {
    return await _apiProvider.updateHienTrang(id: id, hienTrang: hienTrang, sdt: sdt, ten: ten);
  }

  Future<bool> updateRow({@required String type, @required String obType, @required int id, @required String text}) async {
    return await _apiProvider.updateRow(type: type, obType: obType, id: id, text: text);
  }

  Future<bool> updateThongTinLienHe({@required ThongTinLienHeModel model, @required int id}) async {
    return await _apiProvider.updateThongTinLienHe(model: model, id: id);
  }

  Future<bool> updateDienTichKetCauNoiThat({@required NhaChoThueDetailModel model, @required int id}) async {
    return await _apiProvider.updateDienTichKetCauNoiThat(model: model, id: id);
  }

  Future<bool> updateVAT({@required NhaChoThueDetailModel model, @required int id}) async {
    return await _apiProvider.updateVAT(model: model, id: id);
  }

  Future<bool> removeHinhAnh({@required int id, @required List<int> banVeId}) async {
    return await _apiProvider.removeHinhAnh(id: id, banVeId: banVeId);
  }

  Future<bool> updateDiaChi({@required int id, @required String thanhPho, @required String quanHuyen, @required String phuongXa, @required String soNha, @required String tenDuong}) async {
    return await _apiProvider.updateDiaChi(id: id, thanhPho: thanhPho, quanHuyen: quanHuyen, phuongXa: phuongXa, soNha: soNha, tenDuong: tenDuong);
  }

  Future<bool> capNhatCall({@required int id, @required String status, @required String note}) async {
    return await _apiProvider.capNhatCall(id: id, status: status, note: note);
  }

  Future<CallLogsListModel> getCallLogs({@required int id}) async {
    return await _apiProvider.getCallLogs(id: id);
  }
}

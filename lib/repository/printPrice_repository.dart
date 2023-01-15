import '../models/printPrice_model.dart';
import '../services/database_services.dart';

class PrintPriceRepository{
  DatabaseServices service = DatabaseServices();
  String collectionReference = "printPrice";

  Future<List<PrintPriceModel>> retrievePrintPrice() async {
    var snapshot = await service.getData(collectionReference);

    return snapshot.docs.map(
      (docSnapshot) => PrintPriceModel.fromDocumentSnapshot(docSnapshot)
    ).toList();
  }

  Future<String> saveFile(file) {
    return service.addFile(file);
  }

  Future savePrintRequest(submittedPrintRequest) async {
    return await service.addData("cart", submittedPrintRequest);
  }

  updatePrintPrice(String documentID, PrintPriceModel submittedProduct) {
    service.updateData(collectionReference, documentID, submittedProduct);
  }
}
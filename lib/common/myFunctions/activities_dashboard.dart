import '../../backend/api_bridge.dart';
import '../../defaul_config.dart';

class Actividad {
  final String id;
  final String proyecto;
  final String accion;
  final String fecha;
  final String descripcion;
  final String observacion;

  Actividad({
    required this.id,
    required this.proyecto,
    required this.accion,
    required this.fecha,
    required this.descripcion,
    required this.observacion,
  });
}

Future<List<Actividad>> _populateTable() async {
  var results = await spData(sp: "get_actividades");
  List<Actividad> rowData = [];
  if (results[scc]) {
    Map<String, dynamic> myContent = results[cnt];
    for (var key1 in myContent.keys) {
      var value = myContent[key1];
      if (value["ESTADO"] == '0') {
        continue;
      }
      String id = value['ID'].toString();
      String proyecto = value['FK_PROYECTO'].toString();
      String accion = value['ACCION_TITLE'].toString();
      String fecha = value['FECHA'].toString();
      String descripcion = value['DESCRIPCION'].toString();
      String observacion = value['OBSERVACION'].toString();
      rowData.add(
        Actividad(
          id: id,
          proyecto: proyecto,
          accion: accion,
          fecha: fecha,
          descripcion: descripcion,
          observacion: observacion,
        ),
      );
    }
  } else {}
  return rowData;
}

Future<List<Map<String, dynamic>>> _getProjectChanges() async {
  var results = await spData(sp: "get_project_changes");
  List<Map<String, dynamic>> projectChanges = [];
  if (results[scc]) {
    Map<String, dynamic> myContent = results[cnt];
    for (var key in myContent.keys) {
      var value = myContent[key];
      String projectName = value['name'].toString();
      int changes = int.parse(value['changes'].toString());
      projectChanges.add({
        'name': projectName,
        'changes': changes,
      });
    }
  } else {
    print("No se logró pa");
  }
  return projectChanges;
}

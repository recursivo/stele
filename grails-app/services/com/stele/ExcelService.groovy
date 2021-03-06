package com.stele

import jxl.*

class ExcelService {

  def procesarFilas(FileInputStream archivoDeExcel) {
    WorkbookSettings ws = new WorkbookSettings();
    ws.setEncoding("Cp1252");
    Workbook workbook = Workbook.getWorkbook(archivoDeExcel, ws);
    Sheet sheet = workbook.getSheet(0)

    def contenidoDeFilas = []

    (2..sheet.getRows() - 1).each { fila ->
      contenidoDeFilas << sheet.getRow( fila )*.getContents()
    }

    contenidoDeFilas

  }

}

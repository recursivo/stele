jQuery(function ($) {
  'use strict';

  window.App = {
    init : function(){
      this.initCobroUnitario();
    },
    initCobroUnitario : function(){
      var selectors = {
        conceptoDePagoSelector: $('#conceptoDePago'),
        tabsSelector: $('a[href=#faq-tab-333],a[href=#faq-tab-444]'),
        fechaDeVencimientoSelector: $("#fechaDeVencimiento"), 
        cantidadDePagoSelector: $('#cantidadDePago'),
        tablaDeDescuentosSelector: $('div.descuentosDiv table')
      };
      this.cobroUnitario = new CobroUnitario(selectors);
    }
  };
  App.init();
});

window.CobroUnitario = (function() {

  CobroUnitario.prototype.conceptoDePago = '';
  CobroUnitario.prototype.importe = '';
  CobroUnitario.prototype.fecheDeVencimiento = '';
  CobroUnitario.prototype.maxItems = 10;
  CobroUnitario.prototype.paymentSchemas = [];
  CobroUnitario.prototype.tabs = '';
  CobroUnitario.prototype.tablaDeDescuentos = '';
  CobroUnitario.prototype.fechaDeVencimientoDescuento = ''; 

  function CobroUnitario(selectores){
    this.conceptoDePago = selectores.conceptoDePagoSelector;
    this.importe = selectores.cantidadDePagoSelector;
    this.fechaDeVencimiento = selectores.fechaDeVencimientoSelector;
    this.tabs = selectores.tabsSelector;
    this.tablaDeDescuentos = selectores.tablaDeDescuentosSelector;
    this.initDatePickerParaFechaDeVencimiento();
    this.initTypeaheadParaConceptos();
  }
  
  CobroUnitario.prototype.renderDiscountsTable = function(item){
    var source   = $("#descuento-template").html();
    var template = Handlebars.compile(source);
    var html = template(item.descuentos);
    $(".descuentosTableBody").append(html);
    this.initDatePickerParaDescuentos('expiracionDescuento');
  }

  CobroUnitario.prototype.setExpirationDateForDiscount = function(dueDate){
    if(dueDate.datepicker("getDate") != "Invalid Date"){  
      date = dueDate.datepicker("getDate");
      timeDiff = date.getTime() - new Date().getTime();
      diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
      $('#fechaDeVencimientoDesc').datepicker("setEndDate",(diffDays >= 0 ? "+"+diffDays : diffDays)+"d");
    }
  }
  
  CobroUnitario.prototype.initDatePickerParaDescuentos = function(className){
    this.fechaDeVencimientoDescuento = $('.'+className);
    this.fechaDeVencimientoDescuento.datepicker({
      format:"dd/mm/yy",
      language: "es",
      orientation: "top auto",
      autoclose:true
    }); 
  }
  CobroUnitario.prototype.initDatePickerParaFechaDeVencimiento = function(){
    that = this;

    this.fechaDeVencimiento.datepicker({
      format:"dd/mm/yy",
      language: "es",
      orientation: "top auto",
      todayHighlight: true,
      autoclose: true 
    }).on('changeDate',function(event){    
      if($(this).attr("class").indexOf("vencimiento") != -1){
        that.setExpirationDateForDiscount($(this)); 
        if($(this).datepicker("getDate") != "Invalid Date")
          that.tabs.parent().show();
        else
          that.tabs.parent().hide();
      }
    });
  }
  
  CobroUnitario.prototype.initTypeaheadParaConceptos = function(){
    that = this;

    this.conceptoDePago.typeahead({
      source: function( id, process ) {      
        var $direccion = $('#urlConcepto').val();
        var $url = $direccion+'/'+ id;
        that.fechaDeVencimiento.addClass("vencimiento");        
        that.tabs.parent().show();
        that.importe.val("");
        
        $(".descuentosDiv table, .porcentajeRecargo, .cantidadRecargo").addClass("hidden");        
        that.setExpirationDateForDiscount(that.fechaDeVencimiento);
        return $.getJSON(
          $url,
          function(data){
            that.paymentSchemas = data
            var concepts = [];
            $.each(data, function(index, item){
              concepts.push(item.value.concepto);
            });
           
            return process(concepts);
          }); 
      },
      items:10,
      updater: function (concept){
        $.each(that.paymentSchemas, function(i,item){
          if(item.value.concepto == concept){
            that.fechaDeVencimiento.removeClass("vencimiento");
            that.importe.val(item.cantidadDePago); 
            if(item.recargo != null)
              $("#idRecargo").val(item.recargo.id)
          
            if(item.recargo != null){
              if(item.recargo.cantidad != null){
                $("input.cantidadRecargo").val(item.recargo.cantidad);
                $(".cantidadRecargo").removeClass("hidden");
                $("input.porcentajeRecargo").val();
                $(".porcentajeRecargo").addClass("hidden");
              }
              else if(item.recargo.porcentaje != null){
                $("input.porcentajeRecargo").val(item.recargo.porcentaje);
                $(".porcentajeRecargo").removeClass("hidden");
                $("input.cantidadRecargo").val();
                $(".cantidadRecargo").addClass("hidden");
              }
            }
            else
              $('.porcentajeRecargo,.cantidadRecargo').addClass("hidden");

            $("#idsDescuentos").val(item.descuentosIds);
            that.tabs.parent().hide();
            $(".descuentosTableBody").html("");
            that.tablaDeDescuentos.removeClass("hidden"); 

            that.renderDiscountsTable(item);

            return;
          } 
        }); 
        return concept;
      }
    });

  }
  
  return CobroUnitario;

})();

window.CobroRecurrente = (function(){

  CobroRecurrente.prototype.conceptoDePagoRecurrente = '';
  CobroRecurrente.prototype.cantidadDePagoRecurrente = '';
  CobroRecurrente.prototype.diasVencimiento = '';
  CobroRecurrente.prototype.tabsDiv = '';
  CobroRecurrente.prototype.form = '';

  function CobroRecurrente(selectores){    
    this.conceptoDePagoRecurrente = selectores.conceptoDePagoRecurrenteSelector;
    this.diasVencimiento = selectores.diasVencimientoSelector;
    this.cantidadDePagoRecurrente = selectores.cantidadDePagoRecurrenteSelector;
    this.tabsDiv = selectores.tabsDivSelector;
    this.form = selectores.formSelector;
    this.initTypeaheadParaCobroRecurrente();    
    this.initExpirationDay();
    this.initActionFormMonths();
    this.initValidationsForTheForm();
  }

  CobroRecurrente.prototype.renderDiscountsTable = function(paymentScheme){    
    this.tabsDiv.hide();
    $(".discountsFromPaymentSchemaRecurrente").show();
    var source = $("#descuentoRecurrente-template").html();
    var template = Handlebars.compile(source);
    var html = template(paymentScheme.discounts);
    $(".cobroRecurrenteDescuentosTableBody").html(html);
    this.setExpirationDayForDiscount($(".diaVencimientoDescuento"),parseInt(this.diasVencimiento.val()));
    this.prepareInputsToValidate();
  }

  CobroRecurrente.prototype.setExpirationDayForDiscount = function(discount,expirationDay){    
    discount.each(function(){
      var firstItem = discount.find("option:eq(0)");
      $(this).html("");
      $(this).append(firstItem);
    });

    if(!isNaN(expirationDay)){      
      var source = $("#diaVencimiento-template").html();
      var template = Handlebars.compile(source);
       
      discount.each(function(){
        for(var i=1;i<=expirationDay;i++)
          $(this).append(template({number:i}));
       
        $(this).prop("disabled",false);
      });      
    }
    else{
      discount.each(function(){        
        $(this).prop("disabled",true);
      });
    }
  }

  CobroRecurrente.prototype.initExpirationDay = function(){
    var that = this;
    this.diasVencimiento.change(function(){
      that.setExpirationDayForDiscount($(".diaVencimientoDescuento"),parseInt($(this).val()));
    });
  }

  CobroRecurrente.prototype.showSurchargeFromPaymentSchema = function(paymentSchema){    
    
    if(paymentSchema.surcharge != null){

      $("#recargoRecurrente").val(paymentSchema.surcharge.id);
      $("div.recargosRecurrentesDiv table").removeClass("hidden");
      if(paymentSchema.surcharge.amount != null){
        $("p.cantidadRecargoRecurrente").text("\$"+paymentSchema.surcharge.amount);
        $(".cantidadRecargoRecurrente").removeClass("hidden");
        $("p.porcentajeRecargoRecurrente").text();
        $(".porcentajeRecargoRecurrente").addClass("hidden");
      }
      else if(paymentSchema.surcharge.percentage != null){ 
        $("p.porcentajeRecargoRecurrente").text("%"+paymentSchema.surcharge.percentage);
        $(".porcentajeRecargoRecurrente").removeClass("hidden");
        $("p.cantidadRecargoRecurrente").text();
        $(".cantidadRecargoRecurrente").addClass("hidden");
      }
      else
        $('.porcentajeRecargoRecurrente,.cantidadRecargoRecurrente').addClass("hidden");
    }

  }

  CobroRecurrente.prototype.initTypeaheadParaCobroRecurrente = function(){
    var that = this;
     
    this.conceptoDePagoRecurrente.typeahead({
      source: function( id, process ){
        var $direccion = $('#urlConcepto').val();
        var $url = $direccion+'/'+ id;        
        that.tabsDiv.show();     
        that.cantidadDePagoRecurrente.val("");
        $(".discountsFromPaymentSchemaRecurrente").hide();
        $(".discountsFromPaymentSchemaRecurrente .cobroRecurrenteDescuentosTableBody").html();
        $(".porcentajeRecargoRecurrente, .cantidadRecargoRecurrente").addClass("hidden");
      
        that.setExpirationDayForDiscount($(".diaVencimientoDescuento"),parseInt(that.diasVencimiento.val()));
      
        return $.getJSON(
          $url,
          function(data){
            that.paymentSchemas = data
            var concepts = [];
            $.each(data, function(index, item){
              concepts.push(item.value.description);
            });
           
            return process(concepts);
          }); 
      },
      items:10,
      updater: function(concept){
        $(".listaRecargosRecurrentes,.descuentosIdsRecurrente,.descuentoRecurrenteCreado").html("");
        $("#recargoRecurrente").val("");

        $.each(that.paymentSchemas, function(i,paymentSchema){
          if(paymentSchema.value.description == concept){
            that.cantidadDePagoRecurrente.val(paymentSchema.paymentAmount);
            that.showSurchargeFromPaymentSchema(paymentSchema);
            that.renderDiscountsTable(paymentSchema);
            return;
          }
        });
        return concept.trim();
      }
    });
  }

  CobroRecurrente.prototype.initActionFormMonths = function(){
    var that = this;
    $("input[type=checkbox]").click(function(){
      var months = [];
      var doublePayment = [];
      var sourceForMonths = $("#meses-template").html();
      var sourceForDoublePayment = $("#cobroDoble-template").html()
      

      var templateForMonths = Handlebars.compile(sourceForMonths);
      var templateForDoublePayment = Handlebars.compile(sourceForDoublePayment);

      $.each($("input[name=meses]:checked"),function(){
        months.push({mes:$(this).val()});
      });

      $.each($("input[name=pagoDoble]:checked"),function(){
        doublePayment.push({mes:$(this).val()});
      });

      var htmlForMonths = templateForMonths(months);
      var htmlForDoublePayment = templateForDoublePayment(doublePayment);

      $("div.meses").html(htmlForMonths);
      $("div.cobroDoble").html(htmlForDoublePayment);
    });
  }

  CobroRecurrente.prototype.prepareInputsToValidate = function(){
    if($(".cobroRecurrenteDescuentosTableBody select.diaVencimientoDescuento").size() > 0){

      $(".cobroRecurrenteDescuentosTableBody select.diaVencimientoDescuento").rules("add",{
        required:true,
        messages:{
          required:"Seleccione el día de vencimiento"
        }
      });
    }
  }
  
  CobroRecurrente.prototype.initValidationsForTheForm = function(){
    var that = this;
     
    this.form.validate({
      errorPlacement: function(error, element) {
        $(element).parents(".control-group").first().addClass("error");
        $(element).parents(".control-group").first().removeClass("success");
        error.addClass("help-inline");
        if($(element).parents(".input-prepend,.input-append").size() > 0){
          error.insertAfter(element.parent());
        }else{
          error.insertAfter(element);
        }
      },
      success: function(element) {
        $(element).parents(".control-group").first().addClass("success");
      },
      highlight: function(element, errorClass, validClass){
        $(element).parents(".control-group").first().addClass(errorClass).removeClass("success");
      },
      unhighlight: function(element, errorClass, validClass) {
        $(element).parents(".control-group").first().removeClass(errorClass).addClass(validClass);
      },
      rules:{
        'conceptoDePagoRecurrente':{
          required: true
        },
        'diasVencimientoPago':{
          required:true
        },
        'cantidadDePagoRecurrente':{
          required:true,
          number:true
        }        
      },
      messages:{
        'conceptoDePagoRecurrente':{
          required: "Escribe un concepto"
        },
        'diasVencimientoPago':{
          required: "Seleccione un día" 
        },
        'cantidadDePagoRecurrente':{
          required: "Ingresa un monto",
          number: "Escribe una cantidad valida"
        },
        validClass: "success",
        errorClass: "error", 
        errorElement: "span"
      }
    });     
  }

  return CobroRecurrente;

})();

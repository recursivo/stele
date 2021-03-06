window.DescuentoUnitario = (function(){

  DescuentoUnitario.prototype.fechaExpiracion = '';
  DescuentoUnitario.prototype.formulario = '';
  DescuentoUnitario.prototype.operacionDescuento = '';
 
  function DescuentoUnitario(selectores,operacionDescuento){
    this.fechaExpiracion = selectores.fechaExpiracion;
    this.formulario = selectores.formulario; 
    this.operacionDescuento = operacionDescuento;
    this.initDatePickerForFechaExpiracion();
    this.initDatePicker();
    this.initFormAction();
    this.initValidationsForFields();
  }

  DescuentoUnitario.prototype.initDatePickerForFechaExpiracion = function(){
    var that = this;
    this.fechaExpiracion.prop("disabled",true);    
    this.fechaExpiracion.datepicker({
      format:"dd/mm/yyyy",
      language: "es",
      orientation: "top auto",
      autoclose:true
    });

    this.fechaExpiracion.next().click(function(){          
      if(!that.fechaExpiracion.prop("disabled"))
        that.fechaExpiracion.datepicker("show");        
    });
  }

  DescuentoUnitario.prototype.initDatePicker = function(){
    var that = this; 
    this.fechaExpiracion.focus(function(){      
      if($(".fechaDeVencimiento").datepicker("getDate") == "Invalid Date")
        $(this).prop("disabled",true); 
    });
  }
  
  DescuentoUnitario.prototype.initFormAction = function(){    
    var that = this;
    this.formulario.submit(function(event){
      event.stopPropagation();
      that.fechaExpiracion.prop("disabled",false);
      return false; 
    });
  }

  DescuentoUnitario.prototype.initValidationsForFields = function(){
    var that = this;

    jQuery.validator.addMethod("expirationDateOrDay",(function(value,element,params){
      return (params[0].value != "" && element.value == "" || params[0].value == "" && element.value != "")
    }),"Seleccionar fecha o día de vencimiento");
   
    this.formulario.validate({
      errorPlacement: function(error, element) {
        $(element).parents(".control-group").first().addClass("error");
        $(element).parents(".control-group").first().removeClass("success");
        error.addClass("help-inline");
        if($(element).parents(".input-prepend,.input-append").size() > 0){
          error.insertAfter(element.parent());
        }
        else{
          error.insertAfter(element);
        }
      },
      success: function(element) {
        $(element).parents(".control-group").first().removeClass("error").addClass("success");
      },
      highlight: function(element, errorClass, validClass){
        $(element).parent().parent().parent().addClass(errorClass).removeClass(validClass);
      },
      unhighlight: function(element, errorClass, validClass) {
        $(element).parent().parent().parent().removeClass(errorClass).addClass(validClass);
      },
      rules: {
        'discountName': {
          required: true
        },
        'amount': {        
          number: true,
          onlyOne: this.operacionDescuento.porcentaje
        },
        'percentage':{
          number: true,
          onlyOne: this.operacionDescuento.cantidad
        },
        'previousDaysForCancelingDiscount':{
          expirationDateOrDay:that.fechaExpiracion          
        },
        'expirationDate':{          
          expirationDateOrDay:that.operacionDescuento.diasPreviosParaCancelarDescuento 
        }
      },
      messages: {
        'discountName': {
          required: "Escribe un concepto"
        },
        'amount':{
          required: "Escribe una cantidad",
          number: "Escribe una cantidad valida"
        }
      },
      submitHandler:function(){
        $.ajax({
          type: "POST",
          url:that.formulario.attr("action"),
          data:that.formulario.serialize()+"&referenceDate="+$("#fechaDeVencimiento").val(),
          success: function(data){
            $(".descuentoCreado").html(data);
            that.formulario.each(function(){
              this.reset();
            }); 
          }  
        }).then(function(){
          var discounts = $(".descuentoCreado input[name=discount]");
          $(".descuentosIdDiv").html(discounts);
        });
      },
        validClass: "success",
        errorClass: "error",
        errorElement: "span"
    });
  }

  return DescuentoUnitario;

})();

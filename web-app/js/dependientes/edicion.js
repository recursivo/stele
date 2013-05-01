// Generated by CoffeeScript 1.4.0

$(function() {
  var DependienteModel, DependienteView, Dependientes, DependientesView, usuarioDependientes, usuarioDependientesView;
  DependienteModel = Backbone.Model.extend({});
  DependienteView = Backbone.View.extend({
    tagName: 'li',
    render: function() {
      var context, html, template;
      template = Handlebars.compile(($("#dependienteCard")).html());
      context = {
        imagen: this.model.get('imagen'),
        matricula: this.model.get('matricula'),
        nombreCompleto: this.model.get('nombreCompleto'),
        nivel: this.model.get('nivel'),
        grado: this.model.get('grado'),
        grupo: this.model.get('grupo')
      };
      html = template(context);
      this.$el.html(html);
      return this;
    }
  });
  Dependientes = Backbone.Collection.extend({
    model: DependienteModel,
    url: function() {
      return "http://localhost:8080/stele/usuario/dependientes";
    }
  });
  DependientesView = Backbone.View.extend({
    tagName: 'ul',
    render: function() {
      this.collection.each(function(dependiente) {
        var dependienteView;
        dependienteView = new DependienteView({
          model: dependiente
        });
        return ($(this.el)).prepend(dependienteView.render().el);
      }, this);
      return this;
    }
  });
  usuarioDependientes = new Dependientes;
  usuarioDependientesView = new DependientesView({
    collection: usuarioDependientes
  });
  return usuarioDependientes.fetch({
    success: function(collection) {
      return ($('#dependienteContainer')).html(usuarioDependientesView.render().el);
    }
  });
});

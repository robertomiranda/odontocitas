class Odontocitas.Routers.OdontologosRouter extends Backbone.Router
  initialize: (options) ->
    @odontologos = new Odontocitas.Collections.OdontologosCollection()
    @odontologos.reset options.odontologos

  routes:
    "new"      : "newOdontologo"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newOdontologo: ->
    @view = new Odontocitas.Views.Odontologos.NewView(collection: @odontologos)
    $("#odontologos").html(@view.render().el)

  index: ->
    @view = new Odontocitas.Views.Odontologos.IndexView(odontologos: @odontologos)
    $("#odontologos").html(@view.render().el)

  show: (id) ->
    odontologo = @odontologos.get(id)

    @view = new Odontocitas.Views.Odontologos.ShowView(model: odontologo)
    $("#odontologos").html(@view.render().el)

  edit: (id) ->
    odontologo = @odontologos.get(id)

    @view = new Odontocitas.Views.Odontologos.EditView(model: odontologo)
    $("#odontologos").html(@view.render().el)
